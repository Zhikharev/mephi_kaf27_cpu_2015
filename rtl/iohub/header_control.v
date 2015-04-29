`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:51 04/27/2015 
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
module header_control(
   input clk_i,
   input rst_i,
	input [8:0] rx_byte,
	input received,
	input we_i,
	input stb_i,
	
	output [15:0] din	
    );
	 
	 localparam idle = 2'b00,
	            load_h = 2'b01,
					load_l = 2'b10;
	 
reg [1:0] state_reg;
reg [1:0] state_next;
reg [5:0] count;	 
reg flag;
reg [15:0] loc_din;



always@(posedge clk_i or posedge rst_i)
   begin
	  if (rst_i) 
	    begin
		   state_reg <= idle;
		 end
     else 
	     begin
	       state_reg <= state_next;
        end		  
	end
	
always@(posedge received)
   begin
	  if (rst_i)
	     count <= 0;
	  else 
	    begin
	      if (flag)
           count <= count + 1'b1;
	      if (count == 3)
	        count <= 0;
		  end
	   end
	
always@*
   begin
	   state_next = state_reg;
	   if ((we_i)&&(stb_i)) 
		   begin
	      	case (state_reg)
		        idle: begin
			       if (rx_byte == 8'b10000000) begin
				    flag = 1;
				    state_next = load_h;
					 end
			      end
		    	 load_h: begin
			      if (count == 2) begin
					      loc_din [15:8] = rx_byte;
						   state_next = load_l;
					      end
						end
		   	load_l: begin
			       if (count == 3) begin
					     loc_din [7:0] = rx_byte;
                    state_next = idle;
					     flag = 0;
                    end
                 end							  
		endcase
	  end
	end

assign din = loc_din;

endmodule
