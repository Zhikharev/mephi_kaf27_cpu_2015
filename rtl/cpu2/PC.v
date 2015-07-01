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
	output [9:0] pc_out
	);

reg [9:0] pc_reg;
reg [9:0] pc_mux;

always @(posedge clk)
begin
		pc_reg <= pc_in;
		if (reset == 1)
			pc_reg <= 10'b0;
end

assign pc_out = pc_reg;
endmodule
