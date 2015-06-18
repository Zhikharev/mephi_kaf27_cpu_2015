/*
###########################################################
#
# Author: Gerasimchuk Aleksey
#
# Project: MEPHI CPU
# Filename: RF.v
# Descriptions:
#   
###########################################################
*/
module  RF(
	input clk,
	input reset,
	input [4:0] ra1,
	input [4:0] ra2,
	input [4:0] ra3,
	input [31:0] wd3,
	input we3,
	output [31:0] rd1,
	output [31:0] rd2
	);

reg [31:0] rf [0:15];

always (posedge clk)
begin
	if reset
		for (i = 0; i <16, i = i + 1)
			begin
				rf[i] <= 0;
			end
	else
		if we3
			rf [wa3] <= wd3;
end

assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule
