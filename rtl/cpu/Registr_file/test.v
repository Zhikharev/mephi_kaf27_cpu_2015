`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:28:11 03/28/2015
// Design Name:   proverka
// Module Name:   C:/Documents and Settings/proverka/test.v
// Project Name:  proverka
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: proverka
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg reset;
	reg [4:0] reg_port1;
	reg [4:0] reg_port2;
	reg [4:0] write_reg;
	reg [31:0] data_in;
	reg we;

	// Outputs
	wire [31:0] reg_out1;
	wire [31:0] reg_out2;

	// Instantiate the Unit Under Test (UUT)
	proverka uut (
		.clk(clk), 
		.reset(reset), 
		.reg_port1(reg_port1), 
		.reg_port2(reg_port2), 
		.write_reg(write_reg), 
		.data_in(data_in),
		.we(we), 
		.reg_out1(reg_out1), 
		.reg_out2(reg_out2)
	);
initial begin
   forever begin
	 #10 clk = ~clk;
	
	
   end
end
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		reg_port1 = 0;
		reg_port2 = 0;
		write_reg = 0;
		we = 0;

		// Wait 100 ns for global reset to finish
		#10;
        reset = 1;
		  #20; reset = 0;
		// Add stimulus here
#20;
we = 1;
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;	
write_reg = 4'b0000;
data_in = 32'hff;	
#20;
we=0;	
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;

#20;	
reg_port1 = 4'b0000;	
reg_port2 = 4'b1000;

#100;	
#10;
we = 1;
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;
write_reg = 2'b0001;
data_in = 32'haa;
#120;
#20;
we = 0;
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;

	end
      
endmodule

