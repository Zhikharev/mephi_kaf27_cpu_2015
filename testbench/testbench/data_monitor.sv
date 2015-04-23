`ifndef DATA_MONITOR
`define DATA_MONITOR

class data_monitor;
    virtual wishbone_if vif;
    mailbox #(trans) mb_mon2sb;
     
    function new (virtual wishbone_if vif,mailbox #(trans) mb_mon2sb);
        this.vif = vif;
        if (mb_mon2sb == null) begin
			$display("Monitor : Error - mailbox mb_mon2sb is empty");
			//$finish;
		end
		else begin
			this.mb_mon2sb = mb_mon2sb;
        end
    endfunction
    
    task get_trans();
        bit[15:0] inst;
        forever begin
            @(vif.mon);
            if(!vif.mon.rst) begin
                if(vif.mon.akn_in) begin
                    inst = vif.mon.data_in;
                    if(inst[5:0] == 6'b101001 && 6'b101011)begin
                        if(inst inside{6'b101001}) $display(" DATA MONITOR: -------- was requstin to memory STL");
                        if(inst inside{6'b101010}) $display(" DATA MONITOR: -------- was requstin to memory STH");
                        // model :: SETMEM(inst[15:6])
                    end           
                    if(inst[5:0] == 6'b100101 && 6'b100111)begin
                        if(inst inside{6'b100101}) $display(" DATA MONITOR: -------- was requstin to memory LDL");
                        if(inst inside{6'b100110}) $display(" DATA MONITOR: -------- was requstin to memory LDH");
                        //model :: GETMEM(inst[15:6])
                    end
                end
                
            end         
         end   
    endtask

    

endclass








`endif
