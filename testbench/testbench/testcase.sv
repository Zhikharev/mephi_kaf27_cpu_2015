`ifndef TESTCASE
`define TESCASE
//$display("testcase was read");

class r_trans extends trans;
    constraint mem_const {
        //send instractions without store in memary
        opcode != STH;
        opcode != STL;
    
    }
    
endclass



program testcase (wishbone_if instr_cpu_int, wishbone_if data_cpu_int);
   
    //environment env;
    r_trans sm_trans;
    
    //env = new(instr_cpu_intf , data_cpu_intf);
    //env.run;
    
endprogram








`endif
