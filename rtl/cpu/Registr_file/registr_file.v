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
module proverka(
input clk,
input reset,
input [4:0] reg_port1,  // ���� ���  ������ ���1
input [4:0] reg_port2,  // ���� ���  ������ ���2
input [4:0] write_reg,  // ���� ��� ������ ������ � ��
input [31:0] data_in,   // ������ ��� ������ � ��
input we,               // Write Enable

output [31:0] reg_out1, // ����� 1
output [31:0] reg_out2  // ����� 2

    );

reg [31:0] registers [0:15] ; // ��� ������. ����
reg [31:0] out_reg1;          // �������� ���.1
reg [31:0] out_reg2;          // �������� ���.2

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
       end
     else 
       begin		
		   out_reg1 <= out_reg1;
     	   out_reg2 <= out_reg2;
         registers[write_reg] <= data_in ;			
       end		   
	end
end

assign reg_out1 = out_reg1;
assign reg_out2 = out_reg2;

endmodule
