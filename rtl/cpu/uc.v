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
module UC(
input clk,
input [15:0] instr,
input data_ack_i,
input instr_ack_i,
input zero,                  // zero FLAG
output rf_hl,                // ÇÀÏÈÑÜ Â HIGH/LOW Â ĞÔ
output result_hl,            //ÇÀÏÈÑÜ Â MEM HIGL/LOW
output [1:0] pc_direct_ch,   // ÂÛÁÎĞ ÍÀ ÂÕÎÄÅ DIRECT
output data_stb_o,           //ĞÀÇĞÅØÀÅÒ ÂÅÄÎÌÎÌÓ ÓÑÒĞÎÉÑÒÂÓ ĞÀÁÎÒÀÒÜ
output instr_stb_o,
output [3:0] alu_shift,      // ÇÍÀ×ÅÍÈÅ ÑÄÂÈÃÀ
output write_ch,	           // ÂÛÁÎĞ ÀÄĞÅÑÀ ÍÀ ÇÀÏÈÑÜ Â ĞÔ
output result_ch,            // ÂÛÁÎĞ ĞÅÇÓËÜÒÀÒÀ ÏÎÑËÅ ÀËÓ
output [3:0] write_addr,     //  ÀÄĞÅÑ ÍÀ ÇÀÏÈÑÜ Â ĞÔ
output [1:0] pc_mux,         // ÂÛÁÎĞ ÏÅĞÅÄ ĞÑ
output mem_we,               // ĞÀÇĞÅØÅÍÈÅ ÇÀÏÈÑÈ Â ÌÅÌ
output instr_we_o,
output [2:0] alu_control,    // ÂÛÁÎĞ ÎÏÅĞÀÖÈÈ Â ÀËÓ
output [31:0] alu_datain,    // ÄÀÍÍÛÅ ÍÀ ÂÕÎÄ ÀËÓ
output [3:0] read_addr,      // ÀÄĞÅÑ ÄËß ×ÒÅÍÈß ÈÇ ĞÔ
output read_ch,              //  ÂÛÁÎĞ ÀÄĞÅÑÀ ÄËß ×ÒÅÍÈß ÈÇ ĞÔ
output rf_we,                // ĞÀÇĞÅØÅÍÈÅ ÍÀ ÇÀÏÈÑÜ Â ĞÔ
output [1:0] rf_datain            // ÂÛÁÎĞ ÄÀÍÍÛ ÄËß ÇÀÏÈÑÈ Â ĞÔ
//output DAT_O_CH              // ÂÛÁÎĞ ÄÀÍÍÛÕ ÄËß ÇÀÏÈÑÈ Â MEM
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
reg stb_o_1;
reg [3:0] alu_shift_1;
reg write_ch_1;
reg result_ch_1;
reg [3:0] write_addr_1;
reg [1:0] pc_mux_1;
reg mem_we_1;
reg [2:0] alu_control_1;
reg [31:0] alu_datain_1;
reg rf_we_1;
reg [1:0] rf_datain_1;
reg read_ch_1;
reg [3:0] read_addr_1;
reg [1:0] pc_direct_ch_1;
reg rf_hl_1;
reg result_hl_1;
reg instr_we_o_1;

assign instr_stb_o = stb_o_1;
assign data_stb_o = stb_o_1;
assign alu_shift = alu_shift_1;
assign write_ch = write_ch_1;
assign result_ch = result_ch_1;
assign write_addr = write_addr_1;
assign pc_mux = pc_mux_1;
assign mem_we = mem_we_1;
assign alu_control = alu_control_1;
assign alu_datain = alu_datain_1;
assign rf_we = rf_we_1;
assign rf_datain = rf_datain_1;
assign read_ch = read_ch_1;
assign read_addr = read_addr_1;
assign pc_direct_ch = pc_direct_ch_1;
assign rf_hl = rf_hl_1;
assign result_hl = result_hl_1;


assign instr_we_o = instr_we_o_1;
assign op = instr[15:12];
assign mtype = instr[11:10];

always@*
   begin
   case(op)
   			     ADD :
   begin
	instr_we_o_1=0;
	stb_o_1 =1;
	alu_shift_1=0;
	write_addr_1=0;
	read_addr_1=0;
	pc_direct_ch_1=0;
	rf_hl_1=0;
	result_hl_1=0;
write_ch_1 =1;
result_ch_1 =1;
pc_mux_1 =2'b10;
mem_we_1 =0;
alu_control_1 =0;
alu_datain_1 =0;
rf_we_1 =1;
rf_datain_1 =1;
read_ch_1 =1;
   end							  
	               ADDI :
   begin	
	instr_we_o_1=0;
	stb_o_1 =1;
	alu_shift_1=0;
	write_addr_1=0;
	read_addr_1=0;
	pc_direct_ch_1=0;
	rf_hl_1=0;
	result_hl_1=0;
write_ch_1 =1;
result_ch_1 =1;
pc_mux_1 =2'b10;
mem_we_1 =0;
alu_control_1 =0;
alu_datain_1 =1;
rf_we_1 =1;
rf_datain_1 =1;
read_ch_1 =1;
	end	
				OR :
	begin
	instr_we_o_1=0;
	
	stb_o_1 =1;
	alu_shift_1=0;
	write_addr_1=0;
	read_addr_1=0;
	pc_direct_ch_1=0;
	rf_hl_1=0;
	result_hl_1=0;
write_ch_1 =1;
result_ch_1 =1;
pc_mux_1 =2'b10;
mem_we_1 =0;
alu_control_1 = 3'b001;
alu_datain_1 =0;
rf_we_1 =1;
rf_datain_1 =1;
read_ch_1 =1;
	end	
            
				AND :
	begin
	instr_we_o_1=0;
	stb_o_1 =1;
	alu_shift_1=0;
	write_addr_1=0;
	read_addr_1=0;
	pc_direct_ch_1=0;
	rf_hl_1=0;
	result_hl_1=0;
write_ch_1 =1;
result_ch_1 =1;
pc_mux_1 =2'b10;
mem_we_1 =0;
alu_control_1 =3'b010;
alu_datain_1 =0;
rf_we_1 =1;
rf_datain_1 =1;
read_ch_1 =1;
	end	
            
				XOR :
	begin
	instr_we_o_1=0;
	stb_o_1 =1;
	alu_shift_1=0;
	write_addr_1=0;
	read_addr_1=0;
	pc_direct_ch_1=0;
	rf_hl_1=0;
	result_hl_1=0;
write_ch_1 =1;
result_ch_1 =1;
pc_mux_1 =2'b10;
mem_we_1 =0;
alu_control_1 =3'b011;
alu_datain_1 =0;
rf_we_1 =1;
rf_datain_1 =1;
read_ch_1 =1;
	end	
            
				NOR :
   begin
	instr_we_o_1=0;
	stb_o_1 =1;
	alu_shift_1=0;
	write_addr_1=0;
	read_addr_1=0;
	pc_direct_ch_1=0;
	rf_hl_1=0;
	result_hl_1=0;
write_ch_1 =1;
result_ch_1 =1;
pc_mux_1 =2'b10;
mem_we_1 =0;
alu_control_1 =3'b100;
alu_datain_1 =0;
rf_we_1 =1;
rf_datain_1 =1;
read_ch_1 =1;
	end	
				SLL :
   begin
	instr_we_o_1=0;
	stb_o_1 =1;
	
	write_addr_1=0;
	read_addr_1=0;
	pc_direct_ch_1=0;
	rf_hl_1=0;
	result_hl_1=0;
alu_shift_1  = instr[7:4];
write_ch_1 =1;
result_ch_1 =1;
pc_mux_1 =2'b10;
mem_we_1 =0;
alu_control_1 =3'b101;
alu_datain_1 =0;
rf_we_1 =1;
rf_datain_1 =1;
read_ch_1 =1;
	end	
				ROT :
   begin
	instr_we_o_1=0;
	stb_o_1 =1;
	
	write_addr_1=0;
	read_addr_1=0;
	pc_direct_ch_1=0;
	rf_hl_1=0;
	result_hl_1=0;

alu_shift_1  = instr[7:4];
write_ch_1 =1;
result_ch_1 =1;
pc_mux_1 =2'b10;
mem_we_1 =0;
alu_control_1 =3'b110;
alu_datain_1 =0;
rf_we_1 =1;
rf_datain_1 =1;
read_ch_1 =1;
	end	
				BNE :
   begin
	instr_we_o_1=0;
	
   result_ch_1 =1;
	rf_datain_1 =0;
	stb_o_1 =1;
	alu_shift_1=0;
	write_addr_1=0;
	read_addr_1=0;
	rf_hl_1=0;
	result_hl_1=0;
	
write_ch_1 =1;
if(zero)
 pc_mux_1 =2'b01;
else
 pc_mux_1 =2'b10;
mem_we_1 =0;
alu_control_1 =3'b111;
alu_datain_1 =0;
rf_we_1 =0;
read_ch_1 =1;
pc_direct_ch_1 =2'b01;
	end	
				LD :
   begin
	instr_we_o_1=0;
	stb_o_1 =1;
	alu_shift_1=0;
	write_addr_1=0;
	read_addr_1=0;
	pc_direct_ch_1=0;   
	result_ch_1 =1;
	alu_control_1 =3'b111;
	alu_datain_1 =0;
	read_ch_1 =1;

	result_hl_1=0;
write_ch_1=0;
write_addr_1=4'b1010;
if(data_ack_i)
pc_mux_1=2'b10;
else
pc_mux_1=2'b00;
mem_we_1=0;
rf_we_1=1;
rf_datain_1=0;
     if(mtype)
        rf_hl_1=1;///
	  else
	     rf_hl_1 =0;///
	end	
				ST :
   begin
	instr_we_o_1=0;
	stb_o_1 =1;
	alu_shift_1=0;
	write_ch_1=0;
	alu_control_1 =3'b111;
	alu_datain_1 =0;
	rf_datain_1=0;

	read_addr_1=0;
	pc_direct_ch_1=0;
	rf_hl_1=0;
	
result_ch_1=0;
pc_mux_1=2'b10;
mem_we_1=1;
rf_we_1=0;
read_ch_1=0;
read_addr_1=4'b1010;
if(mtype)
 result_hl_1=1;
else
 result_hl_1=0;
	end	
 				    JMP :
   begin
	instr_we_o_1=0;
	stb_o_1 =1;
	alu_shift_1=0;	
	alu_control_1 =3'b111;
	alu_datain_1 =0;	
	read_addr_1=0;
	rf_hl_1=0;
   result_hl_1=0;	
 case(mtype)
			 2'b00:
     begin
	  write_ch_1=0;
     write_addr_1=0;
	  result_ch_1=0;
	  rf_datain_1=0;
     read_ch_1=0;

pc_mux_1=01;
mem_we_1=0;
rf_we_1=0;
pc_direct_ch_1=2'b01;
	  end	
				2'b01 :
     begin
	  
	  result_ch_1=0;	
	  read_ch_1=0;

write_ch_1=0;
write_addr_1=4'b1011;
pc_mux_1=1;
mem_we_1=0;
rf_we_1=1;
rf_datain_1=2'b10;
pc_direct_ch_1=1;
	  end	
				2'b10 :
     begin
	  write_ch_1=0;
     write_addr_1=0;
	  rf_datain_1=0;

result_ch_1=0;
pc_mux_1=1;
mem_we_1=0;
rf_we_1=0;
read_ch_1=1;
pc_direct_ch_1=0;
	  end	
				2'b11:
     begin
write_ch_1=0;
result_ch_1=0;
write_addr_1=4'b1011;
pc_mux_1=1;
mem_we_1=0;
rf_we_1=1;
rf_datain_1=2'b10;
read_ch_1=1;
pc_direct_ch_1=0;
	  end	
 endcase
   end
 				   NOP :
   begin
	instr_we_o_1=0;
	stb_o_1 =1;
	alu_shift_1=0;
	write_ch_1=0;
	write_addr_1=0;
	alu_control_1 =3'b111;
	alu_datain_1 =0;
	rf_datain_1=0;
	read_ch_1=1;
	read_addr_1=0;
	pc_direct_ch_1=0;
	rf_hl_1=0;
	result_hl_1=0;
  
   pc_mux_1=0;
   mem_we_1=0;
   rf_we_1=0;
	end	
			
	default : 
	   begin
pc_mux_1=0;
mem_we_1=0;
rf_we_1=0;
	end
	
	
	
endcase	
	end

endmodule
