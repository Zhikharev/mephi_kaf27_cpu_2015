/*
###########################################################
#
# Author: Gerasimchuk Aleksey
#
# Project: MEPHI CPU
# Filename: PC.v
# Descriptions:
#   
###########################################################
*/
module  PC(
	input clk,
	input reset,
	input [9:0] pc_in,
	input pcsrc,
	output [9:0] pc_out
	);

reg [9:0] pc_out_reg;
reg [9:0] pc_mux;

// always (posedge clk)
// begin
// 	case (pcsrc)
// 		1'b0: pc_mux = pc_out_reg + 2;
// 		2'b0: pc_mux = pcbranch;
// 	endcase;

always (posedge clk, posedge reset)
begin
	if reset
		pc_out_reg = 0;
	else
		pc_out_reg = pc_in;

assign pc_out = pc_out_reg;
endmodule
