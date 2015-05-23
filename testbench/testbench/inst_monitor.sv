`ifndef MONITOR_INST
`define MONITOR_INST


class instr_monitor;
    virtual wishbone_if vif;
    trans instr_for_decode;
    mailbox #(trans) mb_imon2sb;
    mailbox #(trans) mb_mon2mon;
    bit[1:0] log_flag; 
    localparam FULL_LOG = 2'b11;
    localparam NON_LOG = 2'b00;
    localparam EX_LOG = 2'b10;
    localparam MAIN_LOG = 2'b01;
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
        instr_for_decode = new();
    endfunction
    
    task get_trans();
        forever begin
            @(vif.mon);
            if(!vif.rst) begin
                if(vif.mon.akn_in) begin
                     model :: decode(vif.mon.data_in,1);
                    if(log_flag inside{FULL_LOG,EX_LOG,MAIN_LOG})begin
                        $display(" INSTR MONITOR : got instraction ----------- %0b on %0t",vif.mon.data_in,$time);
                        instr_for_decode.title = "INSTR MONITOR";
                        instr_for_decode.decode(vif.mon.data_in);
                        instr_for_decode.d_print;
                    end
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
