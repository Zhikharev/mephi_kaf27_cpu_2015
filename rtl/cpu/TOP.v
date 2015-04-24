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
input STALL_I,
input ACK_I,
input ERR_I,
input DAT_I,
input INSTR_I,
input CLK_I, 
input RST_I,

 
output  STB_O,
output  LOCK_O,
output  CYC_O,
output  WE_O,
output  INSTR_ADR_O,
output  ADR_O,
output  DAT_O

    );


endmodule
