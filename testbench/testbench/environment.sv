`ifdef ENVIRONMENT
`define ENVIRONMENT

//////////////new
//////////////build
//////////////reset
//////////////cfg_dut
//////////////start
//////////////wait_for_end
//////////////report
//////////////run


class environment
///////////// how to connect c model???????

        virtual  wishbone inst_cpu;
        virtual wishbone data_cpu;
        
        
        function new(virtual  wishbone inst_cpu, virtual wishbone data_cpu) begin
                                
        
        end
        
        
      //////////////////build  
        function bilt () begin 
                $display("Enviroment: build is started",$time);
                
                
                
                
                
                
                
                
                
                
                $display("Enviroment: build is complited",$time);        
        
        end
//////////////////////reset
        function reset () begin
                $display("Enviroment : reset is turned on")
                $display("Enviroment : reset was be commited",$time);
                
        
        end
/////////////////// run
        function run () begin
                $display("Enviroment : run is on");
                
                $display("Enviroment : run is done");
        
        
        end
///////////////// wait for end
        function wait_end () begin
                $display("Enviroment : wait is on");
                
                $display("Enviroment : wait is done");
        
        end
//////////////// report
        function report ()begin
                $display()
        
        end




`endif
