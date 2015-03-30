`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:03:47 03/26/2015 
// Design Name: 
// Module Name:    rom 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module rom
	#(
	parameter PC_W = 30
	)
	
	(
	input [PC_W-1:0] rom_pc,

	output [15:0] rom_instrution
    );

assign instruction = ({PC_W{pc == 30'h00000000}} & 16'b0101110011001101) |
                     ({PC_W{pc == 30'h00000002}} & 16'b0001010011001110) |
                     ({PC_W{pc == 30'h00000004}} & 16'b1001001000000000) |
							({PC_W{pc == 30'h00000006}} & 16'b1001101000000000) |
                     ({PC_W{pc == 30'h00000008}} & 16'b1000110110101110) |
							({PC_W{pc == 30'h0000000A}} & 16'b1011000000000000) |
							({PC_W{pc == 30'h0000000C}} & 16'b1011100000001110);
endmodule
