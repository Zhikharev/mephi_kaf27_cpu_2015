/*
###########################################################
#
# Author: 
#
# Project: MEPHI CPU
# Filename: mephi_cpu_top.v
# Descriptions: System top module
#
###########################################################
*/

module mephi_cpu_top (
);


wire [15:0] cpu_instr_data;
wire [15:0] cpu_instr_addr;
wire        cpu_instr_stb;
wire        cpu_instr_we;
wire        cpu_instr_ack;

wire [15:0] cpu_data_data_o;
wire [15:0] cpu_data_data_i;
wire [15:0] cpu_data_addr;
wire        cpu_data_stb;
wire        cpu_data_we;
wire        cpu_data_ack;

wire        io_ack_i;
wire        io_stb_i;
wire [15:0] io_addr_i;
wire [15:0] io_dat_i;
wire        io_we_i;
wire        io_ack_o;
wire        io_stb_o;
wire [15:0] io_addr_o;
wire [15:0] io_dat_o;
wire        io_we_o;



cpu_top cpu_top (
    .sys_clk            (), 
    .sys_rst            (),
    .data_data_o        (cpu_data_data_o),
    .data_data_i        (cpu_data_data_i),
    .data_addr_o        (cpu_data_addr),
    .data_stb_o         (cpu_data_stb),
    .data_we_o          (cpu_data_we),
    .data_ack_i         (cpu_data_ack),
    .instr_data_i       (cpu_instr_data),
    .instr_addr_o       (cpu_instr_addr),
    .instr_stb_o        (cpu_instr_stb),
    .instr_we_o         (cpu_instr_we),
    .instr_ack_i        (cpu_instr_ack)
);

mc_top mc_top (
	.sys_clk 			(),
	.sys_rst 			(),
	.cpu_inst_stb_i 	(cpu_inst_stb),
	.cpu_inst_ack_o 	(cpu_inst_ack), 
	.cpu_inst_addr_i 	(cpu_inst_addr),
	.cpu_inst_data_o 	(cpu_inst_data),
	.cpu_data_stb_i 	(cpu_data_stb),
	.cpu_data_we_i 		(cpu_data_we),
	.cpu_data_ack_o 	(cpu_data_ack), 
	.cpu_data_addr_i 	(cpu_data_addr),
	.cpu_data_data_i 	(cpu_data_data_o),
	.cpu_data_data_o 	(cpu_data_data_i),
	.io_stb_o 			(io_stb_i),
	.io_stb_i 			(io_stb_o),
	.io_ack_o 			(io_ack_i),
	.io_ack_i 			(io_ack_o),
	.io_we_o 			(io_we_i),
	.io_we_i 			(io_we_o),
	.io_addr_i 			(io_addr_o),
	.io_addr_o 			(io_addr_i),
	.io_data_i 			(io_data_o),
	.io_data_o 			(io_data_i),
    .mcb1_dram_dq 		(),
    .mcb1_dram_a 		(),
    .mcb1_dram_ba       (), 
    .mcb1_dram_ras_n    (),
    .mcb1_dram_cas_n    (),
    .mcb1_dram_we_n     (),
    .mcb1_dram_odt      (),
    .mcb1_dram_cke      (),
    .mcb1_dram_dm       (),
    .mcb1_dram_udqs     (),
    .mcb1_dram_udqs_n   (),
    .mcb1_rzq           (),
    .mcb1_zio           (),
    .mcb1_dram_udm      (),
    .mcb1_dram_dqs      (),
    .mcb1_dram_dqs_n    (),
    .mcb1_dram_ck       (),
    .mcb1_dram_ck_n     ()
);

IO_Hub iohub (
    .clk_i              (), 
    .rst_i              (), 
    .rx                 (), 
    .tx                 (), 	 
    .io_ack_i           (io_ack_i),
    .io_stb_i           (io_stb_i),
    .io_addr_i          (io_addr_i),
    .io_dat_i           (io_dat_i),
    .io_we_i            (io_we_i),
    .io_ack_o           (io_ack_o),
    .io_stb_o           (io_stb_o),
    .io_addr_o          (io_addr_o),
    .io_dat_o           (io_dat_o),
    .io_we_o            (io_we_o)
);

endmodule
