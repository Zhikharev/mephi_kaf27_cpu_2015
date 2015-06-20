`ifndef DRIVER
`define DRIVER


class instr_driver;
    virtual wishbone_if vif;
    trans instr;
    
    mailbox #(trans) mb_idr2sb;
    mailbox #(trans) mb_dr2dr;
    bit[15:0]file_instr[$];
    int cycles ;
    bit[1:0] log_flag ;
    bit[1:0] run_control;   
    
    localparam FULL_LOG = 2'b11;
    localparam NON_LOG = 2'b00;
    localparam EX_LOG = 2'b10;
    localparam MAIN_LOG = 2'b01;
    
    localparam QUEUE_MODE = 2'b00;
    localparam RAND_MODE = 2'b01;
    localparam INIT_REGS = 2'b10;
    localparam FULL_SET = 2'b11;
      
    function new (virtual wishbone_if vif, mailbox #(trans) mb_idr2sb, mailbox #(trans) md_dr2dr);
        this.vif = vif;
        if (mb_idr2sb == null) begin
            $display("INST DRIVER : ERROR mailbox is null");
        end
        else begin
            this.mb_idr2sb = mb_idr2sb;
        end
        if(mb_dr2dr == null) begin
            $display("INST DRIVER : ERROR mailbox dr2dr is empty");
        end
        else begin
            this.mb_dr2dr = mb_dr2dr;
        end
        instr = new();
      endfunction 

    task random_instr();
        trans sec_instr;
        int delay;
        int carring_cycle = 0;
        do begin
            @(vif.drv);
            if(!vif.rst) begin
                if(vif.drv.stb_out) begin
                    $cast(sec_instr,instr);
                    sec_instr.randomize();
                    std :: randomize(delay) with {delay >= 0 && delay < 5;};       
                    repeat(delay) @(vif.drv);
                    send_instr(sec_instr);
                    carring_cycle = carring_cycle + 1;
                    if(log_flag  inside{FULL_LOG,EX_LOG,MAIN_LOG}) begin
                        $display("CARRING CYCLE %0d was at %0t ",carring_cycle,$time);
                        $display("----------------------------------");
                        sec_instr.title = "INSTR DRIVER";        
                        sec_instr.print;
                        $display("----------------------------------");
                    end
                    //mb_dr2dr.try_put(sec_instr);
                end
                else begin
                    clear_intf();
                end
            end
            else begin
                reset_intf();
            end
        end
        while(carring_cycle != cycles);
        
    endtask
  
  task init_all_reg ();
    trans third_instr;
    int num_reg = 0;
    third_instr.opcode = ADDI;
    third_instr.imm = 5;
    third_instr.rt = zero;
    third_instr.print;
    do begin
            @(vif.drv);
            if(!vif.rst) begin
                if(vif.drv.stb_out) begin
                    $cast(third_instr,instr);
                    num_reg = num_reg +1;
                    third_instr.rd = reg_t'(num_reg);
                    send_instr(third_instr);
                end    
                else begin
                    clear_intf();
                end
            end
            else begin
                reset_intf();
            end
        end
        while(num_reg != 12);
        
  endtask

  task queue_instr ();
     int carry_cycle =0;
     do begin
        @(!vif.rst);
        if(!vif.rst)begin
                if(vif.drv.stb_out) begin
                    vif.drv.akn_in <=1'b1;
                    vif.drv.data_in <= file_instr.pop_front();
                    carry_cycle = carry_cycle + 1;
                    
                end
                else begin
                    clear_intf();
                end
            end
        else begin
            reset_intf();
        end
     end
     while(file_instr.size !=0);   
  
  endtask  
    


    task send_instr (trans item);
        vif.drv.akn_in <= 1'b1;
        vif.drv.data_in <= item.pack;
        if(log_flag  inside {EX_LOG,FULL_LOG})begin
            item.decode(vif.drv.data_in);        
            item.d_print;
            $display(" INSTR DRIVER : sending instraction ------- %0b on %0t",vif.drv.data_in,$time);  
        end
    endtask

    task reset_intf();
        vif.drv.akn_in <= 0;
        vif.drv.data_in <= 0;
    endtask

    task clear_intf();
        bit[15:0] data;
        std :: randomize(data); 
        vif.drv.akn_in <= 0;
        vif.drv.data_in <= data;
    endtask
 
    task run();
        if(run_control == QUEUE_MODE) begin        
            $display("INSTR DRIVER : mode queue is on ");
            $display("INSTR DRIVER : amount of elements of qeueu is %0d",file_instr.size);
            queue_instr;
         end
         if(run_control == RAND_MODE)begin
            $display("INSTR DRIVER : mode random is om");
            $display ("INSTR DRIVER : ammount of instractions is %0d", cycles);
            random_instr;
         end
        if(run_control == INIT_REGS) begin
            $display("INSTR DRIVER : mode init_al_reg is on");
            init_all_reg;
        end
    endtask
 
 
        
endclass

`endif

