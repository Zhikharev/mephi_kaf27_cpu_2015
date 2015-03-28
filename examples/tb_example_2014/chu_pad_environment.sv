`ifndef CHU_PAD_ENVIRONMENT
`define CHU_PAD_ENVIRONMENT

class environment;
	virtual input_interface input_intf;
	virtual output_interface output_intf;
	driver drv;
	monitor mon;
	scoreboard sb;
	mailbox #(packet) mb_drv2sb;
	mailbox #(packet) mb_mon2sb;

	function new(virtual input_interface input_intf_new, virtual output_interface output_intf_new);
		this.input_intf = input_intf_new;
		this.output_intf = output_intf_new;
	endfunction

	function build();
		$display("Environment : start od BUILD. %0t", $time);
		mb_drv2sb = new();
		mb_mon2sb = new();
		sb = new(mb_drv2sb, mb_mon2sb);
		drv = new(input_intf, mb_drv2sb);
		mon = new(output_intf, input_intf, mb_mon2sb);
		$display("Environemnt : end of BUILD. %0t", $time);
	endfunction
		
	task start();
		$display("Environemnt : start of START. %0t",$time);
		fork
			drv.start();
			mon.start();
			sb.start();
		join_any
		$display("Environemnt : end of start() method. %0t",$time);
	endtask

	task reset();
		$display("Environment : start of RESET. %0t", $time);
		input_intf.sys_rst <= 1;
		repeat(5) @(posedge input_intf.sys_clk);
		input_intf.eop <= 0;
		input_intf.data <= 0;
		input_intf.sop <= 0;
		input_intf.val <= 0;
		input_intf.alg <= 0;
		input_intf.sys_rst <= 0;
		$display("Environment : end of RESET. %0t", $time);
	endtask

	task wait_for_end();
		$display("Environment : start of WAIT_FOR_END. %0t", $time);
		repeat(10000) @(input_intf.sys_clk);
		$display("Environment : end of WAIT_FOR_END. %0t", $time);
	endtask

	task run();
		$display("Environment : start of RUN. %0t", $time);
		reset();
		start();
		wait_for_end();
		report();
		$display("Environment : end of RUN. %0t", $time);
	endtask

	task report();
		sb.report();
	endtask

endclass

`endif
