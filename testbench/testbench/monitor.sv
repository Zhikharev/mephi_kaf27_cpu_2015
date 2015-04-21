`ifndef MONITOR
`define MONITOR
class monitor;
    virtual wishbone mon_int;
    virtual control mon_control;
    mailbox #(trans) mb_mon2dr;
    trans inst;
    function new (virtual wishbone mon_int_new,virtual control mon_control_new,mailbox #(trans) mb_mon2sb);
        this.mon_int = mon_int_new;
        this.mon_control = mon_control_new;
        if (mb_mon2sb == null) begin
			$display("Monitor : Error - mailbox mb_mon2sb is empty");
			$finish;
		end
		else begin
			//this.mb_mon2sb = mb_mon2sb;
        end
    endfunction
    
    task get_trans();
       /* forever begin
            inst = new;
            inst = mon_int.data_in;
            model_controler;
            @(posedge mon_control.clk);
        end
        */
    endtask

    function model_control (trans inst);
            
    endfunction
  





endclass












`endif
