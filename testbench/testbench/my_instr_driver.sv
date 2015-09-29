`ifndef DRIVER
`define DRIVER


class instr_driver;
    virtual wishbone_if vif;
    trans instr;
    
    bit[15:0]file_instr[$];
    int cycles ;
    bit[1:0] log_flag ;
    bit[1:0] run_control;   
    
    
      
    function new (virtual wishbone_if vif);
        this.vif = vif;
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
                    //assert(sec_instr.randomize() == 1) else $display("INSTR_DRIVER ERROR --------- randomize failed at rand_mode");
                    std :: randomize(delay) with {delay >= 0 && delay < 5;};       
                    repeat(delay) @(vif.drv);
                    send_instr(sec_instr);
                    carring_cycle = carring_cycle + 1;
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
  
    task full_set ();
      /*  int i;
        trans third_instr;
        @(vif.drv)
        if(!vif.rst) begin
            if(vif.drv.stb_out) begin
                $cast(third_instr,instr);
                third_instr.opcode.rand_mode(0);
                for(i=0;i < 19;i=i+1) begin : forloop
                   // third_instr.opcode = ADD;//third_instr.opcopde_t'(i);
                    third_instr.randomize();
                    assert(third_instr.randomize == 1) else $display("INSRT_DRIVER ERROR ------------ randomize failed at full_set");
                    send_instr(third_instr);
                end
            end
            else begin 
                clear_intf();
            end
        end
        else begin
            reset_intf();
        end*/
    endtask

    
    task send_instr (trans item);
        vif.drv.akn_in <= 1'b1;
        $display("_____________STEP NUMBER 1 ");
        $display("PREsend is %0b",vif.data_in);
        item.pack;
        $display("I DONT WHAT I HAVE TO DO %0b",item.instr);
        vif.drv.data_in <= item.instr;
        $display("I DONT WHAT I HAVE TO DO AGAIN %0b",item.instr);
        item.title = "EXAMINATIOIN";
        $display("INST_DRV sent instraction ------------ %0b",vif.data_in);
        $display("-----------------------------------------------------------");
        $display("______________STEP NUMBER 2");
        item.print;
        item.title = "INSTR_DRV";
        item.decode(vif.drv.data_in);
        $display("-----------------------------------------------------------");
        $display("______________STEP NUMBER 2");
        item.d_print;
    endtask

    task reset_intf();
        $display ("RESET INTF, %0b",vif.rst);
        vif.drv.akn_in <= 0;
        vif.drv.data_in <= 0;
    endtask

    task clear_intf();
        bit[15:0] data;
        std :: randomize(data); 
        $display("DATA FROM  CLEAN is %0b",data);
        vif.drv.akn_in <= 0;
        vif.drv.data_in <= data;
        $display("CLEAN INTF %0b", vif.stb_out);
        reset_intf;
    endtask
 
    
    task write_file (bit[15:0] instr);
        
    endtask
    
    task run();
        //full_set;
        random_instr;
    endtask
 
 
        
endclass

`endif

