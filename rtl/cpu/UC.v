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
/// –¿¡Œ“¿≈“
module UC(
input clk,
input [15:0] instr,
input ack,
input ZERO,                  // ZERO FLAG
output RF_HL,                // «¿œ»—‹ ¬ HIGH/LOW ¬ –‘
output RESULT_HL,            //«¿œ»—‹ ¬ MEM HIGL/LOW
output [1:0] PC_DIRECT_CH,   // ¬€¡Œ– Õ¿ ¬’Œƒ≈ DIRECT
output STB_O,                //–¿«–≈ÿ¿≈“ ¬≈ƒŒÃŒÃ” ”—“–Œ…—“¬” –¿¡Œ“¿“‹
output [3:0] ALU_SHIFT,      // «Õ¿◊≈Õ»≈ —ƒ¬»√¿
output WRITE_CH,	           // ¬€¡Œ– ¿ƒ–≈—¿ Õ¿ «¿œ»—‹ ¬ –‘
output RESULT_CH,            // ¬€¡Œ– –≈«”À‹“¿“¿ œŒ—À≈ ¿À”
output [3:0] WRITE_ADDR,     //  ¿ƒ–≈— Õ¿ «¿œ»—‹ ¬ –‘
output [1:0] PC_MUX,         // ¬€¡Œ– œ≈–≈ƒ –—
output MEM_WE,               // –¿«–≈ÿ≈Õ»≈ «¿œ»—» ¬ Ã≈Ã
output [2:0] ALU_CONTROL,    // ¬€¡Œ– Œœ≈–¿÷»» ¬ ¿À”
output [31:0] ALU_DATAIN,    // ƒ¿ÕÕ€≈ Õ¿ ¬’Œƒ ¿À”
output [3:0] READ_ADDR,      // ¿ƒ–≈— ƒÀﬂ ◊“≈Õ»ﬂ »« –‘
output READ_CH,              //  ¬€¡Œ– ¿ƒ–≈—¿ ƒÀﬂ ◊“≈Õ»ﬂ »« –‘
output RF_WE,                // –¿«–≈ÿ≈Õ»≈ Õ¿ «¿œ»—‹ ¬ –‘
output [1:0] RF_DATAIN            // ¬€¡Œ– ƒ¿ÕÕ€ ƒÀﬂ «¿œ»—» ¬ –‘
//output DAT_O_CH              // ¬€¡Œ– ƒ¿ÕÕ€’ ƒÀﬂ «¿œ»—» ¬ MEM
    );
wire [3:0] op;
wire [1:0] mtype;

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
reg STB_O_1;
reg [3:0] ALU_SHIFT_1;
reg WRITE_CH_1;
reg RESULT_CH_1;
reg [3:0] WRITE_ADDR_1;
reg [1:0] PC_MUX_1;
reg MEM_WE_1;
reg [2:0] ALU_CONTROL_1;
reg [31:0] ALU_DATAIN_1;
reg RF_WE_1;
reg [1:0] RF_DATAIN_1;
reg READ_CH_1;
reg [3:0] READ_ADDR_1;
reg [1:0] PC_DIRECT_CH_1;
reg RF_HL_1;
reg RESULT_HL_1;

assign STB_O = STB_O_1;
assign ALU_SHIFT = ALU_SHIFT_1;
assign WRITE_CH = WRITE_CH_1;
assign RESULT_CH = RESULT_CH_1;
assign WRITE_ADDR = WRITE_ADDR_1;
assign PC_MUX = PC_MUX_1;
assign MEM_WE = MEM_WE_1;
assign ALU_CONTROL = ALU_CONTROL_1;
assign ALU_DATAIN = ALU_DATAIN_1;
assign RF_WE = RF_WE_1;
assign RF_DATAIN = RF_DATAIN_1;
assign READ_CH = READ_CH_1;
assign READ_ADDR = READ_ADDR_1;
assign PC_DIRECT_CH = PC_DIRECT_CH_1;
assign RF_HL = RF_HL_1;
assign RESULT_HL = RESULT_HL_1;



assign op = instr[15:12];
assign mtype = instr[11:10];

always@*
   begin
   case(op)
   			     ADD :
   begin
	STB_O_1 =1;
	ALU_SHIFT_1=0;
	WRITE_ADDR_1=0;
	READ_ADDR_1=0;
	PC_DIRECT_CH_1=0;
	RF_HL_1=0;
	RESULT_HL_1=0;
