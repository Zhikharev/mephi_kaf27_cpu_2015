`ifndef MONITOR_INST
`define MONITOR_INST

class instr_monitor;
    virtual wishbone_if vif;
    mailbox #(trans) mb_imon2sb;
    mailbox #(trans) mb_mon2mon;
     
    function new (virtual wishbone_if vif,mailbox #(trans) mb_mon2mon, mailbox #(trans) mb_imon2sb);
        this.vif = vif;
        if (mb_imon2sb == null) begin
			$display("INSTR MONITOR : ERROR - mailbox mb_mon2sb is empty");
		end
		else begin
			this.mb_imon2sb = mb_imon2sb;
        end
        if(mb_mon2mon == null)begin
            $display("INSTR MONITOR : ERRRO - mailbox mb_mon2mon is empty");
        end
        this.mb_mon2mon = mb_mon2mon;
    endfunction
    
    task get_trans();
        forever begin
            @(vif.mon);
            if(!vif.rst) begin
                if(vif.mon.akn_in) begin
                     //model :: decode(vif.drv.data_in,1);
                    
                end
            end         
         end   
    endtask

    task run();
        $display("INSTR MONITOR IS RAN :%0t", $time);
        get_trans();
    endtask
endclass
`endif
