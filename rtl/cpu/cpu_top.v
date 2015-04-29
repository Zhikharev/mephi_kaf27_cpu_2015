/*
###########################################################
#
# Author: Khaltahchyan Daniel 
#
# Project: MEPHI CPU
# Filename: TOP.v
# Descriptions:
# 	CPU  
# 	
# 	
###########################################################
*/

module cpu_top(
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
wire  read_ch;
wire [1:0]pc_mux;
wire [1:0]pc_direct_ch;
wire [9:0]pc;
wire [9:0]pc_2;
wire [31:0]result;
wire [31:0]pc_rd;

PC unit(
.clk(sys_clk),
.pc_mux(pc_mux),
.pc_direct_ch(pc_direct_ch),
.instr(instr_data_i),
.pc(pc),
.pc_2(pc_2),
.result_pc(result),
.pc_rd(pc_rd),
.reset(sys_rst)
);
wire[3:0]alu_shift;
wire[3:0]write_addr;
wire[2:0]alu_control;
wire[31:0]alu_datain;
wire[3:0]read_addr;

wire[1:0]rf_datain;

UC unit2(

.clk (sys_clk),
.data_ack_i(data_ack_i),
.instr_ack_i(instr_ack_i),
. instr(instr_data_i),
.zero (zero),                  
.rf_hl (rf_hl),                
.result_hl (result_hl),            
.pc_direct_ch (pc_direct_ch),   
.data_stb_o (data_stb_o), 
.instr_stb_o (instr_stb_o),               
.alu_shift (alu_shift),      
.write_ch (write_ch),	           
.result_ch (result_ch),            
.write_addr (write_addr),      
.pc_mux (pc_mux),           
.mem_we (data_we_o),
.instr_we_o(instr_we_o),                
.alu_control (alu_control),    
.alu_datain (alu_datain),    
.read_addr (read_addr),      
.read_ch (read_ch),              
.rf_we (rf_we),                
.rf_datain (rf_datain)
           
);
wire[31:0]sr1;
wire[31:0]sr2;
//wire[]alu_control;
//wire[]alu_shift;
wire[31:0]rd;
//wire[3:0]alu_shift;
alu unit3(
.clk(sys_clk),
.sr1 (sr1),   ////
.sr2 (sr2),   ////
.os(alu_control),   
. shift(alu_shift), 
.rd(rd),      ////
.zero(zero)     
);
wire[3:0]read_addr1;
wire[3:0]read_addr2;
wire[3:0]write_addr_reg;
wire[31:0]data_in;
wire[31:0]data_out1;
wire[31:0]data_out2;
wire[31:0]r_rd;

RF unit4(
.clk(sys_clk),
.reset(sys_rst),
.rf_hl(rf_hl),
.reg_port1(read_addr1),  // порт для  адреса рег1
.reg_port2(read_addr2),  // порт для  адреса рег2
.write_reg(write_addr_reg),  // порт для адреса записи в рф
.data_in(data_in),      // данные для записи в рф
.we(rf_we),               
.reg_out1(data_out1),    // 
.reg_out2(data_out2),    // 
.reg_out3(r_rd)     //

);
wire [31:0] r_rd_1;
wire [31:0] sign_ext;
wire [31:0] result_o;
assign r_rd_1 = r_rd;

wire [15:0]dat_o_l;
wire [15:0]dat_o_h;

assign pc_rd = r_rd_1 + pc;
assign sr1 = data_out2;
assign sign_ext ={28'b0,instr_data_i[11:8]};
assign sr2 =(alu_datain==0) ? data_out1: sign_ext ;
assign result = (result_ch==0) ? sr1 :rd ;
assign data_in = (rf_datain==2'b00) ? data_data_i : (rf_datain==2'b01)? result : pc_2;  
assign write_addr_reg =(write_ch==0) ? write_addr : instr_data_i[3:0] ;
assign read_addr2 =(read_ch==0) ? read_addr : instr_data_i[7:4] ;
assign read_addr1 = instr_data_i[11:8];
assign data_addr_o = instr_data_i[9:0];
assign instr_addr_o = pc;
assign result_o = result;
assign dat_o_l = result_o[15:0];
assign dat_o_h = result_o[31:16];
assign data_data_o = (result_hl==0) ? dat_o_l : dat_o_h;
endmodule
