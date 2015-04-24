`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:47:15 04/02/2015 
// Design Name: 
// Module Name:    UARTverification 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module UARTverification(
    input clk, 
    input rst, 
    input rx1, 
    output tx1, 
    input transmit1, 
    input [7:0] tx_byte1, 
    output received1, 
    output [7:0] rx_byte1, 
    output is_receiving1, 
    output is_transmitting1, 
    output recv_error1, 
	 
   
    output tx2, 
    input transmit2, 
    input [7:0] tx_byte2, 
    output received2, 
    output [7:0] rx_byte2, 
    output is_receiving2, 
    output is_transmitting2, 
    output recv_error2,
	 
	 
	 
	 input rd_en,
	 input wr_clk,
	 output [15:0] rd_data
    );
	 
	 localparam idle = 2'b00,
	            load_h = 2'b01,
					load_l = 2'b10;

uart uart1 (
    .clk(clk), 
    .rst(rst), 
    .rx(rx1), 
    .tx(tx1), 
    .transmit(transmit1), 
    .tx_byte(tx_byte1), 
    .received(received1), 
    .rx_byte(rx_byte1), 
    .is_receiving(is_receiving1), 
    .is_transmitting(is_transmitting1), 
    .recv_error(recv_error1) 
    );
	 
uart uart2 (
    .clk(clk), 
    .rst(rst), 
    .rx(tx1), 
    .tx(tx2), 
    .transmit(transmit2), 
    .tx_byte(tx_byte2), 
    .received(received2), 
    .rx_byte(rx_byte2), 
    .is_receiving(is_receiving2), 
    .is_transmitting(is_transmitting2), 
    .recv_error(recv_error2)
    );
	 
	 
wire wr_en;	
wire full;
wire empty;
wire almost_full;
 
reg [15:0] dout;
wire [15:0] loc_d;

assign loc_d = dout; 	 
	 
reg [1:0] state_reg;
reg [1:0] state_next;
reg [5:0] count;
reg flag;
reg loc_wr_en;	 


always@(posedge clk)
   begin
	    if (rst) begin
		            state_reg <= idle;
						count <= 0;
					 end
       else state_reg <= state_next;
	end
always@(posedge received2)
   begin
	     if (flag)
          count <= count + 1'b1;
	  if (count == 3)
	     count <= 0;
	end
	
always@*
   begin
	   state_next = state_reg;
		case (state_reg)
		   idle: begin
			         if (rx_byte2 == 8'b10000000) begin
						                                 flag = 1;
						                                 state_next = load_h;
																	loc_wr_en = 0;
															  end
			      end
			load_h: begin
			         if (count == 2)
						   begin
							  dout [15:8] = rx_byte2;
							  state_next = load_l;
							end
						end
			load_l: begin
			          if (count == 3)
						    begin
							   dout [7:0] = rx_byte2;
                        state_next = idle;
								flag = 0;
								loc_wr_en = 1;
                       end
                 end							  
		endcase
	end
	assign wr_en = loc_wr_en;
	afifo fifo (
    .wr_clk(wr_clk), 
    .rst(rst), 
    .wr_en(wr_en), 
    .wr_data(loc_d), 
    .rd_en(rd_en), 
    .rd_clk(clk), 
    .rd_data(rd_data), 
    .full(full), 
    .empty(empty), 
    .almost_full(almost_full)
    );
	 
	
endmodule