WRITE_CH_1 =1;
RESULT_CH_1 =1;
PC_MUX_1 =2'b10;
MEM_WE_1 =0;
ALU_CONTROL_1 =0;
ALU_DATAIN_1 =0;
RF_WE_1 =1;
RF_DATAIN_1 =1;
READ_CH_1 =1;
   end							  
	               ADDI :
   begin	
	STB_O_1 =1;
	ALU_SHIFT_1=0;
	WRITE_ADDR_1=0;
	READ_ADDR_1=0;
	PC_DIRECT_CH_1=0;
	RF_HL_1=0;
	RESULT_HL_1=0;
WRITE_CH_1 =1;
RESULT_CH_1 =1;
PC_MUX_1 =2'b10;
MEM_WE_1 =0;
ALU_CONTROL_1 =0;
ALU_DATAIN_1 =1;
RF_WE_1 =1;
RF_DATAIN_1 =1;
READ_CH_1 =1;
	end	
				OR :
	begin
	
	STB_O_1 =1;
	ALU_SHIFT_1=0;
	WRITE_ADDR_1=0;
	READ_ADDR_1=0;
	PC_DIRECT_CH_1=0;
	RF_HL_1=0;
	RESULT_HL_1=0;
WRITE_CH_1 =1;
RESULT_CH_1 =1;
PC_MUX_1 =2'b10;
MEM_WE_1 =0;
ALU_CONTROL_1 = 3'b001;
ALU_DATAIN_1 =0;
RF_WE_1 =1;
RF_DATAIN_1 =1;
READ_CH_1 =1;
	end	
            
				AND :
	begin
	STB_O_1 =1;
	ALU_SHIFT_1=0;
	WRITE_ADDR_1=0;
	READ_ADDR_1=0;
	PC_DIRECT_CH_1=0;
	RF_HL_1=0;
	RESULT_HL_1=0;
WRITE_CH_1 =1;
RESULT_CH_1 =1;
PC_MUX_1 =2'b10;
MEM_WE_1 =0;
ALU_CONTROL_1 =3'b010;
ALU_DATAIN_1 =0;
RF_WE_1 =1;
RF_DATAIN_1 =1;
READ_CH_1 =1;
	end	
            
				XOR :
	begin
	STB_O_1 =1;
	ALU_SHIFT_1=0;
	WRITE_ADDR_1=0;
	READ_ADDR_1=0;
	PC_DIRECT_CH_1=0;
	RF_HL_1=0;
	RESULT_HL_1=0;
WRITE_CH_1 =1;
RESULT_CH_1 =1;
PC_MUX_1 =2'b10;
MEM_WE_1 =0;
ALU_CONTROL_1 =3'b011;
ALU_DATAIN_1 =0;
RF_WE_1 =1;
RF_DATAIN_1 =1;
READ_CH_1 =1;
	end	
            
				NOR :
   begin
	STB_O_1 =1;
	ALU_SHIFT_1=0;
	WRITE_ADDR_1=0;
	READ_ADDR_1=0;
	PC_DIRECT_CH_1=0;
	RF_HL_1=0;
	RESULT_HL_1=0;
WRITE_CH_1 =1;
RESULT_CH_1 =1;
PC_MUX_1 =2'b10;
MEM_WE_1 =0;
ALU_CONTROL_1 =3'b100;
ALU_DATAIN_1 =0;
RF_WE_1 =1;
RF_DATAIN_1 =1;
READ_CH_1 =1;
	end	
				SLL :
   begin
	STB_O_1 =1;
	
	WRITE_ADDR_1=0;
	READ_ADDR_1=0;
	PC_DIRECT_CH_1=0;
	RF_HL_1=0;
	RESULT_HL_1=0;
ALU_SHIFT_1  = instr[7:4];
WRITE_CH_1 =1;
RESULT_CH_1 =1;
PC_MUX_1 =2'b10;
MEM_WE_1 =0;
ALU_CONTROL_1 =3'b101;
ALU_DATAIN_1 =0;
RF_WE_1 =1;
RF_DATAIN_1 =1;
READ_CH_1 =1;
	end	
				ROT :
   begin
	STB_O_1 =1;
	
	WRITE_ADDR_1=0;
	READ_ADDR_1=0;
	PC_DIRECT_CH_1=0;
	RF_HL_1=0;
	RESULT_HL_1=0;

ALU_SHIFT_1  = instr[7:4];
WRITE_CH_1 =1;
RESULT_CH_1 =1;
PC_MUX_1 =2'b10;
MEM_WE_1 =0;
ALU_CONTROL_1 =3'b110;
ALU_DATAIN_1 =0;
RF_WE_1 =1;
RF_DATAIN_1 =1;
READ_CH_1 =1;
	end	
				BNE :
   begin
	
   RESULT_CH_1 =1;
	RF_DATAIN_1 =0;
	STB_O_1 =1;
	ALU_SHIFT_1=0;
	WRITE_ADDR_1=0;
	READ_ADDR_1=0;
	RF_HL_1=0;
	RESULT_HL_1=0;
	
