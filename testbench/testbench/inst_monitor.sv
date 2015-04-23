`ifndef MONITOR_INST
`define MONITOR_INST

class inst_monitort;
    virtual wishbone_if vif;
    virtual inner_if inner_vif;
    mailbox #(trans) mb_mon2sb;
     
    function new (virtual wishbone_if vif,virtual inner_if inner_vif, mailbox #(trans) mb_mon2sb);
        this.vif = vif;
        this.inner_vif = inner_vif;
        if (mb_mon2sb == null) begin
			$display("Monitor : Error - mailbox mb_mon2sb is empty");
			//$finish;
		end
		else begin
			this.mb_mon2sb = mb_mon2sb;
        end
    endfunction
    
    task get_trans();
        bit[15:0] instr;
        forever begin
            @(vif.mon);
            if(!vif.mon.rst) begin
                if(vif.mon.akn_in) begin
                    instr = vif.mon.data_in;
                    inner_vif.mon2mon=instr;/// for comparing addres in instraction end adr_out at data interface
                    // don't know maybe above string mast be done with the mailbox
                    model :: DECODE(instr);                
                    load_wotcher(instr);
                    
                end
                
            end         
         end   
    endtask

    task load_wotcher(bit[15:0] item);
        if(item inside{6'b100100,6'b100111})begin
            //vif.mon.data_in = mode :: GETMEM(instr[15:6]/*ADDR*/) //or send to dr2mon int
            
        end
    
    endtask




endclass












`endif
