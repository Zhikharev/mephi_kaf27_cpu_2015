`ifndef DRIVER
`define DRIVER


class inst_driver;
    virtual wishbone_if vif;
    trans instr;
    mailbox #(trans) mb_dr2sb;
    int cycles;
    
    function new (virtual wishbone_if vif, mailbox #(trans) mb_dr2sb);
        this.vif = vif;
        if (mb_dr2sb == null) begin
            $display("DRIVER : ERROR mailbox is null");
        end
        else begin
            this.mb_dr2sb = mb_dr2sb;
        end
    endfunction 

    task strart();
        trans sec_instr;
        int delay;
        int carring_cycle = 0;
        do begin
            @(vif.drv.clk);
            if(!vif.rst) begin
                if(vif.drv.stb_out) begin
                    $cast(sec_instr,instr);
                    sec_instr.randomize();
                    std :: randomize(delay) with {delay >= 0 && delay < 5;};       
                    repeat(delay) @(vif.drv);
                    send_instr(sec_instr);
                    carring_cycle = carring_cycle + 1;
                    $display("CARRING CYCLE %0d",carring_cycle);
                    sec_instr.print;
                end
                else begin
                    clear_intf();
                end
            end
            else begin
                reset_intf();
            end
        end
        while(carring_cycle != cycles)
        
/*        
        do begin
            @(vif.drv.clk);
            if(vif.drv.rst) begin
                @(vif.drv.clk);
            end
            else begin
                if(vif.drv.stb_out) begin
                    @(vif.drv.clk);
                end
                else begin
                    sec_instr.randomize;
                    $cast(sec_instr,instr);
                    std :: randomize(delay) with {delay >= 0 && delay <5;};       
                    repeat(delay) @(vif.drv.clk);
                    carring_cycle = carring_cycle +1;
                    $display("CARRING CYCLE %0d",carring_cycle);
                    sec_instr.print;
                    send_instr(sec_instr);
                        
                end
            end
        end
        while(carring_cycle == cycles);
*/
    endtask
    
    
    task send_instr (trans item);
        vif.drv.ack_in <= 1'b1;
        vif.drv.instr_in <= item.pack;  
        // TODO Set all other signals
    endtask

    task reset_intf();
        // TODO
    end

    task clear_intf();
        // TODO
    end
 

endclass

`endif




/*task start (); 
      //$display("------------------ Start of driver on  %t-------------",$time);
      trans sec_instr;
      if (dr_control.reset) begin
  //      @(negedge dr_control.reset);   
    //    start;  
      end
      else begin
        repeat(cycles) begin
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
      end
    clear_interface;
   endtask  
 */  



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


22222222    task start();
        trans sec_instr;
        if(dr_control.reset) begin
            @(negedge dr_control.reset);
        end
        else begin
             repeat(cycles) begin
                sec_instr.randomize;
                $cast(sec_instr,instr);
                mb_dr2sb.put(sec_instr);
                send_transaction;
                carring_cycle = carring_cycle + 1;
                $display("--------------carring cycle = %d,  instraction = %s", carring_cycle, sec_instr.decoded_inst);
            end            
        end
    endtask 
//////////////////////////////////////////////////////////////////////
class driver;
   virtual wishbone_if dr_vif;
     mailbox #(trans) mb_dr2sb;
   trans instr;
   int cycles;
   int rand_delay;
   int carring_cycle = 0;

   function new (virtual wishbone dr_int,dr_control, mailbox #(trans) mb_dr2sb);
      this.dr_int = dr_int;
      this.dr_control = dr_control;
      instr = new();
              
      if (mb_dr2sb == null) begin
             $display("Driver ----------------  ERROR mailbox is emply ");
             $finish;
      end 
      else  this.mb_dr2sb = mb_dr2sb;
                 
   endfunction
//
    task start ();
        trans sec_instr;
        do
            if(!drv_vif.drv.reset) @(dr_vif.drv.reset)
            else begin
                sec_instr.randomise;
                $cast(sec_instr,instr);
                    
            end
        begin
        
    endtask

//   
   task send_transaction(trans //local name); 
      std::randomize(rand_delay) with {rand_delay >=0 && rand_delay < 5;};z 
      dr_int.stb_in = 1'b1;
      for (int i = 1; i < rand_delay; i++) begin 
        @(drv_vif.drv.clk); 
         dr_int.data_in = sec_instr.create_trans;
      end
   endtask
//   
    task clear_interface;
        dr_int.data_out =0;
        dr_int.data_in = 0;
        
    endtask


endclass




*/




