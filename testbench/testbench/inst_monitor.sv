`ifndef MONITOR_INST
`define MONITOR_INST

class instr_monitor;
    virtual wishbone_if vif;
    mailbox #(trans) mb_imon2sb;
    mailbox #(bit[15:0]) mb_mon2mon;
     
    function new (virtual wishbone_if vif,mailbox #(bit[15:0]) mb_mon2mon, mailbox #(trans) mb_imon2sb);
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
        bit[15:0] instr;
        forever begin
            @(vif.mon);
            if(!vif.rst) begin
                if(vif.mon.akn_in) begin
                    instr = vif.mon.data_in;
                    mb_mon2mon.put(instr);
                    model :: DECODE(instr);                
                    //load_wotcher(instr);
                    
                end
            end         
         end   
    endtask

    task run();
        $display("INSTR MONITOR IS RAN :%0t", $time);
        get_trans();
    endtask
   
   /* task load_wotcher(bit[15:0] item);
        if(item inside{6'b100100,6'b100111})begin
            //vif.mon.data_in = mode :: GETMEM(instr[15:6]) //or send to dr2mon int
            
        end
    
    endtask
*/    
endclass
`endif