WRITE_CH_1 =1;
if(ZERO)
 PC_MUX_1 =2'b01;
else
 PC_MUX_1 =2'b10;
MEM_WE_1 =0;
ALU_CONTROL_1 =3'b111;
ALU_DATAIN_1 =0;
RF_WE_1 =0;
READ_CH_1 =1;
PC_DIRECT_CH_1 =2'b01;
	end	
				LD :
   begin
	STB_O_1 =1;
	ALU_SHIFT_1=0;
	WRITE_ADDR_1=0;
	READ_ADDR_1=0;
	PC_DIRECT_CH_1=0;   
	RESULT_CH_1 =1;
	ALU_CONTROL_1 =3'b111;
	ALU_DATAIN_1 =0;
	READ_CH_1 =1;

	RESULT_HL_1=0;
WRITE_CH_1=0;
WRITE_ADDR_1=4'b1010;
if(ack)
PC_MUX_1=2'b10;
else
PC_MUX_1=2'b00;
MEM_WE_1=0;
RF_WE_1=1;
RF_DATAIN_1=0;
     if(mtype)
        RF_HL_1=1;///
	  else
	     RF_HL_1 =0;///
	end	
				ST :
   begin
	STB_O_1 =1;
	ALU_SHIFT_1=0;
	WRITE_CH_1=0;
	ALU_CONTROL_1 =3'b111;
	ALU_DATAIN_1 =0;
	RF_DATAIN_1=0;

	READ_ADDR_1=0;
	PC_DIRECT_CH_1=0;
	RF_HL_1=0;
	
RESULT_CH_1=0;
PC_MUX_1=2'b10;
MEM_WE_1=1;
RF_WE_1=0;
READ_CH_1=0;
READ_ADDR_1=4'b1010;
if(mtype)
 RESULT_HL_1=1;
else
 RESULT_HL_1=0;
	end	
 				    JMP :
   begin
	STB_O_1 =1;
	ALU_SHIFT_1=0;	
	ALU_CONTROL_1 =3'b111;
	ALU_DATAIN_1 =0;	
	READ_ADDR_1=0;
	RF_HL_1=0;
   RESULT_HL_1=0;	
 case(mtype)
			 2'b00:
     begin
	  WRITE_CH_1=0;
     WRITE_ADDR_1=0;
	  RESULT_CH_1=0;
	  RF_DATAIN_1=0;
     READ_CH_1=0;

PC_MUX_1=01;
MEM_WE_1=0;
RF_WE_1=0;
PC_DIRECT_CH_1=2'b01;
	  end	
				2'b01 :
     begin
	  
	  RESULT_CH_1=0;	
	  READ_CH_1=0;

WRITE_CH_1=0;
WRITE_ADDR_1=4'b1011;
PC_MUX_1=1;
MEM_WE_1=0;
RF_WE_1=1;
RF_DATAIN_1=2'b10;
PC_DIRECT_CH_1=1;
	  end	
				2'b10 :
     begin
	  WRITE_CH_1=0;
     WRITE_ADDR_1=0;
	  RF_DATAIN_1=0;

RESULT_CH_1=0;
PC_MUX_1=1;
MEM_WE_1=0;
RF_WE_1=0;
READ_CH_1=1;
PC_DIRECT_CH_1=0;
	  end	
				2'b11:
     begin
WRITE_CH_1=0;
RESULT_CH_1=0;
WRITE_ADDR_1=4'b1011;
PC_MUX_1=1;
MEM_WE_1=0;
RF_WE_1=1;
RF_DATAIN_1=2'b10;
READ_CH_1=1;
PC_DIRECT_CH_1=0;
	  end	
 endcase
   end
 				   NOP :
   begin
	STB_O_1 =1;
	ALU_SHIFT_1=0;
	WRITE_CH_1=0;
	WRITE_ADDR_1=0;
	ALU_CONTROL_1 =3'b111;
	ALU_DATAIN_1 =0;
	RF_DATAIN_1=0;
	READ_CH_1=1;
	READ_ADDR_1=0;
	PC_DIRECT_CH_1=0;
	RF_HL_1=0;
	RESULT_HL_1=0;
  
   PC_MUX_1=0;
   MEM_WE_1=0;
   RF_WE_1=0;
	end	
			
	default : 
	   begin
PC_MUX_1=0;
MEM_WE_1=0;
RF_WE_1=0;
	end
	
	
	
endcase	
	end

endmodule
