/*
###########################################################
#
# Author: Gerasimchuk Aleksey
#
# Project: MEPHI CPU
# Filename: CPU_TOP.v
# Descriptions:
#   
###########################################################
*/
module CPU_TOP(
input sys_clk, 
input sys_rst,

output [15:0]  data_data_o,

input [15:0] data_data_i,
output [15:0]  data_addr_o,
output  data_stb_o,
output  data_we_o,
input data_ack_i,

input [15:0] instr_data_i,
output [15:0]  instr_addr_o,
output  instr_stb_o,
output instr_we_o,
input instr_ack_i
    );
wire memtoreg_wire;
wire memwrite_wire;
wire branch_wire;
wire [3:0] alucontrol_wire;
wire alusrc_wire;
wire regdst_wire;
wire regwrite_wire;
wire jump_wire;

wire pcsrc_wire;
// wire [9:0] pc_in_wire;
wire [9:0] pc_out_wire;

// wire [31:0] srca_wire;
wire [31:0] srcb_wire;
wire [4:0] ra2_wire;
wire [4:0] ra3_wire;
wire [31:0] wd3_wire;
wire we3_wire;
wire [31:0] rd1_wire;
wire [31:0] rd2_wire;

wire [15:0] aluresult_wire;
wire zero_wire;

wire [15:0] mem_result;

wire [15:0] pc_result;
wire [9:0] signimm;
wire [9:0] signimm_shift;
wire [9:0] pcbranch;
wire [9:0] pcplus4;

wire [9:0] instr_data_i_shift;

PC PC(
	.clk(sys_clk),
	.reset(sys_rst),
	.pc_in(pc_result2),//
	.pcsrc(pcsrc_wire),//
	.pc_out(pc_out_wire)//
);

CU CU(
	.instr(instr_data_i),
	.memtoreg(memtoreg_wire),
	.memwrite(memwrite_wire),
	.branch(branch_wire),
	.alucontrol(alucontrol_wire),
	.alusrc(alusrc_wire),
	.regdst(regdst_wire),
	.regwrite(regwrite_wire),
	.jump(jump_wire)
);

ALU ALU(
    .srca(rd1_wire),
    .srcb(srcb_wire),
    .alucontrol(alucontrol_wire),
    .aluresult(aluresult_wire),
    .zero(zero_wire)
);

RF RF(
	.clk(sys_clk),
	.reset(sys_rst),
	.ra1(ra1_wire),
	.ra2(ra2_wire),
	.ra3(ra3_wire),
	.wd3(mem_result),
	.we3(regwrite_wire),
	.rd1(rd1_wire),
	.rd2(rd2_wire)
);

//pc
assign pcsrc_wire = branch_wire & zero_wire;
always @*
	if memtoreg_wire & data_ack_i == 1
		if instr_data_i[11] == 0
			mem_result[15:0] = data_data_i;
		else
			mem_result[31:16] = data_data_i;
	else
		mem_result = aluresult_wire;

assign pc_result = (pcsrc_wire == 1) ? pcbranch : pcplus4;
assign signimm_shift = signimm << 1;
assign pcbranch = signimm_shift + pcplus4;
assign pcplus4 = pc_out_wire + 4;
assign instr_data_i_shift = instr_data_i << 1;
assign pc_result2 = (jump_wire == 1) ? {pcplus4[9:8], instr_data_i_shift[7:0]} : pc_result;

//alu
assign srcb_wire = (alusrc == 1) ? signimm : rd2_wire;
always @*
	if instr_data_i[11] == 0
		data_data_o[15:0] = rd2_wire;
	else
		data_data_o[31:0] = rd2_wire;
assign data_addr_o = aluresult_wire;
assign data_we_o = memwrite_wire;

endmodule
