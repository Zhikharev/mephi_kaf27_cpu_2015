/*
###########################################################
#
# Author: Grigoriy Zhiharev 
#
# Project: MEPHI CPU
# Filename: mc_top.v
# Descriptions:
# 	DDR controller have 3 ports: one only rd for cpu_inst,
# 	second rd/wr for cpu_data and third rd/wr for IO. 
# 	Only one direction memory request is alloweded for IO.
###########################################################
*/

module mc_top (
	input sys_clk,
	input sys_rst,

	// CPU instruction interface
	input    		cpu_inst_stb_i,
	output 	 		cpu_inst_ack_o, 
	input 	[?] 	cpu_inst_addr_i,
	output  [15:0] 	cpu_inst_data_o,


	// CPU data memory interface
	input    		cpu_data_stb_i,
	input  			cpu_data_we_i,
	output 	 		cpu_data_ack_o, 
	input 	[?] 	cpu_data_addr_i,
	input   [15:0]  cpu_data_data_i
	output  [15:0] 	cpu_data_data_o,

	// IO inteface
	output    		io_stb_o,
	input           io_stb_i,
	output          io_ack_o,
	input 	 		io_ack_i,
	output          io_we_o,
	input           io_we_i,
	input   [?] 	io_addr_i,
	output  [?]  	io_addr_o
	input  [15:0] 	io_data_i,
	output [15:0] 	io_data_o
);

endmodule