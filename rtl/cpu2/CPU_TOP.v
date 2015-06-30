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
wire [15:0] instr_data_in;
wire memtoreg_wire;
wire memwrite_wire;
wire branch_wire;
wire [2:0] alucontrol_wire;
wire alusrc_wire;
wire regdst_wire;
wire regwrite_wire;
wire jump_wire;

wire pcsrc_wire;
// wire [9:0] pc_in_wire;
wire [9:0] pc_out_wire;

// wire [31:0] srca_wire;
wire [31:0] srcb_wire;
wire [4:0] ra1_wire;
wire [4:0] ra2_wire;
wire [4:0] ra3_wire;
wire [31:0] wd3_wire;
wire we3_wire;
wire [31:0] rd1_wire;
wire [31:0] rd2_wire;

wire [31:0] aluresult_wire;
wire zero_wire;

wire [31:0] mem_result;
reg [31:0] mem_result_reg;

wire [9:0] pc_result;
wire [9:0] pc_result2;
wire [9:0] signimm;
wire [9:0] signimm_shift;
wire [9:0] pcbranch;
wire [9:0] pcplus2;

wire [7:0] instr_data_i_shift;

reg [15:0] data_data_o_reg;

wire highlow;

PC u_pc(
	.clk(sys_clk),
	.reset(sys_rst),
	.pc_in(pc_result2),
	.pc_out(pc_out_wire)
);

CU u_cu(
	.op(instr_data_in[15:12]),
	.memtoreg(memtoreg_wire),
	.memwrite(memwrite_wire),
	.branch(branch_wire),
	.alucontrol(alucontrol_wire),
	.alusrc(alusrc_wire),
	.regdst(regdst_wire),
	.regwrite(regwrite_wire),
	.jump(jump_wire)
);

ALU u_alu(
    .srca(rd1_wire),
    .srcb(srcb_wire),
    .alucontrol(alucontrol_wire),
    .shift(instr_data_in[7:4]),
    .aluresult(aluresult_wire),
    .zero(zero_wire)
);

RF u_rf(
	.clk(sys_clk),
	.reset(sys_rst),
	.ra1(ra1_wire),
	.ra2(ra2_wire),
	.ra3(ra3_wire),
	.wd3(mem_result),
	.we3(regwrite_wire),
	.highlow(highlow),
	.memtoreg(memtoreg_wire),
	.data_ack_i(data_ack_i),
	.rd1(rd1_wire),
	.rd2(rd2_wire)
);

assign instr_data_in = (instr_ack_i == 1) ? instr_data_i : 15'b110000000000000;
//pc
assign pcsrc_wire = branch_wire & zero_wire;

always @*
begin
	if (memtoreg_wire == 1)
		mem_result_reg = {16'h0000, data_data_i};
	else
		mem_result_reg = aluresult_wire;
end;
		
assign highlow = instr_data_in[11];
		
assign mem_result = mem_result_reg;

assign signimm = instr_data_in[7:0];
assign pc_result = (pcsrc_wire == 1) ? pcbranch : pcplus2;
assign signimm_shift = signimm << 1;
assign pcbranch = signimm_shift + pcplus2;
assign pcplus2 = pc_out_wire + 10'b0000000010;
assign instr_data_i_shift = instr_data_in[7:0] << 1;
assign pc_result2 = (jump_wire == 1) ? {pcplus2[9:8], instr_data_i_shift} : pc_result;

//alu
assign srcb_wire = (alusrc_wire == 1'b1) ? signimm : rd2_wire;//?
always @*
	if (instr_data_in[11] == 1'b0)
		data_data_o_reg = rd2_wire[15:0];
	else
		data_data_o_reg = rd2_wire[31:16];
		
assign data_data_o = data_data_o_reg;
		
assign data_addr_o = aluresult_wire[15:0];
assign data_we_o = memwrite_wire;

//rf
assign ra1_wire = instr_data_in[11:8];
assign ra2_wire = instr_data_in[7:4];
assign ra3_wire = instr_data_in[3:0];


assign instr_addr_o = pc_out_wire;
endmodule
