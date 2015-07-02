`ifndef CPU_INTERFACE
`define CPU_INTERFACE 

///////////////////
/////wishbone interface /
//////////


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
    logic [31:0] register[0:15];
    logic [31:0] pc;
    logic [15:0] mon2mon;
    logic [15:0] data_mon2data_drv; // spare interface
endinterface
`endif
