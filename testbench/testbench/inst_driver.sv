`ifndef DRIVER
`define DRIVER


class instr_driver;
    virtual wishbone_if vif;
    trans instr;
    mailbox #(trans) mb_idr2sb;
    mailbox #(trans) mb_dr2dr;
    bit[15:0]file_instr[$];
    int cycles = 5;
    
    
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
                    $display("CARRING CYCLE %0d was at %0t",carring_cycle,$time);
                    sec_instr.print;
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
        item.decode(vif.drv.data_in);        
        item.d_print;  
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
        if(file_instr.size) begin
            $display("INSTR DRIVER : mode queue is on ");
            $display("INSTR DRIVER : amount of elements of qeueu is %0d",file_instr.size);
            queue_instr;
        end
        else begin
            $display("INSTR DRIVER : mode random is om");
            $display ("ammount of instractions is %0d", cycles);
            $display ("YOU ARE WELCOME THE COOLES DECODE OF INSTRACTION IN THE WORLD___(mesedge from instr_driver_line 116)");
            random_instr;
        end
    endtask
 
  /*  task read_files ();
        bit[15:0]instr_q[$];
        bit[15:0]mem_q[$];
        if(!$fopen("instr.bin"))$display("INST DRIVER :file was red at %0d",$time);
        else $diaplay("INST DRIVER : ERROR file can not find ");
        $readmemb("instr.bin",instr_q);
        $display("TTTTTTTTTTTTTTTTTTT%0d",instr_q.size);
    
    endtask
*/
        
endclass

`endif

