`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:46:32 04/15/2015 
// Design Name: 
// Module Name:    UC 
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
/// пюанрюер
module UC(
input clk,
input [15:0] instr,
input ZERO,                  // ZERO FLAG
output RF_HL,                // гюохяэ б HIGH/LOW б пт
output RESULT_HL,            //гюохяэ б MEM HIGL/LOW
output [1:0] PC_DIRECT_CH,   // бшанп мю бунде DIRECT
output STB_O,                //пюгпеьюер беднлнлс сярпниярбс пюанрюрэ
output [5:0] ALU_SHIFT,      // гмювемхе ядбхцю
output WRITE_CH,	           // бшанп юдпеяю мю гюохяэ б пт
output RESULT_CH,            // бшанп пегскэрюрю оняке юкс
output [3:0] WRITE_ADDR,     //  юдпея мю гюохяэ б пт
output [1:0] PC_MUX,         // бшанп оепед пя
output MEM_WE,               // пюгпеьемхе гюохях б лел
output [2:0] ALU_CONTROL,    // бшанп ноепюжхх б юкс
output [31:0] ALU_DATAIN,    // дюммше мю бунд юкс
output [3:0] READ_ADDR,      // юдпея дкъ времхъ хг пт
output READ_CH,              //  бшанп юдпеяю дкъ времхъ хг пт
output RF_WE,                // пюгпеьемхе мю гюохяэ б пт
output RF_DATAIN             // бшанп дюммш дкъ гюохях б пт
    );
reg [3:0] op;
reg [1:0] mtype;

   localparam ADD =  4'b0000;
   localparam ADDI = 4'b0001;
   localparam OR =   4'b0010;
   localparam AND =  4'b0011;
   localparam XOR =  4'b0100;
   localparam NOR =  4'b0101;
   localparam SLL =  4'b0110;
   localparam ROT =  4'b0111;
   localparam BNE =  4'b1000;
   localparam LD =   4'b1001;
   localparam ST =   4'b1010;
   localparam JMP =  4'b1011;  
   localparam NOP =  4'b1100; 



 //
reg STB_O;
reg [3:0] ALU_SHIFT;
reg WRITE_CH;
reg RESULT_CH;
reg [3:0] WRITE_ADDR;
reg [1:0] PC_MUX;
reg MEM_WE;
reg [2:0] ALU_CONTROL;
reg ALU_DATAIN;
reg RF_WE;
reg [1:0] RF_DATAIN;
reg READ_CH;
reg [3:0] READ_ADDR;
reg [1:0] PC_DIRECT_CH;
reg RF_HL;
reg RESULT_HL;

always@*
   begin
assign op = instr[15:12];
assign mtype = instr[11:10];
   case(op)
   			     ADD :
   begin
WRITE_CH =1;
RESULT_CH =1;
PC_MUX =10;
MEM_WE =0;
ALU_CONTROL =0;
ALU_DATAIN =0;
RF_WE =1;
RF_DATAIN =1;
READ_CH =1;
   end							  
	               ADDI :
   begin
WRITE_CH =1;
RESULT_CH =1;
PC_MUX =10;
MEM_WE =0;
ALU_CONTROL =0;
ALU_DATAIN =1;
RF_WE =1;
RF_DATAIN =1;
READ_CH =1;
	end	
				OR :
	begin
WRITE_CH =1;
RESULT_CH =1;
PC_MUX =10;
MEM_WE =0;
ALU_CONTROL = 001;
ALU_DATAIN =0;
RF_WE =1;
RF_DATAIN =1;
READ_CH =1;
	end	
            
				AND :
	begin
WRITE_CH =1;
RESULT_CH =1;
PC_MUX =10;
MEM_WE =0;
ALU_CONTROL =010;
ALU_DATAIN =0;
RF_WE =1;
RF_DATAIN =1;
READ_CH =1;
	end	
            
				XOR :
	begin
WRITE_CH =1;
RESULT_CH =1;
PC_MUX =10;
MEM_WE =0;
ALU_CONTROL =011;
ALU_DATAIN =0;
RF_WE =1;
RF_DATAIN =1;
READ_CH =1;
	end	
            
				NOR :
   begin
WRITE_CH =1;
RESULT_CH =1;
PC_MUX =10;
MEM_WE =0;
ALU_CONTROL =100;
ALU_DATAIN =0;
RF_WE =1;
RF_DATAIN =1;
READ_CH =1;
	end	
				SLL :
   begin
ALU_SHIFT  = instr[7:4];
WRITE_CH =1;
RESULT_CH =1;
PC_MUX =10;
MEM_WE =0;
ALU_CONTROL =101;
ALU_DATAIN =0;
RF_WE =1;
RF_DATAIN =1;
READ_CH =1;
	end	
				ROT :
   begin
ALU_SHIFT  = instr[7:4];
WRITE_CH =1;
RESULT_CH =1;
PC_MUX =10;
MEM_WE =0;
ALU_CONTROL =110;
ALU_DATAIN =0;
RF_WE =1;
RF_DATAIN =1;
READ_CH =1;
	end	
				BNE :
   begin
WRITE_CH =1;
if(ZERO)
 PC_MUX =01;
else
 PC_MUX =10;
MEM_WE =0;
ALU_CONTROL =111;
ALU_DATAIN =0;
RF_WE =0;
READ_CH =1;
PC_DIRECT_CH =1;
	end	
				LD :
   begin
WRITE_CH=0;
WRITE_ADDR=4'b1010;
PC_MUX=10;
MEM_WE=0;
RF_WE=1;
RF_DATAIN=0;
     if(mtype)
        RF_HL=1;///
	  else
	     RF_HL =0;///
	end	
				ST :
   begin
RESULT_CH=0;
PC_MUX=10;
MEM_WE=1;
RF_WE=0;
READ_CH=0;
READ_ADDR=1010;
if(mtype)
 RESULT_HL=1;
else
 RESULT_HL=0;
	end	
 				    JMP :
   begin
 case(mtype)
			 2'b00:
     begin
PC_MUX=01;
MEM_WE=0;
RF_WE=0;
PC_DIRECT_CH=01;
	  end	
				2'b01 :
     begin
WRITE_CH=0;
WRITE_ADDR=1011;
PC_MUX=1;
MEM_WE=0;
RF_WE=1;
RF_DATAIN=10;
PC_DIRECT_CH=1;
	  end	
				2'b10 :
     begin
RESULT_CH=0;
PC_MUX=1;
MEM_WE=0;
RF_WE=0;
READ_CH=1;
PC_DIRECT_CH=0;
	  end	
				2'b11:
     begin
WRITE_CH=0;
RESULT_CH=0;
WRITE_ADDR=1011;
PC_MUX=1;
MEM_WE=0;
RF_WE=1;
RF_DATAIN=10;
READ_CH=1;
PC_DIRECT_CH=0;
	  end	
 endcase
   end
 				   NOP :
   begin
PC_MUX=0;
MEM_WE=0;
RF_WE=0;
	end	
			
	
	
	
endcase	
	end

endmodule
