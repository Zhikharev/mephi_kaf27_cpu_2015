`ifndef MONITOR
`define MONITOR
class monitor;
    virtual wishbone mon_int;
    virtual control mon_control;
    mailbox #(trans) mb_mon2dr;
    paket inst;
    function new (virtual wishbone mon_int_new,virtual control mon_control_new,mailbox #(paket) mb_mon2sb);
        this.mon_int = int_mon_new;
        this.mon_control = int_control_new;
        if (mb_mon2sb == null) begin
			$display("Monitor : Error - mailbox mb_mon2sb is empty");
			$finish;
		end
		else
			this.mb_mon2sb = mb_mon2sb;
    endfunction
    task get_trans();
        forever begin
            inst = new;
            inst = mon_int.data_in;
            inst.decode_inst;
            model_controler;
            @(posedge mon_control.clk)
        end
    function model_control (bit[15:0] inst)
        //call model's functions
    endfunction
        
    endtask




















`endif
