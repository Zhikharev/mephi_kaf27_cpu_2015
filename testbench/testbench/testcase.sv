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



program cpu_no_ld_st_test (wishbone_if instr_cpu_intf, wishbone_if data_cpu_intf, control_if cont_cpu_intf);
    
    bit[15:0]instr[$];
    environment env;
    reduced_trans r_trans;
   
   initial begin
        $display("TESTCASE : START is on %0t",$time);
        r_trans = new();            
        env = new(instr_cpu_intf,data_cpu_intf,cont_cpu_intf);
        env.build;
        $cast(env.instr_drv.instr, r_trans);
        env.run;
        $display("test for queue");
        //instr_driver.file_instr[0] = 2'd10;             
   
        $display("TESTCASE : DONE  %0t", $time);
        //$finish;
   end
        /*
        $fopen("instr.bin");
        if(!file_avib)begin
            $display("TESCASE : ERROR can not find file instr.bin");
        end
        else begin
            $readmemb("instr.bin",instr);
        end    
        */
endprogram






`endif
