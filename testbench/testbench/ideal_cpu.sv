`ifndef IDEAL_CPU
`define IDEAL_CPU



class ideal_cpu;
    logic  [31:0]regs [12'd2];    
    logic [31:0] pc;  
    
    
     trans mnem; //for geting mnemonic of comands 
     
        
     function void operation (bit[15:0] instr);
       /* mnem.decode(instr);   
        if(mnem.d_opcode == ADD) begin
           regs[mnem.d_rd] = regs[mnem.d_rs] + regs[mnem.d_rt];
        end
        if(mnem.d_opcode == ADDI) begin
           regs[mnem.d_rd] = regs[mnem.d_rs] + mnem.d_imm; 
        end
        if(mnem.d_opcode == OR) begin
           regs[mnem.d_rd] = regs[mnem.d_rs] | regs[mnem.d_rt];
        end
        if(mnem.d_opcode == AND) begin
            regs[mnem.d_rd] = regs[mnem.d_rs] & regs[mnem.d_rt];
        end
        if(mnem.d_opcode == XOR) begin
            regs[mnem.d_rd] = regs[mnem.d_rs] ^ regs[mnem.d_rt];
        end
        if(mnem.d_opcode == NOR) begin
            regs[mnem.d_rd] = ~(regs[mnem.d_rs] | regs[mnem.d_rt]);
        end
        if(mnem.d_opcode == SLL) begin
            regs[mnem.d_rd] = regs[mnem.d_rs] << regs[mnem.d_rt];
        end
        if(mnem.d_opcode == ROT) begin
            regs[mnem.d_rd] = regs[mnem.d_rs] <<< regs[mnem.d_rt];
        end
        if(mnem.d_opcode == NOP) begin
            
        end
        if(mnem.d_opcode == BNE) begin
            if(regs[mnem.d_rs] != regs[mnem.d_rt]) pc = pc + regs[mnem.d_rd];
        end 
        
        ////////////////
        
        if(mnem.d_opcode == LDL) begin
            
        end
        if(mnem.d_opcode == LDH) begin
           
        end
        if(mnem.d_opcode == STL) begin
            
        end
        if(mnem.d_opcode == STH) begin
        
        end
        if(mnem.d_opcode == JMP) begin
            pc = mnem.addr;
        end
        if(mnem.d_opcode == JAL) begin
            regs[4'b1011] = pc +2;
            pc = mnem.addr;
        end
        if(mnem.d_opcode == JR) begin
            pc = mnem.d_rs;
        end
        if(mnem.d_opcode == JALR) begin
            regs[4'b1011] = pc +2;
            pc = mnem.d_rs;
        end
        if(mnem.d_opcode == NOP) begin
        
        end*/
     endfunction   

        
endclass





`endif
