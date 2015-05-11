/*
###########################################################
#
# Author: Valeriy Glazkov
#
# Project: MEPHI CPU
# Filename: header_control.v
# Descriptions:
# 	Peforms data transfer from PC to Atlys.
###########################################################
*/
module header_control(
   input clk_i,
   input rst_i,
	input [7:0] rx_byte,
	input received,
	output io_we_o,
	output io_stb_o,
	output wr_en,
	output rd_en,
	
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
reg loc_wr_en;
reg loc_rd_en;


always@(posedge clk_i or posedge rst_i)
   begin
	  if (rst_i) 
	    begin
		   state_reg <= idle;
			count <= 0;
		 end
     else 
	     begin
	       state_reg <= state_next;
			 if ((io_we_i)&&(io_stb_i))
			   loc_rd_en <= 1;
			 if (received)
			    begin
				   if (flag)
                 count <= count + 1'b1;
	            if (count == 3)
	              count <= 0;
				 end
        end		  
	end
	
	
always@*
   begin
	   state_next = state_reg;
	      case (state_reg)
		      idle: begin
			     if (rx_byte == 8'b10000000) begin
				     flag = 1'b1;
				     state_next = load_h;
			        loc_wr_en = 1'b0;
				     io_stb_o = 1'b0;
				     io_we_o = 1'b0;
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
						  loc_wr_en = 1'b1;
						  io_stb_o = 1'b1;
						  io_we_o = 1'b1;
                    end
                 end							  
		endcase
	end
	
assign rd_en = loc_rd_en;
assign wr_en = loc_wr_en;
assign din = loc_din;

endmodule
