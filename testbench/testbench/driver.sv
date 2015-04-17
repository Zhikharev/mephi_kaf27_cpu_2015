`ifndef DRIVER
`define DRIVER

class driver;
   virtual wishbone dr_int;
   virtual control dr_cont;
   mailbox #(trans) mb_dr2sb;
   trans inst;

   function new (virtual wishbone dr_int_new, mailbox #(trans) mb_dr_new);
      this dr_int = dr_int_new;
      inst = new();
              
      if (mb_dr2sb == null) begin
             $display("Driver -- --  ERROR mailbox is emply ");
             $finish;
      end 
      else  this mb_dr = mb_dr_new;
                 
   endfunction
   
   task start ();
      trans sec_inst;
      $display("-------------------Driver is starting to send instractions -------------- ");
      repeat(1000) begin
         @(posedge dr_cont.clk) begin
            sec_inst.randomize;
            ////how to adres to create inst
            mb_dr2sb.put(sec_inst);
            $cast(sec_inst inst);
            send_transaction;
         end
      end
      
   endtask   
   
   task send_transaction();
      dr_int.data_in =sec_inst;
      dr_int.stb_in = 1'b1;
   
   
   endtask
   








endclass



















`endif
