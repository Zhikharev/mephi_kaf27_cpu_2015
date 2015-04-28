/*
###########################################################
#
# Author: Grigoriy Zhiharev 
#
# Project: MEPHI CPU
# Filename: mc_top.v
# Descriptions:
# 	DDR controller have 3 ports: one only rd for cpu_inst,
# 	second rd/wr for cpu_data and third rd/wr for IO. 
# 	Only one direction memory request is alloweded for IO.
###########################################################
*/

module mc_top #(parameter BOOT_ADDR = 0) 
(
	input sys_clk,
	input sys_rst,

	// CPU instruction interface
	input    		cpu_inst_stb_i,
	output 	 		cpu_inst_ack_o, 
	input 	[?] 	cpu_inst_addr_i,
	output  [15:0] 	cpu_inst_data_o,


	// CPU data memory interface
	input    		cpu_data_stb_i,
	input  			cpu_data_we_i,
	output 	 		cpu_data_ack_o, 
	input 	[15:0] 	cpu_data_addr_i,
	input   [15:0]  cpu_data_data_i
	output  [15:0] 	cpu_data_data_o,

	// IO inteface
	output    		io_stb_o,
	input           io_stb_i,
	output          io_ack_o,
	input 	 		io_ack_i,
	output          io_we_o,
	input           io_we_i,
	input   [15:0] 	io_addr_i,
	output  [15:0]  	io_addr_o
	input   [15:0] 	io_data_i,
	output  [15:0] 	io_data_o,

    // DDR2 interface
    inout   [15:0]  mcb1_dram_dq,
    output  [12:0]  mcb1_dram_a,
    output  [2:0]   mcb1_dram_ba, 
    output          mcb1_dram_ras_n,
    output          mcb1_dram_cas_n,
    output          mcb1_dram_we_n,
    output          mcb1_dram_odt,
    output          mcb1_dram_cke,
    output          mcb1_dram_dm,
    inout           mcb1_dram_udqs,
    inout           mcb1_dram_udqs_n,
    inout           mcb1_rzq,
    inout           mcb1_zio,
    output          mcb1_dram_udm,
    inout           mcb1_dram_dqs,
    inout           mcb1_dram_dqs_n,
    output          mcb1_dram_ck,
    output          mcb1_dram_ck_n
);

    wire [15:0] rom_data;
    wire [15:0] ram_data;
    wire        use_rom;
    wire [31:0] ram_p2_rd_data;
    wire        ram_p2_rd_en;

    assign cpu_inst_data_o (use_rom) ? rom_data : ram_data;
    assign ram_data

    rom rom (
	    .sys_clk (sys_clk),
        .sys_rst (sys_rst),
	    .addr_i  (cpu_inst_addr_i),
	    .data_o  (rom_data)
    );



    mc mc_ddr (
    .mcb1_dram_dq       (mcb1_dram_dq),
    .mcb1_dram_a        (mcb1_dram_a),
    .mcb1_dram_ba       (),
   mcb1_dram_ras_n,
   mcb1_dram_cas_n,
   mcb1_dram_we_n,
   mcb1_dram_odt,
   mcb1_dram_cke,
   mcb1_dram_dm,
   mcb1_dram_udqs,
   mcb1_dram_udqs_n,
   mcb1_rzq,
   mcb1_zio,
   mcb1_dram_udm,
   input                                            c1_sys_clk_p,
   input                                            c1_sys_clk_n,
   input                                            c1_sys_rst_i,
   output                                           c1_calib_done,
   output                                           c1_clk0,
   output                                           c1_rst0,
   inout                                            mcb1_dram_dqs,
   inout                                            mcb1_dram_dqs_n,
   output                                           mcb1_dram_ck,
   output                                           mcb1_dram_ck_n,
   
    .c1_p0_cmd_clk      (sys_clk),
    .c1_p0_cmd_en       (),
    .c1_p0_cmd_instr    (),
      input [5:0]	c1_p0_cmd_bl,
      input [29:0]	c1_p0_cmd_byte_addr,
      output		c1_p0_cmd_empty,
      output		c1_p0_cmd_full,
      input		c1_p0_wr_clk,
      input		c1_p0_wr_en,
      input [C1_P0_MASK_SIZE - 1:0]	c1_p0_wr_mask,
      input [C1_P0_DATA_PORT_SIZE - 1:0]	c1_p0_wr_data,
      output		c1_p0_wr_full,
      output		c1_p0_wr_empty,
      output [6:0]	c1_p0_wr_count,
      output		c1_p0_wr_underrun,
      output		c1_p0_wr_error,
      input		c1_p0_rd_clk,
      input		c1_p0_rd_en,
      output [C1_P0_DATA_PORT_SIZE - 1:0]	c1_p0_rd_data,
      output		c1_p0_rd_full,
      output		c1_p0_rd_empty,
      output [6:0]	c1_p0_rd_count,
      output		c1_p0_rd_overflow,
      output		c1_p0_rd_error,
      input		c1_p1_cmd_clk,
      input		c1_p1_cmd_en,
      input [2:0]	c1_p1_cmd_instr,
      input [5:0]	c1_p1_cmd_bl,
      input [29:0]	c1_p1_cmd_byte_addr,
      output		c1_p1_cmd_empty,
      output		c1_p1_cmd_full,
      input		c1_p1_wr_clk,
      input		c1_p1_wr_en,
      input [C1_P1_MASK_SIZE - 1:0]	c1_p1_wr_mask,
      input [C1_P1_DATA_PORT_SIZE - 1:0]	c1_p1_wr_data,
      output		c1_p1_wr_full,
      output		c1_p1_wr_empty,
      output [6:0]	c1_p1_wr_count,
      output		c1_p1_wr_underrun,
      output		c1_p1_wr_error,
      input		c1_p1_rd_clk,
      input		c1_p1_rd_en,
      output [C1_P1_DATA_PORT_SIZE - 1:0]	c1_p1_rd_data,
      output		c1_p1_rd_full,
      output		c1_p1_rd_empty,
      output [6:0]	c1_p1_rd_count,
      output		c1_p1_rd_overflow,
      output		c1_p1_rd_error,

        .c1_p2_cmd_clk          (sys_clk),
        .c1_p2_cmd_en           (),
        .c1_p2_cmd_instr        (),
        .c1_p2_cmd_bl           (),
        .c1_p2_cmd_byte_addr    (),
        .c1_p2_cmd_empty        (),
        .c1_p2_cmd_full         (),
        .c1_p2_rd_clk           (sys_clk),
        .c1_p2_rd_en            (ram_p2_rd_en),
        .c1_p2_rd_data          (ram_p2_rd_data),
        .c1_p2_rd_full          (),
        .c1_p2_rd_empty         (),
        .c1_p2_rd_count         (),
        .c1_p2_rd_overflow      (),
        .c1_p2_rd_error         ()
);


endmodule
