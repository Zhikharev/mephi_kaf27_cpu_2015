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

mc_top mc_top (
	.sys_clk 			(),
	.sys_rst 			(),
	.cpu_inst_stb_i 	(),
	.cpu_inst_ack_o 	(), 
	.cpu_inst_addr_i 	(),
	.cpu_inst_data_o 	(),
	.cpu_data_stb_i 	(),
	.cpu_data_we_i 		(),
	.cpu_data_ack_o 	(), 
	.cpu_data_addr_i 	(),
	.cpu_data_data_i 	(),
	.cpu_data_data_o 	(),
	.io_stb_o 			(),
	.io_stb_i 			(),
	.io_ack_o 			(),
	.io_ack_i 			(),
	.io_we_o 			(),
	.io_we_i 			(),
	.io_addr_i 			(),
	.io_addr_o 			(),
	.io_data_i 			(),
	.io_data_o 			(),
    .mcb1_dram_dq 		(),
    .mcb1_dram_a 		(),
    .mcb1_dram_ba, 
    .mcb1_dram_ras_n,
    .mcb1_dram_cas_n,
    .mcb1_dram_we_n,
    .mcb1_dram_odt,
    .mcb1_dram_cke,
    .mcb1_dram_dm,
    .mcb1_dram_udqs,
    .mcb1_dram_udqs_n,
    .mcb1_rzq,
    .mcb1_zio,
    .mcb1_dram_udm,
    .mcb1_dram_dqs,
    .mcb1_dram_dqs_n,
    .mcb1_dram_ck,
    .mcb1_dram_ck_n
);


endmodule