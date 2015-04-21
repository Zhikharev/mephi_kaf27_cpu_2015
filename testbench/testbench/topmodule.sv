`ifndef TOPMODULE
`define TOPMODULE

`timescale 1ns/10ps
module testbench ();
        bit clk = 0;
        
        
    //generetor clk   
    initial begin
        forever #10 clk=~clk;
    end
               
    wishbone instraction(clk);
    wishbone data(clk);
    control control(clk);
    inner_if inner_intf(clk, control.reset);

    /*
    TODO
    assign inner_intf.pc = dut.pc;
    */
              
    cpu dut(
        .CLK_I(control.clk),
        .RST_I(control.reset),
        .ADR_I(data.adr_in),
        .ADR_O(data.adr_out),
        .DAT_I(data.data_in),
        .DAT_O(data.data_out)         
    ); 

    initial begin
        $display("START TEST");
        model::test_sv_c_communication(5);
        #100;
        $finish();
    end

endmodule


`endif
