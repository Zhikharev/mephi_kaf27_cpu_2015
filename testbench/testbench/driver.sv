`ifndef DRIVER
`define DRIVER

class driver;
   virtual wishbone dr_int;
   virtual control dr_control;
   mailbox #(trans) mb_dr2sb;
   trans inst;
   int cicles;
   int rand_delay;
   int carring_cicle = 0;
   function new (virtual wishbone dr_int, mailbox #(trans) mb_dr);
      this.dr_int = dr_int;
      inst = new();
              
      if (mb_dr2sb == null) begin
             $display("Driver ----------------  ERROR mailbox is emply ");
             $finish;
      end 
      else  this.mb_dr = mb_dr;
                 
   endfunction
   
   task start (); 
      //$display("------------------ Start of driver on  %t-------------",$time);
      trans sec_instr;
      if (dr_control.reset) begin
        @(negedge dr_control.reset);   
        start;  
      end
      else begin
        repeat(cikles) begin
            sec_instr.randomize;
            if(sec_inst.randomize== null) begin
                $display("-----Driver------------------------- ERROR randomisation is felt");
                break;
            end
            else begin
            $cast(sec_inst,inst);
            mb_dr2sb.put(sec_inst);
            send_transaction(sec_inst);
            carring_cycle = carring_cycle + 1;
            $display("--------------carring cycle = %d,  instraction = %s", carring_cycle, sec_inst.deceoded_inst);
            
            
        end
      end
    clear_interface;
   endtask  
   
   task send_transaction(trans);
      std::randomize(rand_delay) with {rand_delay >=0 && rand_delay < 5;};
      dr_int.stb_in = 1'b1;
      for (int i = 1; i < rand_delay; i++) @(posedge dr_control.clk); 
      dr_int.data_in = sec_instr;
      
   endtask
   
    task clear_interface 
        dr_int.data_out =0;
        dr_int.data_in = 0;
        
    endtask

 /*task simle_start()
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
*/




endclass



















`endif
