`ifndef TESTCASE
`define TESCASE



//$display("testcase was read");

class reduced_trans extends trans;
    constraint mem_const {
        //send instractions without store in memary
        /*
        opcode != STH;
        opcode != STL;
        opcode != LDL;
        opcode != LDH;
        */       

        /*opcode != ADDI;
        opcode != ADD;
        opcode != NOR;
        opcode != NOP;
        opcode != ROT;
        opcode != SLL;
        opcode != XOR;
        opcode != AND;
        opcode != BNE;
        opcode != OR;
        opcode != NOP;
        */
            
        /*
        opcode != LDL;
        opcode != LDH;
        opcode != STL;
        opcode != STH;
        opcode != JMP;
        opcode != JAL;
        opcode != JR;
        opcode != JALR;
        */
    }
    
endclass    



program full_set (wishbone_if instr_cpu_intf, wishbone_if data_cpu_intf, control_if cont_cpu_intf);

    environment env;
    trans instr;
    
    initial begin
        instr = new();
        env = new(instr_cpu_intf,data_cpu_intf,cont_cpu_intf);
        env.build;
    
    end    
    
endprogram

program cpu_no_ld_st_test (
    wishbone_if instr_cpu_intf, 
    wishbone_if data_cpu_intf, 
    control_if  cont_cpu_intf,
    inner_if    inner_intf
);
    
    bit[15:0]instr[$];
    environment env;
    reduced_trans r_trans;
    int mcd;
    bit[15:0] captured_data;
    
    localparam FULL_LOG = 2'b11;
    localparam NON_LOG = 2'b00;
    localparam EX_LOG = 2'b10;
    localparam MAIN_LOG = 2'b01;
    
    localparam QUEUE_MODE = 2'b00;
    localparam RAND_MODE = 2'b01;
    localparam INIT_REGS = 2'b10;
    localparam FULL_SET = 2'b11;
   
    task run_test();
        $display("TESTCASE : START is on %0t",$time);
        r_trans = new();            
        env = new(instr_cpu_intf,data_cpu_intf,cont_cpu_intf,inner_intf);
        env.build;
        //log contrl
        env.instr_drv.log_flag = FULL_LOG;
        env.instr_mon.log_flag = FULL_LOG;
       // env.data_mon.log_flag =  NON_LOG;
        //env.data_drv.log_flag =  NON_LOG;
        //test_control
        env.instr_drv.run_control = RAND_MODE;
        
        env.instr_drv.cycles = 50;
       
        $cast(env.instr_drv.instr, r_trans);
        //mcd = $fopen("instr.bin","rb");
        env.run;
        $display("TESTCASE : DONE  %0t", $time);
        
   endtask
    
        
endprogram





`endif
