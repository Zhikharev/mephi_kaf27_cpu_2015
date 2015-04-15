`ifndef DRIVER
`define DRIVER

class driver;
   virtual wishbone dr_int;
   virtual control dr_cont;
   mailbox #(trans) mb_dr;
   trans inst;

   function new (virtual wishbone dr_int , mailbox #(trans) mb_dr)
      this dr_int = dr_int;
      inst = new();
              
      if (mb_dr == null) begin
         $display("Driver -- --  ERROR mailbox is emply ");
         $finish;
         end 
         else  this mb_dr = mb_dr;
                 
   endfunction
   
   task start 
      trans sq_inst;
      repeat(1000) begin
         @(posedge dr_cont.clk) begin
            sq_inst.randomize;
            md_dr.put(sq_inst);
            send_transaction;
         end
      end
      
   endtask   
   
   task send_transaction
      dr_int.// out or in 
   
   
   endtask
   








endclass



















`endif
