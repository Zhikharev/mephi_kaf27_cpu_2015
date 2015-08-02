`ifndef CPU_INTERFACE
`define CPU_INTERFACE 


interface wishbone_if (input clk,input rst);
        logic   [15:0]  adr_out;//use
        logic   [15:0]  adr_in;
        logic   [15:0]  data_in;//use
        logic   [15:0]  data_out;//use
        logic           we_out;  //low read high write 
        logic   [15:0]  instr_in;//use
        logic           akn_in ;//use
        logic           akn_out;
        logic   [3:0]   sel_out;
        logic           stb_in;
        logic           stb_out;//use
        logic           cyc_out;
        
        
        clocking drv@(posedge clk);
                output akn_in;
                input instr_in;//this mast be input or nothig work
                output data_in;
                input stb_out;
                input adr_out;
                input data_out;
                input we_out;        
                output rst;
                input clk;//it must be declared or nothing work
        endclocking  
        clocking mon@(posedge clk);
                input adr_in;
                input data_in;
                input akn_in;
                input we_out;
                input stb_out;
                input adr_out;
                input data_out;
                input akn_out;
                input rst;
        endclocking  
            
        
endinterface

interface control_if (input clk);
        logic reset;        
endinterface 

interface inner_if (input clk, input rst);
    logic [31:0] a_reg;
    logic [31:0] b_reg;
    logic [31:0] c_reg;
    logic [31:0] d_reg;
    logic [31:0] e_reg;
    logic [31:0] f_reg;
    logic [31:0] g_reg;
    logic [31:0] h_reg;
    logic [31:0] w_reg;
    logic [31:0] k_reg;
    logic [31:0] mr_reg;
    logic [31:0] lr_reg;
    logic [31:0] zero_reg;
    logic [31:0] t0_reg;
    logic [31:0] t1_reg;
    logic [31:0] t2_reg  
    logic [31:0] pc;
endinterface
`endif
