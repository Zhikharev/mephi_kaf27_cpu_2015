`ifndef CHU_PAD_INTERFACE
`define CHU_PAD_INTERFACE

interface input_interface(input bit sys_clk);
	logic sys_rst;
	logic [2:0] alg;
	logic [31:0] data;
	logic sop; 
	logic eop; 
	logic val;
	
	clocking cb@(posedge sys_clk);
		output sys_rst;
		output eop;
		output data;
		output sop;
		output val;
		output alg;
	endclocking

	clocking mon @(posedge sys_clk);
		input eop;
		input data;
		input sop;
		input val;
		input alg;
	endclocking
endinterface

interface output_interface(input bit sys_clk, input logic sys_rst);
	logic [31:0] w [0:15];
	logic w_val [0:15];
	logic [7:0] mes_cnt;

	clocking mon@(posedge sys_clk);
		input w;
		input w_val;
		input mes_cnt;
	endclocking
endinterface 

`endif
