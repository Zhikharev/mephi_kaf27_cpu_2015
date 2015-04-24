`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:03 03/28/2015 
// Design Name: 
// Module Name:    proverka 
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
module RF(
input clk,
input reset,
input RF_HL,
input [3:0] reg_port1,  // ���� ���  ������ ���1
input [3:0] reg_port2,  // ���� ���  ������ ���2
input [3:0] write_reg,  // ���� ��� ������ ������ � ��
input [31:0] data_in,   // ������ ��� ������ � ��
input we,               // Write Enable

output [31:0] reg_out1, // ����� 1
output [31:0] reg_out2,  // ����� 2
output [31:0] reg_out3
    );

reg [31:0] registers [0:15] ; // ��� ������. ����
reg [31:0] out_reg1;          // �������� ���.1
reg [31:0] out_reg2;          // �������� ���.2
reg [31:0] out_reg3;
integer i;

  always@(posedge clk)
begin
  if(reset)
    begin
	   for(i = 0; i<16; i=i+1)
	     begin
	       registers[i] <=0;
		  end
	 end
  else
   begin
     if(~we)
       begin	                   
			out_reg1 <= registers[reg_port1];
         out_reg2	<= registers[reg_port2];	
			out_reg3 <= registers[write_reg];
       end
     else 
       begin		
		   out_reg1 <= out_reg1;
     	   out_reg2 <= out_reg2;
			out_reg3 <= out_reg3;
            if(RF_HL)
			      registers[write_reg[31:16]] <= data_in ;
            else
			      registers[write_reg[15:0]] <= data_in ;
  				
       end		   
	end
end

assign reg_out1 = out_reg1;
assign reg_out2 = out_reg2;
assign reg_out3 = out_reg3;
endmodule
