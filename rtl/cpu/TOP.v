`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:08:13 04/22/2015 
// Design Name: 
// Module Name:    TOP 
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
module TOP(
//input STALL_I,
input ACK_I,
//input ERR_I,
input [15:0] DAT_I,
input [15:0] INSTR_I,
input CLK_I, 
input RST_I,

 
output  STB_O,
//output  LOCK_O,
//output  CYC_O,
output  WE_O,
output [15:0]  INSTR_ADR_O,
output [15:0]  DAT_ADR_O,
output [15:0]  DAT_O

    );
	 wire  READ_CH;
wire [1:0]PC_MUX;
wire [1:0]PC_DIRECT_CH;
wire [9:0]PC;
wire [9:0]PC_2;
wire [31:0]RESULT;
wire [31:0]PC_rd;

PC unit(
.clk(CLK_I),
.PC_MUX(PC_MUX),
.PC_DIRECT_CH(PC_DIRECT_CH),
.instr(INSTR_I),
.PC(PC),
.PC_2(PC_2),
.RESULT_PC(RESULT),
.PC_rd(PC_rd),
.reset(RST_I)
);
wire[3:0]ALU_SHIFT;
wire[3:0]WRITE_ADDR;
wire[2:0]ALU_CONTROL;
wire[31:0]ALU_DATAIN;
wire[3:0]READ_ADDR;

wire[1:0]RF_DATAIN;

UC unit2(

.clk (CLK_I),
.ack(ACK_I),
. instr(INSTR_I),
.ZERO (ZERO),                  
.RF_HL (RF_HL),                
.RESULT_HL (RESULT_HL),            
.PC_DIRECT_CH (PC_DIRECT_CH),   
.STB_O (STB_O),                
.ALU_SHIFT (ALU_SHIFT),      
.WRITE_CH (WRITE_CH),	           
.RESULT_CH (RESULT_CH),            
.WRITE_ADDR (WRITE_ADDR),      
.PC_MUX (PC_MUX),           
.MEM_WE (WE_O),                
.ALU_CONTROL (ALU_CONTROL),    
.ALU_DATAIN (ALU_DATAIN),    
.READ_ADDR (READ_ADDR),      
.READ_CH (READ_CH),              
.RF_WE (RF_WE),                
.RF_DATAIN (RF_DATAIN)
           
);
wire[31:0]SR1;
wire[31:0]SR2;
//wire[]ALU_CONTROL;
//wire[]ALU_SHIFT;
wire[31:0]RD;
//wire[3:0]ALU_SHIFT;
alu unit3(
.clk(CLK_I),
.sr1 (SR1),   ////
.sr2 (SR2),   ////
.os(ALU_CONTROL),   
. shift(ALU_SHIFT), 
.rd(RD),      ////
.ZERO(ZERO)     
);
wire[3:0]READ_ADDR1;
wire[3:0]READ_ADDR2;
wire[3:0]WRITE_ADDR_REG;
wire[31:0]DATA_IN;
wire[31:0]DATA_OUT1;
wire[31:0]DATA_OUT2;
wire[31:0]R_rd;

RF unit4(
.clk(CLK_I),
.reset(RST_I),
.RF_HL(RF_HL),
.reg_port1(READ_ADDR1),  // порт для  адреса рег1
.reg_port2(READ_ADDR2),  // порт для  адреса рег2
.write_reg(WRITE_ADDR_REG),  // порт для адреса записи в рф
.data_in(DATA_IN),      // данные для записи в рф
.we(RF_WE),               
.reg_out1(DATA_OUT1),    // 
.reg_out2(DATA_OUT2),    // 
.reg_out3(R_rd)     //

);
wire [31:0] R_rd_1;
wire [31:0] SIGN_EXT;
wire [31:0] RESULT_O;
assign R_rd_1 = R_rd;

wire [15:0]DAT_O_L;
wire [15:0]DAT_O_H;

assign PC_rd = R_rd_1 + PC;
assign SR1 = DATA_OUT2;
assign SIGN_EXT ={28'b0,INSTR_I[11:8]};
assign SR2 =(ALU_DATAIN==0) ? DATA_OUT1: SIGN_EXT ;
assign RESULT = (RESULT_CH==0) ? SR1 :RD ;
assign DATA_IN = (RF_DATAIN==2'b00) ? DAT_I : (RF_DATAIN==2'b01)? RESULT : PC_2;  
assign WRITE_ADDR_REG =(WRITE_CH==0) ? WRITE_ADDR : INSTR_I[3:0] ;
assign READ_ADDR2 =(READ_CH==0) ? READ_ADDR : INSTR_I[7:4] ;
assign READ_ADDR1 = INSTR_I[11:8];
assign DAT_ADR_O = INSTR_I[9:0];
assign INSTR_ADR_O = PC;
assign RESULT_O = RESULT;
assign DAT_O_L = RESULT_O[15:0];
assign DAT_O_H = RESULT_O[31:16];
assign DAT_O = (RESULT_HL==0) ? DAT_O_L : DAT_O_H;
endmodule
