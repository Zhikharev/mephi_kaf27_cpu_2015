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
  //  input [7:0] tx_byte, 
    output received, 
    output [7:0] rx_byte, 
    output is_receiving, 
    output is_transmitting, 
    output recv_error
	  );
	  
	 wire [7:0] lb_byte;
	 wire clk_cmt;
	 
	 clk clock
     (.CLK_IN1(clk),      
      .CLK_OUT1(clk_cmt)); 
	  
    uart uart_1 (
       .clk(clk_cmt), 
       .rst(rst), 
       .rx(rx), 
       .tx(tx), 
       .transmit(transmit), 
       .tx_byte(lb_byte),        //  loopback is here
       .received(received), 
       .rx_byte(rx_byte), 
       .is_receiving(is_receiving), 
       .is_transmitting(is_transmitting), 
       .recv_error(recv_error)
               );
					
	 assign lb_byte = rx_byte;
endmodule
