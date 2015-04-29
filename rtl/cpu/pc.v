/*
###########################################################
#
# Author: Khaltahchyan Daniel 
#
# Project: MEPHI CPU
# Filename: TOP.v
# Descriptions:
# 	
###########################################################
*/
module PC(
input clk,
input reset,
input [1:0]pc_mux,
input [1:0]pc_direct_ch,
input [31:0] pc_rd,
input [31:0] result_pc,
input [15:0]instr,
output [9:0] pc,
output [9:0] pc_2

    );
reg [9:0] pc_1;
reg [9:0] pc_in;
reg [9:0] direct;


always@*
   begin
	   case(pc_mux)
		   2'b00 : pc_in = pc_1;
   		2'b01 : pc_in = direct ;/////////////// вепг ASSIGN днохяюрэ бшанп лефдс 9:0 х RESULT 
	      2'b10 : pc_in =  pc_1 + 2; 
	      2'b11 : pc_in = 0; /////////////////
      endcase
	end

always@(posedge clk,posedge reset)
   begin
	   if(reset)
		   pc_1 <= 0;
		else
	      pc_1 <= pc_in;
	end
always @*
   begin
	   case(pc_direct_ch)
  		   2'b00 : direct = result_pc;
   		2'b01 : direct = instr[9:0] ; 
	      2'b10 : direct =  pc_rd; 
	      2'b11 : direct = 0; 
      endcase

		
	end
assign pc = pc_1;	
assign pc_2 = pc_1 +2;
endmodule

