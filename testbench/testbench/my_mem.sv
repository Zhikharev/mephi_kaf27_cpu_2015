`ifndef MY_MEM
`define MY_MEM

class mem_data_drv;
    /*
    virtual wishbone_if vif_data;
    virtual tb_control_if vif_tb;
    logic [31:0] memorry [1023:0];
    
    function new (virtual wishbone_if vif_data, virtual tb_control_if vif_tb);
        this.vif_data = vif_data;
        this.vif_tb = vif_tb;        
    endfunction
    
    task regular_work ();
        forever begin
        @(vif_data.drv)
            if(!vif_data.drv.we_out) begin
                vif_data.drv.data_in = memorry[vif_data.drv.adr_out];
            end            
            else begin
                if(vif_data.drv.stb_out) begin
                    memorry[vif_data.drv.adr_out] = vif_data.drv.data_out;
                end
            end   
        end
    endtask 
    
    task get_mem ();
        forever begin 
           vif_tb.data_out = memorry[vif_tb.addr_in];
        end
    endtask    
    
    task run ();
        regular_work;
        get_mem;
    endtask*/
endclass 




`endif
