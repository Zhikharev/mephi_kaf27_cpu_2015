`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:59:19 04/23/2015
// Design Name:   pc
// Module Name:   C:/Documents and Settings/CU/pc_test.v
// Project Name:  CU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pc_test;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] pc_mux;
	reg [1:0] pc_direct_ch;
	reg [31:0] pc_rd;
	reg [31:0] result;
	reg [15:0] instr;

	// Outputs
	wire [9:0] pc;
	wire [9:0] pc_2;

	// Instantiate the Unit Under Test (UUT)
	pc uut (
	   .reset(reset),
		.clk(clk), 
		.pc_mux(pc_mux), 
		.pc_direct_ch(pc_direct_ch), 
		.pc_rd(pc_rd), 
		.result(result), 
		.instr(instr), 
		.pc(pc), 
		.pc_2(pc_2)
	);

initial begin
   forever begin
	   #10 clk=~clk;
	end
end

	initial begin
		// Initialize Inputs
		clk = 0;
		pc_mux = 0;
		pc_direct_ch = 0;
		pc_rd = 0;
		result = 0;
		instr = 0;

		// Wait 100 ns for global reset to finish
		#100;
#20;
reset = 1;
#20;
reset = 0;		
#20;
pc_mux = 2'b10;        
#20;
pc_mux = 2'b10;        
#20;
pc_mux = 2'b00;        
#20;
instr = 16'b0000101111111111;
pc_mux = 2'b01;        
pc_direct_ch = 2'b01;
#20;
instr = 16'b0000101111111111;
pc_mux = 2'b01;     
result = 32'hFFFF;   
pc_direct_ch = 2'b00;
#20;
instr = 16'b0000101111111111;
pc_mux = 2'b01;        
pc_direct_ch = 2'b10;



	end
      
endmodule

