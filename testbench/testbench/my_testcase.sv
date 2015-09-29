`ifndef MY_TESTCASE
`define MY_TESTCACE

program test ( wishbone_if instr_cpu_intf, wishbone_if data_cpu_intf, control_if reset, tb_control_if tb_if, inner_if cpu_inner);
    environment env;
    
    initial begin
        $display("TEST_CASE --------- start is turn on at %0t",$time);
        env = new(instr_cpu_intf,data_cpu_intf,reset,tb_if,cpu_inner);
        env.build;
        env.drv.cycles =10;
        env.scb.cycles = 10;
        env.run_env;
        $display ("TEST_CASE ----------- start is turn off at %0t", $time);    
    end
endprogram

`endif
