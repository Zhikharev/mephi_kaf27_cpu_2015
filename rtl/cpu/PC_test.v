`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:59:19 04/23/2015
// Design Name:   PC
// Module Name:   C:/Documents and Settings/CU/PC_test.v
// Project Name:  CU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PC_test;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] PC_MUX;
	reg [1:0] PC_DIRECT_CH;
	reg [31:0] PC_rd;
	reg [31:0] RESULT;
	reg [15:0] instr;

	// Outputs
	wire [9:0] PC;
	wire [9:0] PC_2;

	// Instantiate the Unit Under Test (UUT)
	PC uut (
	   .reset(reset),
		.clk(clk), 
		.PC_MUX(PC_MUX), 
		.PC_DIRECT_CH(PC_DIRECT_CH), 
		.PC_rd(PC_rd), 
		.RESULT(RESULT), 
		.instr(instr), 
		.PC(PC), 
		.PC_2(PC_2)
	);

initial begin
   forever begin
	   #10 clk=~clk;
	end
end

	initial begin
		// Initialize Inputs
		clk = 0;
		PC_MUX = 0;
		PC_DIRECT_CH = 0;
		PC_rd = 0;
		RESULT = 0;
		instr = 0;

		// Wait 100 ns for global reset to finish
		#100;
#20;
reset = 1;
#20;
reset = 0;		
#20;
PC_MUX = 2'b10;        
#20;
PC_MUX = 2'b10;        
#20;
PC_MUX = 2'b00;        
#20;
instr = 16'b0000101111111111;
PC_MUX = 2'b01;        
PC_DIRECT_CH = 2'b01;
#20;
instr = 16'b0000101111111111;
PC_MUX = 2'b01;     
RESULT = 32'hFFFF;   
PC_DIRECT_CH = 2'b00;
#20;
instr = 16'b0000101111111111;
PC_MUX = 2'b01;        
PC_DIRECT_CH = 2'b10;



	end
      
endmodule

