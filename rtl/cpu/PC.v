`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:38:23 04/22/2015 
// Design Name: 
// Module Name:    PC 
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
//  –¿¡Œ“¿≈“
module PC(
input clk,
input reset,
input [1:0]PC_MUX,
input [1:0]PC_DIRECT_CH,
input [31:0] PC_rd,
input [31:0] RESULT_PC,
input [15:0]instr,
output [9:0] PC,
output [9:0] PC_2

    );
reg [9:0] PC_1;
reg [9:0] PC_in;
reg [9:0] DIRECT;


always@*
   begin
	   case(PC_MUX)
		   2'b00 : PC_in = PC_1;
   		2'b01 : PC_in = DIRECT ;/////////////// ◊≈–« ASSIGN ƒŒœ»—¿“‹ ¬€¡Œ– Ã≈∆ƒ” 9:0 » RESULT 
	      2'b10 : PC_in =  PC_1 + 2; 
	      2'b11 : PC_in = 0; /////////////////
      endcase
	end

always@(posedge clk,posedge reset)
   begin
	   if(reset)
		   PC_1 <= 0;
		else
	      PC_1 <= PC_in;
	end
always @*
   begin
	   case(PC_DIRECT_CH)
  		   2'b00 : DIRECT = RESULT_PC;
   		2'b01 : DIRECT = instr[9:0] ; 
	      2'b10 : DIRECT =  PC_rd; 
	      2'b11 : DIRECT = 0; 
      endcase

		
	end
assign PC = PC_1;	
assign PC_2 = PC_1 +2;
endmodule

