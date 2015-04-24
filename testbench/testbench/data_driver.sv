`ifndef DATA_DRIVER
`define DATA_DRIVER
class data_driver;
    virtual wishbone_if vif;
    mailbox #(bit[15:0]) mb_dr2dr; 
    
    function new (virtual wishbone_if vif,mailbox #(bit[15:0]) mb_dr2dr);
        this.vif= vif;
        this.mb_dr2dr = mb_dr2dr;    
    endfunction

    task load_wotcher (bit[15:0] item);
       bit[31:0] data;
       //data = model :: GETMEM(instr[15:6]); 
       // is line above right or no 
       if(item[6:0] == 6'b100100) begin
           vif.drv.data_in <= data[15:0];
       end
       else begin
           vif.drv.data_in <= data[31:16];
       end
    endtask
   
   task start();
       forever begin
            bit[15:0] instr = mb_dr2dr.get(instr);
            if(instr[6:0] inside{6'b100100/*LDL*/,6'b100111/*LDH*/})begin
                load_wotcher(instr);
            end
       end 

   endtask 
endclass


`endif
