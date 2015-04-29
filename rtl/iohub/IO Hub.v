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
module IO_Hub(
    input clk_i, 
    input rst_i, 
    input rx, 
    output tx, 
	 
	 input ack_i,
	 input stb_i,
	 input [15:0] addr_i,
	 input [15:0] dat_i,
	 input we_i,
	 output ack_o,
	 output stb_o,
	 output [15:0] addr_o,
	 output [15:0] dat_o,
	 output we_o
	  );
	  
	// DECLARATION OF WIRES FOR UART INSTANCE
wire transmit;
wire [7:0] tx_byte;
wire received;
wire [7:0] rx_byte; 
wire is_receiving; 
wire is_transmitting; 
wire recv_error; 	
//	 wire [7:0] lb_byte; 

  // DECLARATION OF WIRES FOR FIFO 1 INSTANCE
wire wr_en;
wire rd_en;
wire [15:0] dout;
wire full; 
wire empty;
wire [15:0] din;


   // DECLARATION OF WIRES FOR FIFO 2 INSTANCE
wire wr_en2;
wire rd_en2;
wire [15:0] dout2;
wire full2; 
wire empty2;

	  
    uart uart_1 (
       .clk(clk_i), //clk_cmt
       .rst(rst_i), 
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
					
		fifo fifo1 (
  .rst(rst_i), // input rst
  .wr_clk(wr_clk), // input wr_clk_cmt
  .rd_clk(rd_clk), // input rd_clk_cmt
  .din(din), // input [15 : 0] din
  .wr_en(wr_en), // input wr_en
  .rd_en(rd_en), // input rd_en
  .dout(dout2), // output [15 : 0] dout
  .full(full), // output full
  .empty(empty) // output empty
);

    fifo fifo2 (
  .rst(rst_i), // input rst
  .wr_clk(rd_clk), // input wr_clk
  .rd_clk(wr_clk), // input rd_clk
  .din(dat_i), // input [15 : 0] din
  .wr_en(wr_en2), // input wr_en
  .rd_en(rd_en2), // input rd_en
  .dout(dout), // output [15 : 0] dout
  .full(full2), // output full
  .empty(empty2) // output empty
);

header_control hc (
    .clk_i(clk_i), 
    .rst_i(rst_i), 
    .rx_byte(rx_byte), 
	 .received(received),
	 .we_i(we_i),
	 .stb_i(stb_i),
    .din(din)
    );

transmitting_FSM tFSM (
    .clk_i(clk_i), 
    .rst_i(rst_i), 
    .dout2(dout2), 
    .is_transmitting(is_transmitting), 
    .tx_byte(tx_byte)
    );				

      // DECLARATION OF REGISTERS	
reg [1:0] state_reg;
reg [1:0] state_next;
reg [5:0] count;	 
  

wire [10:0] ctrl0_addr_beg;
wire [21:11] ctrl0_addr_end;
reg  ctrl0_status;
reg  ctrl0_start;
reg  ctrl0_ready;

assign addr_beg = 11'b10000000000;
assign addr_end = 11'b11111111111;

reg [15:0] ctrl1_data;
reg [26:16] ctrl1_addr;
reg  ctrl1_finish;

   // WRITE LOGIC

always@(posedge clk_i or posedge rst_i)
	begin
	   if (rst_i) begin
	     ctrl0_status <= 0;
		  ctrl0_start <= 0;
		  ctrl0_ready <= 0;
		  ctrl1_data <= 0;
		  ctrl1_addr <= 0;
		  ctrl1_finish <= 0;
		end
	   else begin
		   if (rx_byte == 8'b01000000)
    	      ctrl0_status <= 1'b1;
	      if (rx_byte == 8'b00100000)
            ctrl0_ready <= 1'b1;
		   if ((we_i)&&(stb_i)) 
		      begin
			      case (addr_i)
				      2: begin
					       ctrl0_start <= dat_i [8];
					   	end
				   	6: begin
						    ctrl1_finish <= dat_i [13];
						    ctrl1_addr <= addr_i;
					      end
					   4: begin
					       ctrl1_data <= dat_i;
					   	end
				  endcase
		      end
		  end
	 end

     // READ LOGIC

assign dat_o = ((stb_i) && (~we_i) && (addr_i == 0)) ? {ctrl0_addr_end [15:11], ctrl0_addr_beg} :
               ((stb_i) && (~we_i) && (addr_i == 2)) ? {7'b0000000, ctrl0_ready, ctrl0_start, ctrl0_status, ctrl0_addr_end [21:16]} :
					((stb_i) && (~we_i) && (addr_i == 4)) ? ctrl1_data: {4'b0000, ctrl1_finish, ctrl1_addr};

//assign dat_o = ( {16{ ((stb_i) && (~we_i) && (addr_i == 0) ) }} ) && {ctrl0_addr_end [15:11], ctrl0_addr_beg} || 
  //  ( {16{ ((stb_i) && (~we_i) && (addr_i == 2) ) }} ) && {7'b0000000, ctrl0_ready, ctrl0_start, ctrl0_status, ctrl0_addr_end [21:16]}
     
assign ack_o = stb_i;
	 
	 
endmodule
