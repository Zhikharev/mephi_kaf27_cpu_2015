`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:21:00 03/22/2015 
// Design Name: 
// Module Name:    shift 
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
module shift(
input clk,
input [31:0] sr1,       // Что нужно сдвинуть
input [31:0] shift,     // На сколько нужно сдвинуть
output [31:0] rot ,     // Значение цикл. сдвига
output [31:0] log_shift // Знасение лог. сдвига
 );
reg [63:0] tmp;        // Временное значение расширенного sr1
 
always@(posedge clk)
  begin
     tmp[63:32] = sr1;
	  tmp[31:0]  = sr1;
	  tmp = tmp << shift;
  end 

assign rot = tmp[63:32];
assign log_shift = tmp[31:0];
endmodule
