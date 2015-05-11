`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:00:20 05/06/2015 
// Design Name: 
// Module Name:    memory_logic_cpu
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
module memory_logic_cpu(

	input sys_clk,
	input sys_rst,

	// CPU instruction interface
	input    		cpu_inst_stb_i,
	output 	 		cpu_inst_ack_o, 
	input	  [10:0] 	 cpu_inst_addr_i,
	output  [15:0]		 cpu_inst_data_o,

	// CPU data memory interface
	input    		cpu_data_stb_i,
	input  			cpu_data_we_i,
	output 	 		cpu_data_ack_o, 
	input	  [15:0] cpu_data_addr_i,
	input   [15:0] 	 cpu_data_data_i,
	output  [15:0]     cpu_data_data_o,

	// IO inteface
	output			io_stb_o,
	input          io_stb_i,
	output         io_ack_o,
	input 	 		io_ack_i,
	output         io_we_o,
	input          io_we_i,
	input   [15:0] 	io_addr_i,
	output  [15:0]  	io_addr_o,
	input   [15:0] 	io_data_i,
	output  [15:0] 	io_data_o
    );
 
u_mc (

    .c1_sys_clk_p           (c1_sys_clk_p),
  .c1_sys_clk_n           (c1_sys_clk_n),
  .c1_sys_rst_i           (c1_sys_rst_i),                        

  .mcb1_dram_dq           (mcb1_dram_dq),  
  .mcb1_dram_a            (mcb1_dram_a),  
  .mcb1_dram_ba           (mcb1_dram_ba),
  .mcb1_dram_ras_n        (mcb1_dram_ras_n),                        
  .mcb1_dram_cas_n        (mcb1_dram_cas_n),                        
  .mcb1_dram_we_n         (mcb1_dram_we_n),                          
  .mcb1_dram_odt          (mcb1_dram_odt),
  .mcb1_dram_cke          (mcb1_dram_cke),                          
  .mcb1_dram_ck           (mcb1_dram_ck),                          
  .mcb1_dram_ck_n         (mcb1_dram_ck_n),       
  .mcb1_dram_dqs          (mcb1_dram_dqs),                          
  .mcb1_dram_dqs_n        (mcb1_dram_dqs_n),
  .mcb1_dram_udqs         (mcb1_dram_udqs),    // for X16 parts                        
  .mcb1_dram_udqs_n       (mcb1_dram_udqs_n),  // for X16 parts
  .mcb1_dram_udm          (mcb1_dram_udm),     // for X16 parts
  .mcb1_dram_dm           (mcb1_dram_dm),
    .c1_clk0		        (c1_clk0),
  .c1_rst0		        (c1_rst0),
	
 
  .c1_calib_done          (c1_calib_done),
     .mcb1_rzq               (rzq1),
               
     .mcb1_zio               (zio1),
               
     .c1_p0_cmd_clk                          (c1_p0_cmd_clk),
   .c1_p0_cmd_en                           (c1_p0_cmd_en),
   .c1_p0_cmd_instr                        (c1_p0_cmd_instr),
   .c1_p0_cmd_bl                           (c1_p0_cmd_bl),
   .c1_p0_cmd_byte_addr                    (c1_p0_cmd_byte_addr),
   .c1_p0_cmd_empty                        (c1_p0_cmd_empty),
   .c1_p0_cmd_full                         (c1_p0_cmd_full),
   .c1_p0_wr_clk                           (c1_p0_wr_clk),
   .c1_p0_wr_en                            (c1_p0_wr_en),
   .c1_p0_wr_mask                          (c1_p0_wr_mask),
   .c1_p0_wr_data                          (c1_p0_wr_data),
   .c1_p0_wr_full                          (c1_p0_wr_full),
   .c1_p0_wr_empty                         (c1_p0_wr_empty),
   .c1_p0_wr_count                         (c1_p0_wr_count),
   .c1_p0_wr_underrun                      (c1_p0_wr_underrun),
   .c1_p0_wr_error                         (c1_p0_wr_error),
   .c1_p0_rd_clk                           (c1_p0_rd_clk),
   .c1_p0_rd_en                            (c1_p0_rd_en),
   .c1_p0_rd_data                          (c1_p0_rd_data),
   .c1_p0_rd_full                          (c1_p0_rd_full),
   .c1_p0_rd_empty                         (c1_p0_rd_empty),
   .c1_p0_rd_count                         (c1_p0_rd_count),
   .c1_p0_rd_overflow                      (c1_p0_rd_overflow),
   .c1_p0_rd_error                         (c1_p0_rd_error),
   .c1_p1_cmd_clk                          (c1_p1_cmd_clk),
   .c1_p1_cmd_en                           (c1_p1_cmd_en),
   .c1_p1_cmd_instr                        (c1_p1_cmd_instr),
   .c1_p1_cmd_bl                           (c1_p1_cmd_bl),
   .c1_p1_cmd_byte_addr                    (c1_p1_cmd_byte_addr),
   .c1_p1_cmd_empty                        (c1_p1_cmd_empty),
   .c1_p1_cmd_full                         (c1_p1_cmd_full),
   .c1_p1_wr_clk                           (c1_p1_wr_clk),
   .c1_p1_wr_en                            (c1_p1_wr_en),
   .c1_p1_wr_mask                          (c1_p1_wr_mask),
   .c1_p1_wr_data                          (c1_p1_wr_data),
   .c1_p1_wr_full                          (c1_p1_wr_full),
   .c1_p1_wr_empty                         (c1_p1_wr_empty),
   .c1_p1_wr_count                         (c1_p1_wr_count),
   .c1_p1_wr_underrun                      (c1_p1_wr_underrun),
   .c1_p1_wr_error                         (c1_p1_wr_error),
   .c1_p1_rd_clk                           (c1_p1_rd_clk),
   .c1_p1_rd_en                            (c1_p1_rd_en),
   .c1_p1_rd_data                          (c1_p1_rd_data),
   .c1_p1_rd_full                          (c1_p1_rd_full),
   .c1_p1_rd_empty                         (c1_p1_rd_empty),
   .c1_p1_rd_count                         (c1_p1_rd_count),
   .c1_p1_rd_overflow                      (c1_p1_rd_overflow),
   .c1_p1_rd_error                         (c1_p1_rd_error),
   .c1_p2_cmd_clk                          (c1_p2_cmd_clk),
   .c1_p2_cmd_en                           (c1_p2_cmd_en),
   .c1_p2_cmd_instr                        (c1_p2_cmd_instr),
   .c1_p2_cmd_bl                           (c1_p2_cmd_bl),
   .c1_p2_cmd_byte_addr                    (c1_p2_cmd_byte_addr),
   .c1_p2_cmd_empty                        (c1_p2_cmd_empty),
   .c1_p2_cmd_full                         (c1_p2_cmd_full),
   .c1_p2_rd_clk                           (c1_p2_rd_clk),
   .c1_p2_rd_en                            (c1_p2_rd_en),
   .c1_p2_rd_data                          (c1_p2_rd_data),
   .c1_p2_rd_full                          (c1_p2_rd_full),
   .c1_p2_rd_empty                         (c1_p2_rd_empty),
   .c1_p2_rd_count                         (c1_p2_rd_count),
   .c1_p2_rd_overflow                      (c1_p2_rd_overflow),
   .c1_p2_rd_error                         (c1_p2_rd_error)
);	
	
rom rom (

	 .sys_clk (sys_clk),
    .sys_rst (sys_rst),
	 .addr_i  (rom_addr_o),
	 .data_o  (rom_data_i)
    );

	reg 	 		r_cpu_inst_ack_o;
	reg  [15:0]		 r_cpu_inst_data_o;
	reg 	 		r_cpu_data_ack_o; 
	reg  [15:0]     r_cpu_data_data_o;
	reg			r_io_stb_o;
	reg         r_io_ack_o;
	reg         r_io_we_o;
	reg  [15:0]  	r_io_addr_o;
	reg  [15:0] 	r_io_data_o;
	
	always @(posedge sys_clk) begin
//CPU instructions interface
	if (cpu_inst_stb_i) begin
		r_cpu_data_ack_o <= 1'b0;
		r_io_ack_o <= 1'b0;		
	// Reading from RAM
		if (cpu_inst_addr_i[10]) begin
			if (c1_p2_rd_en == 1'b0) begin			
				c1_p2_cmd_en <= 1'b1;
				c1_p2_cmd_instr <= 3'b001;
				c1_p2_cmd_bl <= 6'd1;
				c1_p2_cmd_byte_addr[29:11] <= 19'd0;
				c1_p2_cmd_byte_addr[10:0] <= cpu_inst_addr_i;
				r_cpu_inst_ack_o <= 1'b0;
				if (c1_p2_cmd_empty == 1'b0)
					c1_p2_rd_en <= 1'b1;
				else
					c1_p2_rd_en <= 1'b0;							
			end
			else begin
				r_cpu_inst_data_o <= c1_p2_rd_data[15:0];
				c1_p2_rd_en <= 1'b0;
				c1_p2_cmd_en <= 1'b0;
				r_cpu_inst_ack_o <= 1'b1;
			end
		end
		else begin		
		// Reading from IO
			if (cpu_inst_addr_i[9]) begin
				if (io_ack_i == 1'b0) begin
					r_io_stb_o <= 1'b1;
					r_io_we_o <= 1'b0;
					r_io_addr_o[15:11] <= 5'd0;
					r_io_addr_o[10:0] <= cpu_inst_addr_i;
					r_cpu_inst_ack_o <= 1'b0;
				end
				else begin
//					r_io_ack_o <= 1'b1;
					r_cpu_inst_data_o <= io_data_i;
					r_cpu_inst_ack_o <= 1'b1;
				end				
			end			
		// Reading from ROM
			else begin
				rom_addr_o[15:11] <= 5'd0;
				rom_addr_o[10:0] <= cpu_inst_addr_i;				
				r_cpu_inst_data_o <= rom_inst_data_i;
				if (rom_addr_o == cpu_inst_addr_i)
					r_cpu_inst_ack_o <= 1'b1;
				else
					r_cpu_inst_ack_o <= 1'b0;
			end
		end		
	end;
	
//CPU data interface
	if (cpu_data_stb_i) begin
		r_cpu_inst_ack_o <= 1'b0;
		r_io_ack_o <= 1'b0;	
	// Reading from RAM
		if (cpu_data_addr_i[10]) begin
			if (cpu_data_we_i == 1'b0) begin			
				if (c1_p1_rd_en == 1'b0) begin			
					c1_p1_cmd_en <= 1'b1;
					c1_p1_cmd_instr <= 3'b001;
					c1_p1_cmd_bl <= 6'd1;
					c1_p1_cmd_byte_addr[29:16] <= 14'd0;
					c1_p1_cmd_byte_addr[15:0] <= cpu_data_addr_i;
					r_cpu_data_ack_o <= 1'b0;
					if (c1_p1_cmd_empty == 1'b0)
						c1_p1_rd_en <= 1'b1;
					else
						c1_p1_rd_en <= 1'b0;				
				end
				else begin
					r_cpu_data_data_o <= c1_p1_rd_data[15:0];
					c1_p1_rd_en <= 1'b0;
					c1_p1_cmd_en <= 1'b0;
					r_cpu_data_ack_o <= 1'b1;
				end
			end
		// Writing in RAM			
			else begin
				if (c1_p1_wr_en == 1'b0) begin			
					c1_p1_cmd_en <= 1'b1;
					c1_p1_cmd_instr <= 3'b000;
					c1_p1_cmd_bl <= 6'd1;
					c1_p1_cmd_byte_addr[29:16] <= 14'd0;
					c1_p1_cmd_byte_addr[15:0] <= cpu_data_addr_i;
					r_cpu_data_ack_o <= 1'b0;
					if (c1_p1_cmd_empty == 1'b0)
						c1_p1_wr_en <= 1'b1;
					else
						c1_p1_wr_en <= 1'b0;	
				end					
				else begin
					c1_p1_wr_data[31:16] <= 14'd0;
					c1_p1_wr_data[15:0] <= cpu_data_data_i;
					c1_p1_rd_en <= 1'b0;
					c1_p1_cmd_en <= 1'b0;
					r_cpu_data_ack_o <= 1'b1;
				end
			end
		end
		else begin
			if (cpu_data_addr_i[9]) begin
/*	
		// Reading from IO
				if (cpu_data_we_i == 1'b0) begin
					r_io_stb_o = 1'b1;
					r_io_we_o = 1'b0;
					r_io_addr_o[15:11] = 5'd0;
					r_io_addr_o[10:0] = cpu_data_addr_i;
					if (io_ack_i) begin
//					r_io_ack_o = 1'b1;
						r_cpu_data_data_o = io_data_i
						r_cpu_data_ack_o = 1'b1
					end
					else r_cpu_data_ack_o = 1'b0;		
*/
			end
		end
	end
	end;
	
	assign cpu_inst_ack_o = r_cpu_inst_ack_o;
	assign cpu_inst_data_o = r_cpu_inst_data_o;
	assign cpu_data_ack_o = r_cpu_data_ack_o;
	assign cpu_data_data_o = r_cpu_data_data_o;
	assign io_stb_o = r_io_stb_o;
	assign io_ack_o = r_io_ack_o;
	assign io_we_o = r_io_we_o;
	assign io_addr_o = r_io_addr_o;
	assign io_data_o = r_io_data_o;
	
endmodule
