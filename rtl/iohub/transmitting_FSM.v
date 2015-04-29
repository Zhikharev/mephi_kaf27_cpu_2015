`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:31:13 04/29/2015 
// Design Name: 
// Module Name:    transmitting_FSM 
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
module transmitting_FSM(
    input clk_i,
	 input rst_i,
	 input [15:0] dout2,
	 input is_transmitting,
	 
	 output [7:0] tx_byte
    );

localparam tr_h = 1'b0,
           tr_l = 1'b1;

reg [7:0] tx_dat;
assign tx_byte = tx_dat;
reg state_next;
reg state_reg;
reg count;
reg flag;
always@(posedge clk_i or posedge rst_i)
   begin
	   begin
	  if (rst_i) 
	    begin
		   state_reg <= tr_h;
		 end
     else 
	     begin
	       state_reg <= state_next;
        end
	   end
	  end
	  
always@(negedge is_transmitting)
   begin
	  if (rst_i)
	     count <= 0;
	  else 
	    begin
           if (flag)
           count <= count + 1'b1;
	      if (count == 1)
	        count <= 0;
		  end
	   end	  
	  
always@*
   begin
	   state_next = state_reg;
	   begin
	     case (state_reg)
		     tr_h: begin
			          if (count == 0)
						   begin
							  flag = 1;
						     state_next = tr_l;
							  tx_dat = dout2 [15:8];
							end
						end
				tr_l: begin 
				        if (count == 1)
						   begin
							  flag = 0;
						     state_next = tr_h;
							  tx_dat = dout2 [7:0];
							end
						end
		  endcase
		end
	end
endmodule
