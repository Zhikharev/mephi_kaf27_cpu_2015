`ifndef DATA_DRIVER
`define DATA_DRIVER
class data_driver;
    virtual wishbone_if vif;
    bit[15:0] data;
    bit[9:0] addr;
    //mailbox #(data)
    
    function new (virtual wishbone_if vif,)
        this.vif= vif;
    
    endfunction

    
endclass


`endif
