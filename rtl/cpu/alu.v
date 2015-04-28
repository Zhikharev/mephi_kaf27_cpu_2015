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
module alu(
input clk,
input [31:0] sr1,   // ������ ����
input [31:0] sr2,   // ������ ����
input  [2:0] os,    // ������. ������
input [3:0] shift, // �� ������� ���. ��������
output [31:0] rd,   // ���������
output zero     // �� ���� ������

	);
reg zero_1;
reg [31:0] reg_rd;
wire [31:0] rot;
wire [31:0] log_shift;
shift uutt(
.clk(clk),
.sr1(sr1),
.rot(rot),
.shift(shift),
.log_shift(log_shift)
);

always @* // ����� ��������� �� ����� ���� �������� always
  begin
    case (os)
         3'b000 : reg_rd = sr1 + sr2;	// ��������	( �������� � ���������� )
         3'b001 : reg_rd = sr1 | sr2;   // ��������� ��� 
         3'b010 : reg_rd = sr1 & sr2;   // ��������� �
         3'b011 : reg_rd = sr1 ^ sr2;   // ��������� ���� ���
         3'b100 : reg_rd = ~(sr1 | sr2);       // ��������� ���������
         3'b101 : reg_rd = log_shift;	//	���������� ����� �����	  
			3'b110 : reg_rd = rot;         // ���������� ����� 
			3'b111 : 
			   begin
				   reg_rd = sr1 - sr2;// ���������
			      zero_1 = 1;
				end
			default : reg_rd = 0;
      endcase  
  end
assign rd = reg_rd;	
assign zero = zero_1;
endmodule
