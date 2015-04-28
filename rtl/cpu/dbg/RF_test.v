`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:04:00 04/24/2015
// Design Name:   RF
// Module Name:   C:/Documents and Settings/CU/RF_test.v
// Project Name:  CU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RF
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RF_test;

	// Inputs
	reg clk;
	reg reset;
	reg RF_HL;
	reg [3:0] reg_port1;
	reg [3:0] reg_port2;
	reg [3:0] write_reg;
	reg [31:0] data_in;
	reg we;

	// Outputs
	wire [31:0] reg_out1;
	wire [31:0] reg_out2;
	wire [31:0] reg_out3;

	// Instantiate the Unit Under Test (UUT)
	RF uut (
		.clk(clk), 
		.reset(reset), 
		.RF_HL(RF_HL), 
		.reg_port1(reg_port1), 
		.reg_port2(reg_port2), 
		.write_reg(write_reg), 
		.data_in(data_in), 
		.we(we), 
		.reg_out1(reg_out1), 
		.reg_out2(reg_out2), 
		.reg_out3(reg_out3)
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
		RF_HL = 0;
		reg_port1 = 0;
		reg_port2 = 0;
		write_reg = 0;
		data_in = 0;
		we = 0;

		// Wait 100 ns for global reset to finish
		
        
		// Add stimulus here
#10;
reset = 1;
#20; 
reset = 0;
#20;
we = 0;
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;	
write_reg = 4'b0000;

#40;
RF_HL = 0;
we = 1;
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;	
write_reg = 4'b0001;
data_in = 32'hffffffff;	

#40;
we = 0;
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;	
write_reg = 4'b0001;

#40;
RF_HL = 1;
we = 1;
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;	
write_reg = 4'b0001;
data_in = 32'hffffffff;	

#40;
we = 0;
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;	
write_reg = 4'b0001;


#40;
RF_HL = 1;
we = 1;
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;	
write_reg = 4'b1001;
data_in = 32'haaaaaaaa;	

#120;
we=0;	
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;
write_reg = 4'b1001;

#40;
RF_HL = 0;
we = 1;
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;	
write_reg = 4'b1001;
data_in = 32'haaaaaaaa;	

#40;
we=0;	
reg_port1 = 4'b0001;
reg_port2 = 4'b1001;
write_reg = 4'b1001;


	end

	
      
endmodule

