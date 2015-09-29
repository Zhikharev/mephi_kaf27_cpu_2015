`ifndef MY_SCOREBORD
`define MY_SCOREBORD

class scorebord;

    logic [31:0]sb_regs[12'd2];    
    logic [31:0]sb_pc;
    int cycles;
     int carring_cycle = 0;
    ideal_cpu ideal; 
    enum {a,b,c,d,e,f,g,h,w,k,mr,lr,zero,t0,t1,t2} nemes_of_regs;        
        
    virtual wishbone_if vif_instr;
    virtual inner_if vif_inner;
    virtual tb_control_if vif_tb;
     
    function new (virtual wishbone_if vif_instr,virtual inner_if vif_inner, virtual tb_control_if vif_tb);
        ideal = new();
        this.vif_instr = vif_instr;
        this.vif_inner = vif_inner;
        this.vif_tb = vif_tb;
    endfunction
    
    task get_cpu_regs ();
//        @(vif_instr.drv);
        if(!vif_instr.drv.stb_out) begin
            vif_inner.a_reg = sb_regs[a];
            vif_inner.b_reg = sb_regs[b];
            vif_inner.c_reg = sb_regs[c];
            vif_inner.d_reg = sb_regs[d];
            vif_inner.e_reg = sb_regs[e];
            vif_inner.f_reg =sb_regs[f];
            vif_inner.g_reg = sb_regs[g];
            vif_inner.h_reg = sb_regs[h];
            vif_inner.w_reg = sb_regs[w];
            vif_inner.k_reg = sb_regs[k];
            vif_inner.mr_reg = sb_regs[mr];
            vif_inner.lr_reg = sb_regs[lr];
            vif_inner.zero_reg = sb_regs[zero];
            vif_inner.t0_reg = sb_regs[t0];
            vif_inner.t1_reg = sb_regs[t1];
            vif_inner.t2_reg = sb_regs[t2]; 
            vif_inner.pc = sb_pc;
            compaer;
        end
    endtask
    
    
    
    
    task compaer ();
     /*  int i;
       if(ideal.mnem.d_opcode == STL) begin
            if(vif_tb.data_out[15:0] != sb_regs[mr][15:0]) begin
            vif_tb.addr_in = ideal.mnem.d_addr;
                $display ("ERROR" ); ////// 
                //log(1);
            end    
        end
        if(ideal.mnem.d_opcode == STH) begin
            vif_tb.addr_in = ideal.mnem.d_addr;
            if(vif_tb.data_out[31:16] != sb_regs[mr][31:16]) begin
                $display ("ERROR" ); ////// 
               // log(1);
            end    
        end
        if(ideal.mnem.d_opcode == LDL)begin
            vif_tb.addr_in = ideal.mnem.d_addr;
            if(vif_tb.data_out[15:0] != sb_regs[mr][15:0]) begin
                $display ("ERROR");////
              //  log(1);     
            end
            
        end
        if(ideal.mnem.d_opcode == LDH)begin
            vif_tb.addr_in = ideal.mnem.d_addr;
            if(vif_tb.data_out[31:16] != sb_regs[mr][31:16]) begin
                $display ("ERROR");////
               // log(1);     
            end
            
        end
        //else begin
            for(i=0;i<13;i=i+1) begin : forloop
                if(ideal.regs[i] != sb_regs[i]) begin
                    $display("ERROR"); /////
                  //  log(1);
                end
            end        
        //end*/
    endtask



    
     task run ();
      /*  
        do begin
           
            @(vif_instr.drv);
            if(!vif_instr.rst) begin
                if(vif_instr.drv.akn_in) begin
                    ideal.operation(vif_instr.drv.data_in);
                    wait(vif_instr.drv.stb_out == 0);
                    get_cpu_regs;           
                    carring_cycle = carring_cycle + 1;
                end
            end
        end         
        while(carring_cycle != cycles);*/ 
     endtask    
endclass



`endif


