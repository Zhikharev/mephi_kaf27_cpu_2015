`ifndef ENVIRONMENT
`define ENVIRONMENT

class environment;
   virtual wishbone_if  instr_cpu_intf;
   virtual wishbone_if  data_cpu_intf;
   virtual control_if   cont_cpu_intf;
   instr_monitor instr_mon;  
   instr_driver instr_drv;
   data_monitor data_mon;
   data_driver data_drv;
   mailbox #(trans) mb_idr2sb;
   mailbox #(trans) mb_imon2sb;
   mailbox #(trans) mb_dmon2sb;
   mailbox #(bit[15:0]) mb_dr2dr;
   mailbox #(bit[15:0]) mb_mon2mon;
   int i =0;
        
   function new(virtual  wishbone_if instr_cpu_intf, virtual wishbone_if data_cpu_intf, virtual control_if cont_cpu_intf); 
      this.instr_cpu_intf = instr_cpu_intf;
      this.data_cpu_intf = data_cpu_intf;           
      this.cont_cpu_intf = cont_cpu_intf;
   endfunction
        
   function void build(); 
      $display("Enviroment: build is started. %0t",$time);
       mb_idr2sb =  new();
       mb_imon2sb = new();
       mb_dmon2sb = new();
       mb_mon2mon = new();
       mb_dr2dr =   new();
       instr_mon = new(instr_cpu_intf,mb_mon2mon,mb_imon2sb);
       data_mon =  new(data_cpu_intf,mb_mon2mon,mb_dmon2sb);
       data_drv =  new(instr_cpu_intf,data_cpu_intf,mb_dr2dr);
       instr_drv =  new(instr_cpu_intf,mb_idr2sb,mb_dr2dr);
       $display("Enviroment: build is complited. %0t",$time);        
   endfunction

   task reset();
       $display("Enviroment : reset is turned on. %0t",$time);
       cont_cpu_intf.reset <= 1;
       repeat(5) @(posedge cont_cpu_intf.clk);
       cont_cpu_intf.reset <= 0;
       $display("Enviroment : reset was be commited. %0t",$time);
    
    endtask

    task start();
      $display("Enviroment : start is on. %0t", $time);
      fork 
         data_drv.run;
         data_mon.run;
         instr_mon.run;
         instr_drv.run;
      join_any
      $display("Enviroment : start is done. %0t", $time);
   endtask

    task wait_for_end();
         $display("Enviroment : wait is on. %0t", $time);
         repeat(100) @(cont_cpu_intf.clk);
         $display("Enviroment : wait is done. %0t", $time);
    endtask

    task run();
        reset();
        start();
        wait_for_end();
        $display("__________________ ++++++++++ _________ get all registers ");
        model :: allreg(0);
        repeat(16) begin
            $display("test");
            i=i+1;
            model :: GETREG(i);
        end
    endtask       

    
endclass
`endif

