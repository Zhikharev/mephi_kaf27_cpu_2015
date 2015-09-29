`ifndef TOPMODULE
`define TOPMODULE

`timescale 1ns/10ps

module testbench ();
        bit clk = 0;
        bit gl_res =0;        
             
        
    initial begin
        forever #10 clk=~clk;
    end
               
    control_if  control_intf(clk);
    wishbone_if output_cpu_intf(clk,control_intf.reset);
    wishbone_if input_cpu_intf(clk,control_intf.reset);
    inner_if    inner_intf(control_intf.reset);
    tb_control_if tb_if(clk);
    
    test full_test(input_cpu_intf,output_cpu_intf,control_intf,tb_if,inner_intf);
       
    assign inner_intf.a_reg     = dut.unit4.registers[0];
    assign inner_intf.b_reg     = dut.unit4.registers[1];
    assign inner_intf.c_reg     = dut.unit4.registers[2];
    assign inner_intf.d_reg     = dut.unit4.registers[3];
    assign inner_intf.e_reg     = dut.unit4.registers[4];
    assign inner_intf.f_reg     = dut.unit4.registers[5];
    assign inner_intf.g_reg     = dut.unit4.registers[6];
    assign inner_intf.h_reg     = dut.unit4.registers[7];
    assign inner_intf.w_reg     = dut.unit4.registers[8];
    assign inner_intf.k_reg     = dut.unit4.registers[9];
    assign inner_intf.mr_reg    = dut.unit4.registers[10];
    assign inner_intf.lr_reg    = dut.unit4.registers[11];
    assign inner_intf.zero_reg  = dut.unit4.registers[12];
    assign inner_intf.t0_reg    = dut.unit4.registers[13];
    assign inner_intf.t1_reg    = dut.unit4.registers[14];
    assign inner_intf.t2_reg    = dut.unit4.registers[15];  
    assign inner_intf.pc = dut.unit.pc_1;

    
    
    
    
    
    cpu_top dut (
        .sys_clk        (clk), 
        .sys_rst        (control_intf.reset),
        .data_data_o    (output_cpu_intf.data_out),
        .data_data_i    (output_cpu_intf.data_in),
        .data_addr_o    (output_cpu_intf.adr_out),
        .data_stb_o     (output_cpu_intf.stb_out),
        .data_we_o      (output_cpu_intf.we_out),
        .data_ack_i     (output_cpu_intf.akn_in),
        .instr_data_i   (input_cpu_intf.data_in),
        .instr_addr_o   (input_cpu_intf.adr_out),
        .instr_stb_o    (input_cpu_intf.stb_out),
        .instr_we_o     (input_cpu_intf.we_out),
        .instr_ack_i    (input_cpu_intf.akn_in)

    );




endmodule


`endif
