`ifndef DATA_DRIVER
`define DATA_DRIVER
class data_driver;
    virtual wishbone_if vif_instr;
    virtual wishbone_if vif_data;
    mailbox #(trans) mb_dr2dr; 
    
    function new (virtual wishbone_if vif_instr, virtual wishbone_if vif_data, mailbox #(trans) mb_dr2dr);
        this.vif_instr= vif_instr;
        this.vif_data = vif_data;
        this.mb_dr2dr = mb_dr2dr;    
    endfunction

    task start();
        forever begin
            if(!vif_data.drv.we_out) begin
                vif_data.drv.data_in <=  model :: get_memory(vif_data.drv.adr_out);
            end
            
        end
    endtask
     
     
     task run();
        $display("DATA DRIVER IS RAN %0t", $time);
        fork 
        start();
        join_any
     endtask



endclass


`endif
