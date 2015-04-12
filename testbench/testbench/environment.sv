`ifdef ENVIRONMENT
`define ENVIRONMENT




class environment


        virtual wishbone inst_cpu;
        virtual wishbone data_cpu;
        virtual control cont_cpu;
        driver dr;
        scorebord sb;
        monitor mon;  
        mailbox mb_dr;
        mailbox mb_mon;      
        
        function new(virtual  wishbone inst_cpu, virtual wishbone data_cpu) begin
                      this wishbone = inst_cpu;
                      this wishbone = data_cpu;           
                      this control = cont_cpu;
        end
        
        
    
        function built () begin 
                $display("Enviroment: build is started. %0t",$time);
                // не понимаю как сделать блок built             
                
                
                
                
                
                
                
                
                $display("Enviroment: build is complited. %0t",$time);        
        
        end

        function reset () begin
                $display("Enviroment : reset is turned on. %0t",$time);
                cont_cpu.reset <= 1;
                repeat(5) @(posedge cont_cpu clk);
                inst_cpu.adr_out <=0;
                inst_cpu.adr_in <= 0;
                inst_cpu.data_in <=0;
                inst_cpu.data_out <=0;
                inst_cpu.we <= 0;
                inst_cpu.act_in <=0;
                insr_cpu.act_out <=0;
                inst_cpu.sel_out <=0:
                inst_cpu.sed_in <=0;
                inst_cpu.cyc_out <=0;

                data_cpu.adr_out <=0;
                data_cpu.adr_in <= 0;
                data_cpu.data_in <=0;
                data_cpu.data_out <=0;
                data_cpu.we <= 0;
                data_cpu.act_in <=0;
                data_cpu.act_out <=0;
                data_cpu.sel_out <=0:
                data_cpu.sed_in <=0;
                data_cpu.cyc_out <=0;

                $display("Enviroment : reset was be commited. %0t",$time);
                
        
        end

        function start () begin
                $display("Enviroment : run is on. %0t", $time);
                        fork 
                                drv.start;
                                mon.start;
                                sb.start;
                        join_any
                        
                $display("Enviroment : run is done. %0t", $time);
        
        
        end

        task wait_end () begin
                $display("Enviroment : wait is on. %0t", $time);
                repeat(10000) @(cont_cpu.clk);
                $display("Enviroment : wait is done. %0t", $time);
        
        end

        function void report ()begin
                $display()
      // не знаю что писать в функции report  
        end




`endif
