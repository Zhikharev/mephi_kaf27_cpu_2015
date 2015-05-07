`ifndef DATA_DRIVER
`define DATA_DRIVER
class data_driver;
    virtual wishbone_if vif_instr;
    virtual wishbone_if vif_data;
    mailbox #(trans) mb_dr2dr; 
    
    function new (virtual wishbone_if vif_instr, virtual wishbone_if vif_data, mailbox #(trans) mb_dr2dr);
        this.vif_instr= vif_instr;
        this.vif_data = vif_data;
        if(mb_dr2dr == null)begin
            $display("DATA DRIVER : ERROR mailbox dr2dr is empty");
        end
        else begin
            this.mb_dr2dr = mb_dr2dr;    
        end
    endfunction

    task start();
        forever begin
            @(vif_data.drv);
            if(!vif_data.drv.we_out) begin
                vif_data.drv.data_in <=  model :: get_memory(vif_data.drv.adr_out);
            end  
        end
    endtask
     
     
     task run();
        $display("DATA DRIVER IS RAN %0t", $time);
        start();
     endtask



endclass


`endif
