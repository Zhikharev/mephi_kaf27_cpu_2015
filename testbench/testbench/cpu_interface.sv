`ifndef CPU_INTERFACE
`define CPU_INTERFACE 

///////////////////
/////wishbone interface /
//////////


interface wishbone (input clk);
        logic   [15:0]  adr_out;
        logic   [15:0]  adr_in;
        logic   [15:0]  data_in;
        logic   [15:0]  data_out;
        logic           we;     //low read high write 
        logic           ack_in ;
        logic           ack_out;
        logic   [3:0]   sel_out;
        logic   [3:0]   seb_in;
        logic           cyc_out;
        
        /*
        clocking cb@(posedge clk);
                input adr_in;
                input data_in;
                input ack_in;
                inout we;
                input sel_out;
                output adr_out;
                output data_out;
                output ack_out;
        endclocking  
        */     
        
endinterface

interface control (input clk);
        logic reset;        
endinterface 

`endif
