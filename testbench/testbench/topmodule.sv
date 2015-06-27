`ifndef TOPMODULE
`define TOPMODULE

`timescale 1ns/10ps
module testbench ();
        bit clk = 0;
        bit gl_res =0;        
        
        
    //generetor clk   
    initial begin
        forever #10 clk=~clk;
    end
               
    control_if  control_intf(clk);
    wishbone_if output_cpu_intf(clk,control_intf.reset);
    wishbone_if input_cpu_intf(clk,control_intf.reset);
    inner_if    inner_intf(clk, control_intf.reset);
    
    cpu_no_ld_st_test cpu_no_ldst(input_cpu_intf,output_cpu_intf,control_intf);
    
    assign inner_intf.pc = dut.unit.pc_1;
    assign inner_intf.register[0] = cpu_top.rf.reg[0000]
       
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


   initial begin
        model::test_sv_c_communication(5);
        
    end


endmodule


`endif
