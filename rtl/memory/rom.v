/*
###########################################################
#
# Author:
#
# Project: MEPHI CPU
# Filename: rom.v
# Descriptions:
#
###########################################################
*/
module rom
#(
	parameter AW = 16
)
	
(
	input               sys_clk,
	input               sys_rst,
	input   [AW-1:0]    addr_i,
	output  [15:0]      data_o
);

	reg [15:0] rom [0:6];
	wire [3:0] addr;

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
		else begin
			rom <= rom;
		end
	end

	assign addr = addr_i >> 1;
	assign data_o = rom[addr];
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
