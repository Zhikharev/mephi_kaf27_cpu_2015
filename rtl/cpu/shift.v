`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:34 03/20/2015 
// Design Name: 
// Module Name:    alu 
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
module alu(
input clk,
input [31:0] sr1,
input [31:0] sr2,
input  [2:0] os,
input [31:0] shift,
input [31:0] rot,
input reset,
output [31:0] rd,
output zeroflag

	);
//reg [31:0] reg_sr1;			
//reg [31:0] reg_sr2;
reg [31:0] reg_rd;

always @* // Нужно придумать по каким сигн работает always
  begin
   //if(reset)
     // begin
       //reg_sr1 <= 0;
		 //reg_sr2 <= 0;
      //end		
		//else
    case (os)
         3'b000 : reg_rd = sr1 + sr2;	// сложение	( сложение с константой )
         3'b001 : reg_rd = sr1 | sr2;   // побитовое ИЛИ 
         3'b010 : reg_rd = sr1 & sr2;   // побитовое И
         3'b011 : reg_rd = sr1 ^ sr2;   // побитовое ИСКЛ ИЛИ
         3'b100 : reg_rd = ~(sr1 | sr2);       // побитовое ОТРИЦАНИЕ
         3'b101 : reg_rd = log_shift;	//	логический сдвиг ВЛЕВО	  
			3'b110 : reg_rd = rot;         // цикличекий СДВИГ 
			default : reg_rd = 0;
      endcase  
  end
//assign 
assign rd = reg_rd;	
assign  reg_sr1 = sr1;
assign reg_sr2 = sr2;


endmodule
