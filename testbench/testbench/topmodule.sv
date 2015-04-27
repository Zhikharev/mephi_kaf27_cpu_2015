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
    
    /*
    TODO
    assign inner_intf.pc = dut.pc;
    */
              
    cpu dut(
        .AKN_I(input_cpu_intf.akn_in),
        .INSTR_I(input_cpu_intf.data_in),
        .DAT_I(input_cpu_intf.data_in),
        .STB_O(output_cpu_intf.stb_out),
        .DAT_O(output_cpu_intf.data_out),
        .WE_O(output_cpu_intf.we_out),
        .ADR_O(output_cpu_intf.adr_out),
        .CLK_I(control_intf.clk),
        .RST_I(control_intf.reset)
    ); 

   initial begin
        $display("START TEST");
        model::test_sv_c_communication(5);
        //#100;
        $display("END TEST");
       // $finish();
    end


endmodule


`endif
