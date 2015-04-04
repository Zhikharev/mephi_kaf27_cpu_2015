`ifndef TOPMODULE
`define TOPMODULE

`timescale 1ns/10ps
module testbench ();
        bit clk = 0;////////////////mine clock
        
        
//////////////
////generetor clk
/////////////////        
        
        forever #10 clk=~clk;
///////////        
/////incilisation interfaces
//////                
        wishbone instraction(clk);
        wishbone data(clk);
        control control(clk);
//////////// 
///////// interconnections for dut
//////////////                
        cpu_dut dut(
                .CLK_I(control.clock),
                .RES_I(control.reset),
                .ADR_I(data.adr_in),
                .ADR_O(data.adr_out),
                .DAT_I(data.data_in),
                .DAT_O(data.data_out)
                      
               ); 



endmodule


`endif
