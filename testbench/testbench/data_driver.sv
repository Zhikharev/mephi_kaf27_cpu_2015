`ifndef DATA_DRIVER
`define DATA_DRIVER
class data_driver;
    virtual wishbone_if vif;
    mailbox #(bit[15:0]) mb_dr2dr; 
    
    function new (virtual wishbone_if vif,mailbox #(bit[15:0]) mb_dr2dr);
        this.vif= vif;
        this.mb_dr2dr = mb_dr2dr;    
    endfunction

    task  load_wotcher();
        bit[15:0] instr;
        bit[9:0] addres;
        bit[15:0] check;
        bit[31:0] tmp;
        forever begin
            mb_dr2dr.try_get(instr);
            check = vif.drv.data_in;
            if(instr[5:0] inside{5'b10010,5'b10011})begin
                if(check[5:0] inside{5'b10010,5'b10011})begin
                    addres = vif.drv.adr_out;
                    //tmp = model :: GETMEM(addres);
                    if(instr[5:0] == 5'b10010)begin
                       // vif.drv.SMT = tmp[15:0];
                    end 
                    if(instr[5:0] == 5'b10011)begin
                        // vif.drv.SMT == tmp[31:16];
                    end
                end
                else begin
                    $display("DATA DRIVER : ERROR mismaches betwine mb_dr2dr end data_in(load comand),  at  %0t", $time);
                end
            end
        
        end
    endtask

     task  store_wotcher();
        bit[15:0] instr;
        bit[15:0] check;
        bit[9:0] addres;
        forever begin
            mb_dr2dr.try_get(instr);
            check = vif.drv.data_in;
            if(instr[5:0] inside{5'b10100,5'b10101})begin
                if(check[5:0] inside{5'b10100,10101})begin
                    addres = vif.drv.adr_out;
                    // how to divide on low high??????????
                end
                else begin
                    $display("DATA DRIVER : ERROR mismaches betwine mb_dr2dr end data_in(store comand),  at  %0t", $time);
                end
            end
        end
     endtask

     
     task run();
        $display("DATA DRIVER IS RAN %0t", $time);
        fork 
        store_wotcher;
        load_wotcher;
        join_any
     endtask



endclass


`endif
