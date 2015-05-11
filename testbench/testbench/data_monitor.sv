`ifndef DATA_MONITOR
`define DATA_MONITOR

class data_monitor;
    virtual wishbone_if vif;//data
    mailbox #(trans) mb_mon2mon;
    mailbox #(trans) mb_dmon2sb;
    int log_flag;    
     
    function new (virtual wishbone_if vif, mailbox #(trans) mb_mon2mon, mailbox #(trans) mb_dmon2sb);
        this.vif = vif;
        if (mb_dmon2sb == null) begin
			$display("INSTR MONITOR : Error - mailbox mb_mon2sb is empty");
		end
		else begin
			this.mb_dmon2sb = mb_dmon2sb;
        end
        if(mb_mon2mon == null)begin
            $display("INST MONITOR : ERROR - mailbox mb_mon2mon is empty");
        end
        else begin
            this.mb_mon2mon = mb_mon2mon;
        end
        
    endfunction
   
   
    
    task start();
        forever begin
            @(vif.mon);
            if(!vif.rst) begin
                if(vif.mon.stb_out) begin
                    if(vif.mon.stb_out) begin
                        model :: set_memory(vif.mon.adr_out,vif.mon.data_out);
                    end
                end
                
            end         
         end   
    endtask

    

    
    task run();
        $display("DATA MONITOR IS RAN %0t", $time);
        start;
    endtask

endclass




`endif

