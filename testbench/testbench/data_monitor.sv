`ifndef DATA_MONITOR
`define DATA_MONITOR

class data_monitor;
    virtual wishbone_if vif;
    mailbox #(bit[15:0]) mb_mon2mon;
    mailbox #(trans) mb_dmon2sb;
    
     
    function new (virtual wishbone_if vif, mailbox #(bit[15:0]) mb_mon2mon, mailbox #(trans) mb_dmon2sb);
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
   
   
    
    task adr_cont();
        bit[9:0] addr_out;
        forever begin
            @(vif.mon);
            if(!vif.rst) begin
                if(vif.mon.akn_in) begin
                     //if(!(store_wotcher == -1))begin
                     //end
                end
                
            end         
         end   
    endtask

    function int store_wotcher ();
        bit[9:0] addr;
        bit[15:0] instr;
        mb_mon2mon.try_get(instr);
        //this.instr=instr;
        if(instr[5:0] == 6'b101001 && 6'b101011) begin
            addr = instr[15:6];
            return addr;
        end
        return -1;
    endfunction


    
    task run();
        $display("DATA MONITOR IS RAN %0t", $time);
        adr_cont();
    endtask

endclass




`endif

