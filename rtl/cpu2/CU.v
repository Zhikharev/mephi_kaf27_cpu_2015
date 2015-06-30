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
	input [3:0] op,
	output memtoreg,
	output memwrite,
	output branch,
	output [2:0] alucontrol,
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
	 
reg regwrite_reg;
reg regdst_reg;
reg alusrc_reg;
reg branch_reg;
reg memwrite_reg;
reg memtoreg_reg;
reg jump_reg;
reg [2:0] alucontrol_reg;

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
				alucontrol_reg <= 3'b001;
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
				alucontrol_reg <= 3'b000;
			end

		default:
			begin
				regwrite_reg <= 1'b0;
				regdst_reg <= 1'b0;
				alusrc_reg <= 1'b0;
				branch_reg <= 1'b0;
				memwrite_reg <= 1'b0;
				memtoreg_reg <= 1'b0;
				jump_reg <= 1'b0;
				alucontrol_reg <= 3'b111;
			end
	endcase

assign regwrite = regwrite_reg;
assign regdst = regdst_reg;
assign alusrc = alusrc_reg;
assign branch = branch_reg;
assign memwrite = memwrite_reg;
assign memtoreg = memtoreg_reg;
assign jump = jump_reg;
assign alucontrol = alucontrol_reg;

endmodule
