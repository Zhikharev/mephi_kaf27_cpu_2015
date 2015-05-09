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
                 
   
        $display("TESTCASE : DONE  %0t", $time);
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
/*program test_decode();
    bit[15:0] instr;
    int i;
    transaction trans;
    repeat(20) begin
        std :: randomize(instr) with {instr[3:0] !=4'b1101 && instr[3:0] !=4'b1110 && instr[3:0] !=4'b1111};
        trans.decode(instr);
        trans.d_print;
    end   
endprogram*/




`endif
