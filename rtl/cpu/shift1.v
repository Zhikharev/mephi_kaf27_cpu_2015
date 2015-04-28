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
module shift(
input clk,
input [31:0] sr1,       // Что нужно сдвинуть
input [3:0] shift,     // На сколько нужно сдвинуть
output [31:0] rot ,     // Значение цикл. сдвига
output [31:0] log_shift // Знасение лог. сдвига
 );
wire [63:0] tmp;        // Временное значение расширенного sr1
 
//always@(posedge clk)
 // begin
  //   tmp[63:32] = sr1;
	//  tmp[31:0]  = sr1;
	 // tmp = tmp << shift;
//  end 
assign tmp = {sr1,sr1} << shift;
assign rot = tmp[63:32];
assign log_shift = tmp[31:0];
endmodule
