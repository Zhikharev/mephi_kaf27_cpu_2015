`ifdef ENVIRONMENT
`define ENVIRONMENT

class environment
   virtual wishbone_if  inst_cpu_intf;
   virtual wishbone_if  data_cpu_intf;
   virtual control_if   cont_cpu_intf;
   driver drv_inst;
   //scorebord sb;
   inst_monitor mon_inst;  
   mailbox #(trans) mb_dr2sb;
   mailbox #(trans) mb_mon2sb;      
        
   function new(virtual  wishbone_if inst_cpu_intf, virtual wishbone_if data_cpu_intf, virtual control_if cont_cpu_intf); 
      this.inst_cpu_intf = inst_cpu_intf;
      this.data_cpu_intf = data_cpu_intf;           
      this.cont_cpu_intf = cont_cpu_intf;
   endfunction
        
   function void build(); 
      $display("Enviroment: build is started. %0t",$time);
       mb_dr2sb =new();
       mb_mon2sb = new();
       drv_inst = new(inst_cpu_intf,md_dr2sb);
       mon_inst = new(inst_cpu_intf,md_mon2sb);
       $display("Enviroment: build is complited. %0t",$time);        
   endfunction

   function void reset();
          $display("Enviroment : reset is turned on. %0t",$time);
          cont_cpu_intf.reset <= 1;
          @(cont_cpu_intf.clk);
          repeat(5) @(posedge cont_cpu_intf clk);
          inst_cpu_intf.adr_out <=0;
          inst_cpu_intf.adr_in <= 0;
          inst_cpu_intf.data_in <=0;
          inst_cpu_intf.data_out <=0;
          inst_cpu_intf.we <= 0;
          inst_cpu_intf.act_in <=0;
          insr_cpu.act_out <=0;
          inst_cpu_intf.sel_out <=0:
          inst_cpu_intf.sed_in <=0;
          inst_cpu_intf.cyc_out <=0;

          data_cpu_intf.adr_out <=0;
          data_cpu_intf.adr_in <= 0;
          data_cpu_intf.data_in <=0;
          data_cpu_intf.data_out <=0;
          data_cpu_intf.we <= 0;
          data_cpu_intf.act_in <=0;
          data_cpu_intf.act_out <=0;
          data_cpu_intf.sel_out <=0:
          data_cpu_intf.sed_in <=0;
          data_cpu_intf.cyc_out <=0;

          $display("Enviroment : reset was be commited. %0t",$time);
    endfunction

    task start();
      $display("Enviroment : start is on. %0t", $time);
      fork 
         drv.start;
         mon.start;
         //sb.start;
      join_any
      $display("Enviroment : start is done. %0t", $time);
   endtask

    task wait_for_end() begin
         $display("Enviroment : wait is on. %0t", $time);
         repeat(1000) @(cont_cpu_intf.clk);
         $display("Enviroment : wait is done. %0t", $time);
        
    endtask

    task run();
        reset();
        start();
        wait_for_end
    endtask       

    
endclass
`endif
