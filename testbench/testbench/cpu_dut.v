module cpu (
	input CLK_I,
	input RST_I,
	input [15:0] DAT_I,
	output[15:0] ADR_O,
	output [15:0] DAT_O,
	input [15:0] INSTR_I,
	output WE_O,
	input AKN_I,
	output STB_O
	);
endmodule       
