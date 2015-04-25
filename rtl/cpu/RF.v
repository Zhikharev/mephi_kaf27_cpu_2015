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
input [3:0] reg_port1,  // порт для  адреса рег1
input [3:0] reg_port2,  // порт для  адреса рег2
input [3:0] write_reg,  // порт для адреса записи в рф
input [31:0] data_in,   // данные для записи в рф
input we,               // Write Enable

output [31:0] reg_out1, // Выход 1
output [31:0] reg_out2,  // Выход 2
output [31:0] reg_out3
    );

reg [31:0] registers [0:15] ; // Сам регист. файл
reg [31:0] out_reg1;          // выходной рег.1
reg [31:0] out_reg2;          // выходной рег.2
reg [31:0] out_reg3;
reg [31:0] data_in_h;
reg [31:0] data_in_l;
integer i;

  always@(posedge clk,posedge reset)
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
     assign data_in_h = {data_in[31:16],out_reg3[15:0]};
     assign data_in_l = {out_reg3[31:16],data_in[15:0]};

	  if(~we)
       begin	                   
			out_reg1 <= registers[reg_port1];
         out_reg2	<= registers[reg_port2];	
			out_reg3 <= registers[write_reg];
       end
     else 
       begin	
           if(RF_HL)		 
			      registers[write_reg] <= data_in_h ;
            else
			      registers[write_reg] <= data_in_l ;  				
       end		   
	end
end

assign reg_out1 = out_reg1;
assign reg_out2 = out_reg2;
assign reg_out3 = out_reg3;
//assign data_in_h = {outreg_3[31:16]+data_in[31:16],outreg[15:0]};
//assign data_in_l = {outreg_3[31:16],outreg_3[15:0]+data_in[15:0]};
endmodule
