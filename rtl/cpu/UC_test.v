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
	reg ZERO;
   reg clk;
	// Outputs
	wire RF_HL;
	wire RESULT_HL;
	wire [1:0] PC_DIRECT_CH;
	wire STB_O;
	wire [5:0] ALU_SHIFT;
	wire WRITE_CH;
	wire RESULT_CH;
	wire [3:0] WRITE_ADDR;
	wire [1:0] PC_MUX;
	wire MEM_WE;
	wire [2:0] ALU_CONTROL;
	wire [31:0] ALU_DATAIN;
	wire [3:0] READ_ADDR;
	wire READ_CH;
	wire RF_WE;
	wire RF_DATAIN;

	// Instantiate the Unit Under Test (UUT)
	UC uut (
	   .clk(clk),
		.instr(instr), 
		.ZERO(ZERO), 
		.RF_HL(RF_HL), 
		.RESULT_HL(RESULT_HL), 
		.PC_DIRECT_CH(PC_DIRECT_CH), 
		.STB_O(STB_O), 
		.ALU_SHIFT(ALU_SHIFT), 
		.WRITE_CH(WRITE_CH), 
		.RESULT_CH(RESULT_CH), 
		.WRITE_ADDR(WRITE_ADDR), 
		.PC_MUX(PC_MUX), 
		.MEM_WE(MEM_WE), 
		.ALU_CONTROL(ALU_CONTROL), 
		.ALU_DATAIN(ALU_DATAIN), 
		.READ_ADDR(READ_ADDR), 
		.READ_CH(READ_CH), 
		.RF_WE(RF_WE), 
		.RF_DATAIN(RF_DATAIN)
	);

	initial begin
	   forever begin
		   #10 clk=~clk;
		end
		end
initial begin		
		// Initialize Inputs
		instr = 0;
		ZERO = 0;

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

