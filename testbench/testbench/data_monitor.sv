`ifndef DATA_MONITOR
`define DATA_MONITOR

class data_monitor;
    virtual wishbone_if vif;
    mailbox #(bit[15:0]) mb_mon2mon;
    mailbox #(trans) mb_dmon2sb;
    
     
    function new (virtual wishbone_if vif, mailbox #(bit[15:0]) mb_mon2mon, mailbox #(trans) mb_dmon2sb);
        this.vif = vif;
        if (mb_dmon2sb == null) begin
			$display("INSTR MONITOR : Error - mailbox mb_mon2sb is empty");
		end
		else begin
			this.mb_dmon2sb = mb_dmon2sb;
        end
        if(mb_mon2mon == null)begin
            $display("INST MONITOR : ERROR - mailbox mb_mon2mon is empty");
        end
        else begin
            this.mb_mon2mon = mb_mon2mon;
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
                             if(vif.mon.we_out == 1) begin
                            
                             end
                             else begin
                                $display("DATA MONITOR : ERROR we_out is null ,%0t", $time);                           
                             end

                        end      
                        else begin
                             $display("DATA MONITOR : ERROR mismaches betwine addreses ,%0t", $time);
                                if(vif.mon.we_out == 1) begin
                            
                                end
                                else begin
                                  $display("DATA MONITOR : ERROR we_out is null ,%0t", $time);                           
                                end

                        end
                    end
                end
                
            end         
         end   
    endtask

    function  store_wotcher ();
        bit[9:0] addr;
        bit [15:0] instr = mb_mon2mon.get(instr);
        //this.instr=instr;
        if(instr[5:0] == 6'b101001 && 6'b101011) begin
            addr = instr[15:6];
            return addr;
        end
        else begin
            addr = 0;// can't jast write return 0
            return addr;
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

