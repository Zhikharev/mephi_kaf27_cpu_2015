/*
###########################################################
#
# Author: Valeriy Glazkov
#
# Project: MEPHI CPU
# Filename: iohub.v
# Descriptions:
# 	Top module of periphery block.
###########################################################
*/
module iohub(
    input clk_i, 
    input rst_i, 
    input rx, 
    output tx, 
	 
	 input io_ack_i,
	 input io_stb_i,
	 input [15:0] io_addr_i,
	 input [15:0] io_dat_i,
	 input io_we_i,
	 output io_ack_o,
	 output io_stb_o,
	 output [15:0] io_addr_o,
	 output [15:0] io_dat_o,
	 output io_we_o,
	 
	 output dbg_status
	  );
	  
	  assign dbg_status = ctrl0_status;
	  
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


wire ready;
assign ready = ((ctrl0_ready) ? 1'b1 : 1'b0); // flag to transmit from Atlys to PC
  
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
  .din(io_dat_i), // input [15 : 0] din
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
	 .io_we_i(io_we_i),
	 .io_stb_i(io_stb_i),
    .din(din),
	 .wr_en(wr_en),
	 .rd_en(rd_en)
    );

transmitting_FSM tFSM (
    .clk_i(clk_i), 
    .rst_i(rst_i), 
    .dout2(dout2), 
    .is_transmitting(is_transmitting), 
    .ready(ready), 
    .tx_byte(tx_byte),
	 .io_stb_o(io_stb_o),
	 .io_we_o(io_we_o),
	 .wr_en2(wr_en2),
	 .rd_en2(rd_en2),
	 .io_ack_o(io_ack_o)
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
		   if ((io_we_i)&&(io_stb_i)) 
		      begin
			      case (io_addr_i)
				      2: begin
					       ctrl0_start <= io_dat_i [8];
					   	end
				   	6: begin
						    ctrl1_finish <= io_dat_i [13];
						    ctrl1_addr <= io_addr_i;
					      end
					   4: begin
					       ctrl1_data <= io_dat_i;
					   	end
				  endcase
		      end
		  end
	 end
	 

     // READ LOGIC

assign io_dat_o = ((io_stb_i) && (~io_we_i) && (io_addr_i == 0)) ? {ctrl0_addr_end [15:11], ctrl0_addr_beg} :
               ((io_stb_i) && (~io_we_i) && (io_addr_i == 2)) ? {7'b0000000, ctrl0_ready, ctrl0_start, ctrl0_status, ctrl0_addr_end [21:16]} :
					((io_stb_i) && (~io_we_i) && (io_addr_i == 4)) ? ctrl1_data: {4'b0000, ctrl1_finish, ctrl1_addr};

//assign io_dat_o = ( {16{ ((io_stb_i) && (~io_we_i) && (io_addr_i == 0) ) }} ) && {ctrl0_addr_end [15:11], ctrl0_addr_beg} || 
  //  ( {16{ ((io_stb_i) && (~io_we_i) && (io_addr_i == 2) ) }} ) && {7'b0000000, ctrl0_ready, ctrl0_start, ctrl0_status, ctrl0_addr_end [21:16]}
     
assign io_ack_o = io_stb_i;
	 
	 
endmodule
