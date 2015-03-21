/*
########################################################
#
# Author: Grigoriy Zhiharev - gregory.zhiharev@gmail.com
#
# Project: Uart verification
# Filename: globals.sv
# Descriptions:
#
##########################################################
*/

// globals for interface.sv //
// clocking block
int A = 1; // input
int B = 1;// output
// signals
parameter DBIT = 8;

// globals for top.sv (clk)
int C = 10;

//
int error = 0;
int num_of_pkts = 10;
int wait_rcv = 219074;
int wait_end = (num_of_pkts)*wait_rcv;

int RESET = 4; // количество тактов, которые длится reset (40 ns)
int between_ticks = 326; // период 1 тика
int SB_TICK = 16; // количество тиков на 1 бит
int wait_first = between_ticks - 1 + 2; // -1, потому что не учитывается длина импульса тика, +2, потому что прибавляется количество тактов, которые длится reset
int wait_clk = between_ticks*SB_TICK;

