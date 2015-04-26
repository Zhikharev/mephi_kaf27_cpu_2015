`ifndef TESTCASE
`define TESCASE
//$display("testcase was read");

class reduced_trans extends trans;
    constraint mem_const {
        //send instractions without store in memary
        opcode != STH;
        opcode != STL;
        opcode != LDL;
        opcode != LDH;
    }
    
endclass    



program cpu_no_ld_st_test (wishbone_if instr_cpu_int, wishbone_if data_cpu_int, control_if cont_cpu_int);
    
    environment env;
    reduced_trans r_trans;
   
   initial begin
        $display("TESTCASE : START is on %0t",$time);
        r_trans = new();            
        env = new(instr_cpu_int,data_cpu_int,cont_cpu_int);
        env.build;
        env.run;              
   
        $display("TESTCASE : DONE  %0t", $time);
        $finish;
   end
   
    
    
endprogram








`endif
