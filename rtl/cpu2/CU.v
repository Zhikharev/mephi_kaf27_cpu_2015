/*
###########################################################
#
# Author: Gerasimchuk Aleksey
#
# Project: MEPHI CPU
# Filename: CU.v
# Descriptions:
# 	
###########################################################
*/
module CU(
	input [15:0] instr,
	output memtoreg,
	output memwrite,
	output branch,
	output [3:0] alucontrol,
	output alusrc,
	output regdst,
	output regwrite,
	output jump
	);
	 
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
	 
wire [3:0] op;
reg regwrite_reg;
reg regdst_reg;
reg alusrc_reg;
reg branch_reg;
reg memwrite_reg;
reg memtoreg_reg;
reg jump_reg;
reg [3:0] alucontrol_reg;

assign op = instr[15:12];


// always @*
// 	case(aluop)
// 		2’b00: alucontrol <= 3’b010; // add (for lw/sw/addi)
// 		2’b01: alucontrol <= 3’b110; // sub (for beq)
// 		default: 
// 			case(funct) // R-type instructions
// 				6’b100000: alucontrol <= 3’b010; // add
// 				6’b100010: alucontrol <= 3’b110; // sub
// 				6’b100100: alucontrol <= 3’b000; // and
// 				6’b100101: alucontrol <= 3’b001; // or
// 				6’b101010: alucontrol <= 3’b111; // slt
// 				default: alucontrol <= 3’bxxx; // ???
// 			endcase
// 	endcase


always @*
	case(op)
		ADD:
			begin
				regwrite_reg <= 1'b1;
				regdst_reg <= 1'b1;
				alusrc_reg <= 1'b0;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b0;
				alucontrol_reg <= 3'b000;
			end

		ADDI:
			begin
				regwrite_reg <= 'b1;
				regdst_reg <= 1'b0;
				alusrc_reg <= 1'b1;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b0;
				alucontrol_reg <= 3'b000;
			end

		OR:
			begin
				regwrite_reg <= 1'b1;
				regdst_reg <= 1'b1;
				alusrc_reg <= 1'b0;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b0;
				alucontrol <= 3'b001;
			end

		AND:
			begin
				regwrite_reg <= 1'b1;
				regdst_reg <= 1'b1;
				alusrc_reg <= 1'b0;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b0;
				alucontrol_reg <= 3'b010;
			end

		XOR:
			begin
				regwrite_reg <= 1'b1;
				regdst_reg <= 1'b1;
				alusrc_reg <= 1'b0;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b0;
				alucontrol_reg <= 3'b011;
			end

		NOR:
			begin
				regwrite_reg <= 1'b1;
				regdst_reg <= 1'b1;
				alusrc_reg <= 1'b0;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b0;
				alucontrol_reg <= 3'b100;
			end

		SLL:
			begin
				regwrite_reg <= 1'b1;
				regdst_reg <= 1'b1;
				alusrc_reg <= 1'b0;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b0;
				alucontrol_reg <= 3'b100;
			end

		ROT:
			begin
				regwrite_reg <= 1'b1;
				regdst_reg <= 1'b1;
				alusrc_reg <= 1'b0;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b0;
				alucontrol_reg <= 3'b101;
			end

		BNE:
			begin
				regwrite_reg <= 1'b0;
				regdst_reg <= 1'b0;
				alusrc_reg <= 1'b0;
				branch_reg <= 1'b1;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b0;
				alucontrol_reg <= 3'b111;
			end

		LD:
			begin
				regwrite_reg <= 1'b1;
				regdst_reg <= 1'b0;
				alusrc_reg <= 1'b1;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b1;
				jump_reg <= 1'b0;
				alucontrol_reg <= 3'b000;
			end

		ST:
			begin
				regwrite_reg <= 1'b0;
				regdst_reg <= 1'b0;
				alusrc_reg <= 1'b1;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b1;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b0;
				alucontrol_reg <= 3'b000;
			end

		JMP:
			begin
				regwrite_reg <= 1'b0;
				regdst_reg <= 1'b0;
				alusrc_reg <= 1'b0;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b1;
				alucontrol_reg <= 3'bxxx;
			end

		NOP:
			begin
				regwrite_reg <= 1'b0;
				regdst_reg <= 1'b0;
				alusrc_reg <= 1'b0;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b1;
				alucontrol_reg <= 3'b111;
			end

assign regwrite = regwrite_reg;
assign regdst = regdst_reg;
assign alusrc = alusrc_reg;
assign branch = branch_reg;
assign memwrite = memwrite_reg;
assign memtoreg = memtoreg_reg;
assign jump = jump_reg;
assign alucontrol = alucontrol_reg;

endmodule
