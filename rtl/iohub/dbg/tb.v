`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:30:51 04/24/2015
// Design Name:   UARTverification
// Module Name:   C:/Xilinx/UARTverification/tb.v
// Project Name:  UARTverification
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UARTverification
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;

	// Inputs
	reg clk;
	reg rst;
	reg rx1;
	reg transmit1;
	reg [7:0] tx_byte1;
	reg transmit2;
	reg [7:0] tx_byte2;
	reg rd_en;
	reg wr_clk;

	// Outputs
	wire tx1;
	wire received1;
	wire [7:0] rx_byte1;
	wire is_receiving1;
	wire is_transmitting1;
	wire recv_error1;
	wire tx2;
	wire received2;
	wire [7:0] rx_byte2;
	wire is_receiving2;
	wire is_transmitting2;
	wire recv_error2;
	wire [15:0] rd_data;

	// Instantiate the Unit Under Test (UUT)
	UARTverification uut (
		.clk(clk), 
		.rst(rst), 
		.rx1(rx1), 
		.tx1(tx1), 
		.transmit1(transmit1), 
		.tx_byte1(tx_byte1), 
		.received1(received1), 
		.rx_byte1(rx_byte1), 
		.is_receiving1(is_receiving1), 
		.is_transmitting1(is_transmitting1), 
		.recv_error1(recv_error1), 
		.tx2(tx2), 
		.transmit2(transmit2), 
		.tx_byte2(tx_byte2), 
		.received2(received2), 
		.rx_byte2(rx_byte2), 
		.is_receiving2(is_receiving2), 
		.is_transmitting2(is_transmitting2), 
		.recv_error2(recv_error2), 
		.rd_en(rd_en), 
		.wr_clk(wr_clk), 
		.rd_data(rd_data)
	);

initial forever #20 clk = ~clk;
initial forever #50 wr_clk = ~wr_clk;
initial begin

      clk = 0;
		rst = 1;
		transmit1 = 0;
		tx_byte1 = 0;
		rd_en = 0;
		wr_clk = 0;
		
		#30;
		rst = 0;
		transmit1 = 1;
		
		@(posedge received2);
		tx_byte1 = 8'b00000000;
		@(posedge received2);
		tx_byte1 = 8'b10000000;
		@(posedge received2);
		tx_byte1 = 8'b00001111;
		@(posedge received2);
		tx_byte1 = 8'b11110000;
		@(posedge received2);
		tx_byte1 = 8'b10000000;
		@(posedge received2);
		tx_byte1 = 8'b00000000;
		@(posedge received2);
		tx_byte1 = 8'b11111111;
		@(posedge received2);
		rd_en = 1;
     end
endmodule

