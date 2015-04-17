`ifndef SCOREBORD
`define SCOREBORD

class scorebord;
    mailbox #(trans) mb_dr2sb;
    mailbox #(trans) mb_mon2sb;
    trans fr_drv;
    trans fr_mon;
    bit err;
    
    function new (mailbox #(trans) mb_dr2sb_new, mailbox #(trans) mb_mon2sb);
        this.mb_dr2sb = mb_dr2sb_new;
        this.mb_mon2sb = mb_mon2sb_new;
    endfunction
    
    task write_drv();
        forever begin
            mb_dr2sb.get(fr_drv);
                
        end
    endtask
    
    task write_mon();
        forever begin
            mb_mon2sb.get(fr_mon);
            // don't understand how to make compaer 
        end
    endtask
    
    task start();
        fork 
            write_drv;
            write_mon;
        join        
        end
    endtask

task report();
		if (err) begin
			$display("//////////////////////////////////////////");
			$display(" ");
			$display(" ");
			$display("        %0d TESTS FAILED", err);
			$display(" ");
			$display(" ");
			$display("//////////////////////////////////////////");
		end
		else begin
			$display("********************************************");
			$display(" ");
			$display(" ");
			$display("ALL TESTS PASSED");
			$display(" ");
			$display(" ");
			$display("********************************************");
		end
	endtask


endclass




`endif
