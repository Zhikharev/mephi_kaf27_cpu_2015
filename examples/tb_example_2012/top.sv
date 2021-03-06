
module top();

    int a = 0;
    int i,t,mod_A,mod_S,mod_PC;
    // assembler vector commands
    // one command is 32 bits, 1 cmd = data[3:0]
    reg [7:0] data [19:0];
    bit bytes[];
    byte state;
    logic [31:0]check_A;
    logic [31:0] check_S;
    logic [20:0] check_PC;
  


    //imports of c-functions
    import "DPI-C" function void setfile();
    import "DPI-C" function byte run(int);
    import "DPI-C" function int checkreg(int);
    import "DPI-C" function int checkmemory(int);

    // Clk declaration
    bit clk;
    initial forever #20 clk=~clk;

    // ports declarations
    clk_reset clk_reset(clk);
    input_interface_rx ipr_intf(clk);

        // Instalation of a CPU-model
        main cpu_model(
            .clk(clk),
            .rx(ipr_intf.rx),
            .reset(clk_reset.reset),
            .startbut(clk_reset.startbut),
            .check_A(check_A),
            .check_S(check_S),
            .check_PC(check_PC)
        );
    
        // Reset method
       task reset();
        $display("%0d: TEST : start of reset() method",$time);
        ipr_intf.cb.rx <= 1;    
        clk_reset.reset <= 1;
        repeat (RESET) @clk_reset.clk;
        clk_reset.reset <= 0;
        clk_reset.startbut <= 0;
        endtask: reset
 
    // displays some info and causes c-functions
    // start model
    task start_test();
        $display("***** TEST STARTED *****");
        $display("***** MODEL IS GOING TO WORK *****");
        $display("%0d TEST : setfile function is going",$time);
        setfile();
        $display("%0d TEST: run function is going",$time);
        while (a!=-2)
            begin
                $display("Run is going");
                a=run(1);
            end
        $display("The run is over with value %0d",a);
        $display("%0d TEST: chekreg function is going",$time);
        mod_A = checkreg(0);
        mod_S = checkreg(7);
        mod_PC = checkreg(9);

        
    endtask: start_test
    
    // using readmemh and readmemb functions for loading .bin file to RTL
    task load_bin();
        $display("***** RTL IS GOING TO WORK *****");
        $display("%0d TEST: bin file is going to be loaded",$time);
        $readmemh("run3forrtl1.bin",data);
        $display("The bin file consists of:");
        for(i=0; i<20; i++)
            $display("%d: %b",i,data[i]);   
    endtask: load_bin

    // task which drives data to RTL using specific protocol
    task drive_bin();
        $display("%0d TEST: bin file is going to be loaded",$time);
            for(i=0; i<20; i++)
                begin
                    state = data[i];
                    // packing
                    bytes = new[DBIT+3];
                    bytes[0] = 0; // start bit
                    for(t=1; t<=DBIT;t++) // data
                        bytes[t] = state[t-1];
                    for(t=1;t<=DBIT;t++)
                        bytes[DBIT+1]=bytes[DBIT+1]+bytes[t]; // parity
                    bytes[DBIT+2] = 1;  // stop bit
                    // driving
                    ipr_intf.cb.rx <= bytes[0]; //start bit
                    repeat(wait_clk)@(posedge ipr_intf.clk);
                    for(t=1;t<=DBIT+2;t++)
                        begin
                            ipr_intf.rx <= bytes[t];
                            repeat(wait_clk)@(posedge ipr_intf.clk);
                        end                                 
                    $display("%0d TEST: finished driving the 8 bits bin file: %b\n",$time,state);
                end         
        $display("%0d TEST : finished driving bin file \n",$time); 
    endtask: drive_bin

    task display_results();
        $display("%0d TEST: Results from RTL are going to be displayed",$time);
        $display("**********DEBUG**********");
        $display("reg A = %0d",check_A);
        $display("reg S = %0d",check_S);
        $display("PC = %0d",check_PC);
        $display("**********DEBUG**********");
    endtask: display_results

    task compare_results();
        $display("%0d TEST: Results are going to be compared",$time);
        if (mod_A != check_A)
            begin
            $display("There is an error with reg A");
            $display("mod_A = %0d reg_A = %0d",mod_A,check_A);
            error++;
            end
      
        if (mod_S != check_S)
                begin
                $display("There is an error with reg S");
                $display("mod_S = %0d reg_S = %0d",mod_S,check_S);
                error++;
                end
                
        if (mod_PC != check_PC)
                    begin
                    $display("Thereis an error with reg PC");
                    $display("mod_PC = %0d reg_PC = %0d",mod_PC,check_PC);
                    error++;
                    end
        if (error != 0)
            $display("%0d TEST: TEST ENDS WITH %0d ERRORS!",$time,error);
        else
            $display("%0d TEST: TEST PASSED!",$time);
               
    endtask: compare_results
            
            

//  I N I T I A L  //                
   initial
        begin
            reset();
            //start_test();
            //repeat(5000)@(posedge ipr_intf.clk);
            load_bin;
            drive_bin;
            clk_reset.startbut = 1;
            repeat(1)@(posedge ipr_intf.clk);
            clk_reset.startbut = 0;
            repeat(9)@(posedge ipr_intf.clk);
            repeat(16)@(posedge ipr_intf.clk);
            display_results();
            //compare_results();
            $finish();
        end 






endmodule: top
