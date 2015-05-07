/*
###########################################################
#
# Author: Valeriy Glazkov
#
# Project: MEPHI CPU
# Filename: transmitting_FSM.v
# Descriptions:
# 	Peforms data transfer from Atlus to PC.
###########################################################
*/
module transmitting_FSM(
    input clk_i,
	 input rst_i,
	 input [15:0] dout2,
	 input is_transmitting,
	 input ready,
	 output io_stb_o,
	 output io_we_o,
	 output io_ack_o,
	 output wr_en2,
	 output rd_en2,
	 
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
reg loc_wr_en2;
reg loc_rd_en2;
reg loc_stb;
reg loc_we;

assign io_stb_o = loc_stb;
assign io_we_o = loc_we;

assign wr_en2 = loc_wr_en2;
assign rd_en2 = loc_rd_en2;

always@(posedge clk_i or posedge rst_i)
   begin
	   begin
	  if (rst_i) 
	    begin
		   state_reg <= tr_h;
			count <= 0;
		 end
     else 
	     begin
	       state_reg <= state_next;
			 if (ready)
			    begin
				   loc_stb <= 1'b1;
					loc_we <= 1'b1;
			      loc_wr_en2 <= 1'b1;
			    end
			 if (is_transmitting)
			    begin
				    if (flag)
                  count <= count + 1'b1;
	             if (count == 1)
	               count <= 0;
				 end				    
        end
	   end
	  end  
	  
always@*
  begin
	 state_next = state_reg;
	 if (ready)
	   begin
	     case (state_reg)
		     tr_h: begin
			          if (count == 0)
						   begin
							  flag = 1;
						     state_next = tr_l;
							  tx_dat = dout2 [15:8];
							  loc_rd_en2 = 0;
							end
						end
				tr_l: begin 
				        if (count == 1)
						   begin
							  flag = 0;
						     state_next = tr_h;
							  tx_dat = dout2 [7:0];
							  loc_rd_en2 = 1;
							end
						end
		  endcase
		end
	end
endmodule
