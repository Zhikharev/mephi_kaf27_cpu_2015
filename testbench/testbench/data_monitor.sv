`ifndef DATA_MONITOR
`define DATA_MONITOR

class data_monitor;
    virtual wishbone_if vif;//data
    mailbox #(trans) mb_mon2mon;
    mailbox #(trans) mb_dmon2sb;
    bit[1:0] log_flag;
    
    localparam FULL_LOG = 2'b11;
    localparam NON_LOG = 2'b00;
    localparam EX_LOG = 2'b10;
    localparam MAIN_LOG = 2'b01;    
     
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
                        if(log_flag inside{FULL_LOG,MAIN_LOG,EX_LOG}) begin
                        $display("DATA MONITOR : sending data valye is %0h(%0d)",vif.mon.data_out,vif.mon.data_out);
                        $display("DATA MONITOR : sending adress valye is %0h(%0d)",vif.mon.adr_out,vif.mon.adr_out);
                        $display("DATA MONITOR : reterned valye of memory cell %0h(...)",model :: get_memory(vif.mon.adr_out));
                        end
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

