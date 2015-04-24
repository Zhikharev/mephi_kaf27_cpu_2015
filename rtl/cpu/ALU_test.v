`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:58:52 04/23/2015
// Design Name:   alu
// Module Name:   C:/Documents and Settings/CU/ALU_test.v
// Project Name:  CU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_test;

	// Inputs
	reg clk;
	reg [31:0] sr1;
	reg [31:0] sr2;
	reg [2:0] os;
	reg [5:0] shift;

	// Outputs
	wire [31:0] rd;
	wire zeroflag;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.clk(clk), 
		.sr1(sr1), 
		.sr2(sr2), 
		.os(os), 
		.shift(shift), 
		.rd(rd), 
		.zeroflag(zeroflag)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		sr1 = 0;
		sr2 = 0;
		os = 0;
		shift = 0;

		forever begin
	    #10 clk = ~clk;
		 end
	end
	initial begin
		// Wait 100 ns for global reset to finish
		//#10;
		//reset = 1;
		//#10;
		//reset = 0;
		#100;
     sr1 = 32'h9;
     sr2 = 32'h1;
     #20;
os = 3'b0;
#40;
os = 3'b1;
#40;
os = 3'b010;
#40;
os = 3'b011;
#40;
os = 3'b100;
#40;
shift = 32'b10;
os = 3'b101;
#40;
shift = 32'b10;
os = 3'b110;
#40;
os = 3'b111; 	  
		// Add stimulus here

	end
      
      
endmodule

