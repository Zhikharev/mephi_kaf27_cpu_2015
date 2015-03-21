/*
########################################################
#
# Author: Grigoriy Zhiharev - gregory.zhiharev@gmail.com
#
# Project: Uart verification
# Filename: interface.sv
# Descriptions:
#
##########################################################
*/

// отдельный блок под clk и reset
interface clk_reset(input bit clk);
    logic reset;
    logic startbut;
endinterface

// input_interface with w_data //
interface input_interface_d(input bit clk);
    logic [DBIT-1:0] w_data;
    logic wr_uart;
    logic tx_full;
    
    clocking cb@(posedge clk);
        default input #A output #B;
        output w_data;
        output wr_uart;
        input tx_full;
    endclocking

    modport IPD(clocking cb,input clk);

endinterface

// input_interface with rx //
interface input_interface_rx(input bit clk);
    logic rx;
 
    clocking cb@(posedge clk);
        default input #A output #B;
        output rx;
    endclocking

    modport IPR(clocking cb,input clk);

endinterface

// output_interface with r_data //
interface output_interface_d(input clk);
    logic [DBIT-1:0] r_data;
    logic rx_empty;
    logic rd_uart;
 
    clocking cb@(posedge clk);
        default input #A output #B;
        input r_data;
        input rx_empty;
        output rd_uart;
    endclocking

    modport OPD(clocking cb, input clk);

endinterface

// output_interface with tx //
interface output_interface_tx(input clk);
    logic tx;
 
    clocking cb@(posedge clk);
        default input #A output #B;
        input tx;
    endclocking

    modport OPT(clocking cb, input clk);

endinterface





