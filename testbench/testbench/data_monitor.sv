`ifndef DATA_MONITOR
`define DATA_MONITOR

class data_monitor;
    virtual wishbone_if vif;
    virtual inner_if vif_m2m;
    mailbox #(trans) mb_mon2sb;
     
    function new (virtual wishbone_if vif,virtual inner_if vif_m2m, mailbox #(trans) mb_mon2sb);
        this.vif = vif;
        this.vif_m2m = vif_m2m;
        if (mb_mon2sb == null) begin
			$display("Monitor : Error - mailbox mb_mon2sb is empty");
			//$finish;
		end
		else begin
			this.mb_mon2sb = mb_mon2sb;
        end
    endfunction
    
    task adr_cont();
        bit[9:0] addr_out;
        forever begin
            @(vif.mon);
            if(!vif.mon.rst) begin
                if(vif.mon.akn_in) begin
                      if(store_wotcher() == null)begin
                      
                      end            
                      else begin 
                        addr_out = vif.mon.adr_out;
                        if(addr_out == store_wotcher())begin
                            //model :: SATMEM(addr_out)
                        end      
                        else begin
                             $display("DATA MONITOR : ERROR mismaches betwine addreses");
                        end
                      end
                end
                
            end         
         end   
    endtask

    function store_wotcher ();
        bit[9:0] addr;
        bit [15:0] instr;
        //this.instr=instr;
        instr = vif_m2m.mon2mon;
        if(instr[5:0] == 6'b101001 && 6'b101011) begin
            addr = instr[15:6];
            return addr;
        end
        else begin
           // return 0;
        end
    endfunction

endclass




`endif

/*if(inst[5:0] == 6'b101001 && 6'b101011)begin
                        if(inst inside{6'b101001}) $display(" DATA MONITOR: -------- was requestin to memory STL");
                        if(inst inside{6'b101010}) $display(" DATA MONITOR: -------- was requestin to memory STH");
                        // model :: SETMEM(inst[15:6])
                    end           
                    if(inst[5:0] == 6'b100101 && 6'b100111)begin
                        if(inst inside{6'b100101}) $display(" DATA MONITOR: -------- was requestin to memory LDL");
                        if(inst inside{6'b100110}) $display(" DATA MONITOR: -------- was requestin to memory LDH");
                        //  model :: GETMEM(inst[15:6])
                    end


*/

