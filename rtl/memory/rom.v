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
	input sys_clk,
	input sys_rst,
	input [PC_W-1:0] rom_pc,
	output [15:0] rom_instrution
);

	reg [15:0] rom [0:6];

	always @(posedge sys_clk, posedge sys_rst) begin
		if(sys_rst) begin
			rom[0] <= 16'b0101110011001101;
            rom[1] <= 16'b0001010011001110;
            rom[2] <= 16'b1001001000000000;
			rom[3] <= 16'b1001101000000000;
            rom[4] <= 16'b1000110110101110;
		 	rom[5] <= 16'b1011000000000000; 
		 	rom[6] <= 16'b1011100000001110;
		end
		/*
		else begin
			rom <= rom;
		end
		*/
	end

	assign rom_instrution = rom[rom_pc];
/*
assign rom_instruction = ({16{pc == 30'h00000000}} & 16'b0101110011001101) |
                         ({16{pc == 30'h00000002}} & 16'b0001010011001110) |
                         ({16{pc == 30'h00000004}} & 16'b1001001000000000) |
					     ({16{pc == 30'h00000006}} & 16'b1001101000000000) |
                         ({16{pc == 30'h00000008}} & 16'b1000110110101110) |
					 	 ({16{pc == 30'h0000000A}} & 16'b1011000000000000) |
					 	 ({16{pc == 30'h0000000C}} & 16'b1011100000001110);
*/
endmodule
