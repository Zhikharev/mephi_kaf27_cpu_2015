`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:32:38 04/22/2015
// Design Name:   UC
// Module Name:   C:/Documents and Settings/CU/UC_test.v
// Project Name:  CU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module UC_test;

	// Inputs
	reg [15:0] instr;
	reg zero;
   reg clk;
	// Outputs
	wire rf_hl;
	wire result_hl;
	wire [1:0] pc_direct_ch;
	wire stb_o;
	wire [5:0] alu_shift;
	wire write_ch;
	wire result_ch;
	wire [3:0] write_addr;
	wire [1:0] pc_mux;
	wire mem_we;
	wire [2:0] alu_control;
	wire [31:0] alu_datain;
	wire [3:0] read_addr;
	wire read_ch;
	wire rf_we;
	wire rf_datain;

	// Instantiate the Unit Under Test (UUT)
	UC uut (
	   .clk(clk),
		.instr(instr), 
		.zero(zero), 
		.rf_hl(rf_hl), 
		.result_hl(result_hl), 
		.pc_direct_ch(pc_direct_ch), 
		.stb_o(stb_o), 
		.alu_shift(alu_shift), 
		.write_ch(write_ch), 
		.result_ch(result_ch), 
		.write_addr(write_addr), 
		.pc_mux(pc_mux), 
		.mem_we(mem_we), 
		.alu_control(alu_control), 
		.alu_datain(alu_datain), 
		.read_addr(read_addr), 
		.read_ch(read_ch), 
		.rf_we(rf_we), 
		.rf_datain(rf_datain)
	);

	initial begin
	   forever begin
		   #10 clk=~clk;
		end
		end
initial begin		
		// Initialize Inputs
		instr = 0;
		zero = 0;

		// Wait 100 ns for global reset to finish
		#100;
instr = 16'b0000000000000000;
#20;
instr = 16'b0000111100001111;
#20;
instr = 16'b0001111100001111;
#20;
instr = 16'b0010111100001111;
#20;
instr = 16'b0011111100001111;
#20;
instr = 16'b0100111100001111;

		// Add stimulus here

	end
      
endmodule

