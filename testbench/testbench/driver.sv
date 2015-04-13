`ifdef DRIVER
`define DRIVER
`define inst=instraction; // что это??? 
class
        virtual wishbone dr_int;
        mailbox #(trans) mb_dr;
        trans inst;
        
        function new (virtual wishbone dr_int , mailbox #(inst) mb_dr)
                this dr_int = dr_int;
               
                if (mb_dr == null) begin
                      $display("Driver -- --  ERROR mailbox is emply ");
                      $finish;
                end 
                else  this mb_dr = mb_dr;
        
        endfunction


        







endclass



















`endif
