`ifndef DRIVER
`define DRIVER


class instr_driver;
    virtual wishbone_if vif;
    trans instr;
    mailbox #(trans) mb_idr2sb;
    mailbox #(bit[15:0]) mb_dr2dr;
    int cycles = 5;
    
    
    function new (virtual wishbone_if vif, mailbox #(trans) mb_idr2sb, mailbox #(bit[15:0]) md_dr2dr);
        this.vif = vif;
        if (mb_idr2sb == null) begin
            $display("DRIVER : ERROR mailbox is null");
        end
        else begin
            this.mb_idr2sb = mb_idr2sb;
        end
        if(mb_dr2dr == null) begin
            $display("DATA DRIVER : ERROR mailbox dr2dr is empty");
        end
        else begin
            this.mb_dr2dr = mb_dr2dr;
        end
    endfunction 

    task run();
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
        while(carring_cycle != cycles);
        
    endtask
    
    
    task send_instr (trans item);
        vif.drv.akn_in <= 1'b1;
        vif.drv.data_in <= item.pack;  
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
 

endclass

`endif
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

