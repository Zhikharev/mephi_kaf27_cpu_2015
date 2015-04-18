`ifndef DRIVER
`define DRIVER

class driver;
   virtual wishbone dr_int;
   virtual control dr_control;
   mailbox #(trans) mb_dr2sb;
   trans inst;
   int cicles;
   int rand_delay;
   int carry_cicle = 0;
   function new (virtual wishbone dr_int, mailbox #(trans) mb_dr);
      this.dr_int = dr_int;
      inst = new();
              
      if (mb_dr2sb == null) begin
             $display("Driver -- --  ERROR mailbox is emply ");
             $finish;
      end 
      else  this.mb_dr = mb_dr;
                 
   endfunction
   
   task start (); 
      $display("------------------ Start of driver on  %t-------------",$time);
      trans sec_instr;
      while(cicles =!0) begin
        if(dr_control.reset == 1'b0) @(negedge dr_control.reset);
        else begin
            carry_cicle = carry_cicle +1;
            $display("nomer of cicle------------%d",carry_cicle);
            cicles = cicles -1;
            sec_instr.randomize();
            $display("instraction----------------%b",sec_instr);
            mb_dr2sb.put(sec_instr);
            send_transaction;
        end
      end
   
   endtask  
   
   task send_transaction(sec_inst);
      std::randomize(rand_delay) with {rand_delay >=0 && rand_delay < 5;};
      dr_int.stb_in = 1'b1;
      for (int i = 1; i < rand_delay; i++) @(posedge dr_control.clk); 
      dr_int.data_in = sec_instr;
      
   endtask
   
 task simle_start()
    if(dr_control.reset == 1'b0) @(negedge dr_control.reset);
    else begin
        inst.opcode = ADDI;
        inst.imm = 4'b0011;
        inst.rt = zero;
        inst.rd = B;
        send_transaction;
        @(posedge dr_control.clk)
        
         end
    
 
 endtask 





endclass



















`endif
