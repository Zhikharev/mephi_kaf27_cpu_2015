`ifndef MONITOR_INST
`define MONITOR_INST

class monitor_inst;
    virtual wishbone_if vif;
    mailbox #(trans) mb_mon2sb;
     
    function new (virtual wishbone_if vif,mailbox #(trans) mb_mon2sb);
        this.vif = vif;
        if (mb_mon2sb == null) begin
			$display("Monitor : Error - mailbox mb_mon2sb is empty");
			//$finish;
		end
		else begin
			this.mb_mon2sb = mb_mon2sb;
        end
    endfunction
    
    task get_trans();
        bit[15:0] inst;
        forever begin
            @(vif.mon);
            if(!vif.mon.rst) begin
                if(vif.mon.akn_in) begin
                    inst = vif.mon.data_in;
                    
                    model :: DECODE(inst);                
                end
                
            end         
         end   
    endtask

    




endclass












`endif
