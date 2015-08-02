`ifndef TOP
`define TOP

`timescale 1ns/10ps

module top ();
        bit clk = 0;     
        string testname;
        
    //generetor clk   
    initial begin
        forever #10 clk=~clk;
    end
               
    control_if  control_intf(clk);
    wishbone_if output_cpu_intf(clk,control_intf.reset);
    wishbone_if input_cpu_intf(clk,control_intf.reset);
    inner_if    inner_intf(clk, control_intf.reset);
    
    cpu_no_ld_st_test cpu_no_ldst(input_cpu_intf,output_cpu_intf,control_intf, inner_intf);

    if($value$plusargs("TESTNAME=%s", testname)) begin
        case(testname)
            "cpu_no_ld_st_test": cpu_no_ldst.run_test();
        default: $fatal("No test=%0s existed", testname)
        endcase
    end

    assign inner_intf.a_reg     = dut.u_rf.rf[0];
    assign inner_intf.b_reg     = dut.u_rf.rf[1];
    assign inner_intf.c_reg     = dut.u_rf.rf[2];
    assign inner_intf.d_reg     = dut.u_rf.rf[3];
    assign inner_intf.e_reg     = dut.u_rf.rf[4];
    assign inner_intf.f_reg     = dut.u_rf.rf[5];
    assign inner_intf.d_reg     = dut.u_rf.rf[6];
    assign inner_intf.h_reg     = dut.u_rf.rf[7];
    assign inner_intf.w_reg     = dut.u_rf.rf[8];
    assign inner_intf.k_reg     = dut.u_rf.rf[9];
    assign inner_intf.mr_reg    = dut.u_rf.rf[10];
    assign inner_intf.lr_reg    = dut.u_rf.rf[11];
    assign inner_intf.zero_reg  = dut.u_rf.rf[12];
    assign inner_intf.t0_reg    = dut.u_rf.rf[13];
    assign inner_intf.t1_reg    = dut.u_rf.rf[14];
    assign inner_intf.t2_reg    = dut.u_rf.rf[15];  
    assign inner_intf.pc = dut.unit.pc_1;
    
       
    CPU_TOP dut(
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
