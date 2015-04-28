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
module RF(
input clk,
input reset,
input rf_hl,
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
wire [31:0] data_in_h;
wire [31:0] data_in_l;
integer i;

assign data_in_h = {data_in[31:16],out_reg3[15:0]};
assign data_in_l = {out_reg3[31:16],data_in[15:0]};

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
     

	  if(~we)
       begin	                   
			out_reg1 <= registers[reg_port1];
         out_reg2	<= registers[reg_port2];	
			out_reg3 <= registers[write_reg];
       end
     else 
       begin	
           if(rf_hl)		 
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
