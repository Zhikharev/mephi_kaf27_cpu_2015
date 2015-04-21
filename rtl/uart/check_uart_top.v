`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:53 03/19/2015 
// Design Name: 
// Module Name:    check_uart_top 
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
module check_uart_top(
    input clk, 
    input rst, 
    input rx, 
    output tx, 
    input transmit, 
    input [7:0] tx_byte, 
    output received, 
    output [7:0] rx_byte, 
    output is_receiving, 
    output is_transmitting, 
    output recv_error,
	 
	 
	 input wr_en,
	 input rd_en,
	 output [15:0] dout,
	 output full, 
	 output empty
	  );
	  
	  
	 localparam idle = 2'b00,
	            load_h = 2'b01,
					load_l = 2'b10;
	  
//	 wire [7:0] lb_byte;
	
	 wire clk_cmt;
	 wire wr_clk_cmt;
	 wire rd_clk_cmt;
	 wire [15:0] din;
	 
	 reg [15:0] instr;
		
	clk instance_name
   (.CLK_IN1(clk),      
    .CLK_OUT1(clk_cmt),     
    .CLK_OUT2(rd_clk_cmt), 
    .CLK_OUT3(wr_clk_cmt));  
	  
    uart uart_1 (
       .clk(clk_cmt), //clk_cmt
       .rst(rst), 
       .rx(rx), 
       .tx(tx), 
       .transmit(transmit), 
       .tx_byte(tx_byte),        //  loopback is here
       .received(received), 
       .rx_byte(rx_byte), 
       .is_receiving(is_receiving), 
       .is_transmitting(is_transmitting), 
       .recv_error(recv_error)
               );
					
		fifo fifo (
  .rst(rst), // input rst
  .wr_clk(wr_clk_cmt), // input wr_clk_cmt
  .rd_clk(rd_clk_cmt), // input rd_clk_cmt
  .din(din), // input [15 : 0] din
  .wr_en(wr_en), // input wr_en
  .rd_en(rd_en), // input rd_en
  .dout(dout), // output [15 : 0] dout
  .full(full), // output full
  .empty(empty) // output empty
);
	 assign din = loc_din;				
	// assign lb_byte = dout;
	 
reg [1:0] state_reg;
reg [1:0] state_next;
reg [5:0] count;	 
  initial count = 0;

reg [10:0] addr_beg;
  initial addr_beg = 11'b10000000000;
reg [21:11] addr_end;
  initial addr_end = 11'b11111111111;
reg  status;
reg  start;
reg  ready;
reg [15:0] data;
reg [26:16] addr;
reg  finish;

reg flag;
reg [15:0] loc_din;
	 
always@(posedge clk_cmt)
   begin
	    if (rst) begin
		            state_reg <= idle;
						status <= 0;
			      	start <= 0;
				      ready <= 0;
				      data <= 0;
		        		addr <= 0;
				      finish <= 0;
					 end
       else state_reg <= state_next;
		 if (rx_byte == 8'b01000000)
    		  status <= 1'b1;
	    if (rx_byte == 8'b00100000)
           ready <= 1'b1;	
	end
	
always@(posedge received)
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
			         if (rx_byte == 8'b10000000) begin
						                                 flag = 1;
						                                 state_next = load_h;
															  end
			      end
			load_h: begin
			         if (count == 2)
						   begin
							  loc_din [15:8] = rx_byte;
							  state_next = load_l;
							end
						end
			load_l: begin
			          if (count == 3)
						    begin
							   loc_din [7:0] = rx_byte;
                        state_next = idle;
								flag = 0;
                      end
                 end							  
		endcase
	end
	 
endmodule
