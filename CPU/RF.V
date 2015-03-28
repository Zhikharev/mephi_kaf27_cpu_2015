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
input [4:0] reg_port1, // порт для записи адреса рег1
input [4:0] reg_port2, // порт для записи адреса рег2
input [31:0] write_reg, // порт для записи в рф
input we,

output [31:0] reg_out1,
output [31:0] reg_out2

    );

reg [31:0] registers [0:15] ;
reg [31:0] out_reg;
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
         if(reg_port1)
	         begin
		          out_reg <= registers[reg_port1];
		      end
          else 
			       out_reg <= out_reg;
       end
      else
		   begin
		      if(reg_port1)
		         registers[reg_port1] <= write_reg;
		  //    else/// нужно доделать
		  
		   end
		
	end

end












assign reg_out1 = out_reg;


endmodule
