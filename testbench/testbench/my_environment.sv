`ifndef ENVIRONMENT
`define ENVIRONMENT

class environment;
    virtual wishbone_if vif_instr_cpu;
    virtual wishbone_if vif_data_cpu;
    virtual control_if vif_reset;
    virtual inner_if vif_inner;
    virtual tb_control_if vif_tb;
    
    instr_driver drv;
    scorebord scb;
    mem_data_drv mem;
    
    function new (virtual wishbone_if vif_instr_cpu, virtual wishbone_if vif_data_cpu, virtual control_if vif_reset, virtual tb_control_if vif_tb, virtual inner_if vif_inner);
        this.vif_instr_cpu = vif_instr_cpu;
        this.vif_data_cpu = vif_data_cpu;
        this.vif_reset = vif_reset;
        this.vif_tb = vif_tb;    
        this.vif_inner = vif_inner;
    endfunction 
    
    function void build ();
        $display(" ENVIRONMENT ----------- build has been started at %0t" , $time);
        drv = new(vif_instr_cpu);
        scb = new(vif_instr_cpu,vif_inner,vif_tb);
        mem = new();//vif_data_cpu,vif_tb
    endfunction
    
    task run ();
        drv.run;
        scb.run;
       // mem.run;
    endtask
    
    task reset ();
        $display("ENVIRONMENT ----------- reset was turned on  at %0t ", $time);    
        vif_reset.reset = 1;
        repeat(6) @(posedge vif_reset.clk);
        vif_reset.reset =0;
        $display("ENVIRONMENT ----------- reset was turned off at %0t ", $time);
    endtask
    
    task wait_for_end ();
        $display(" ENVIRONMENT ----------- wait for end in procese start was at %0t", $time);
        repeat(50) @(posedge vif_reset.clk);
        $display("ENVIRONMENT ------------ all verifications proceduress are done time is %0t ",$time);            
    endtask    
    
    task run_env ();
        reset;
        run;
        wait_for_end;    
    endtask




endclass



`endif
