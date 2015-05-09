`ifndef TRANSACTION
`define TRANSACTION


typedef enum bit[3:0] {
        A  = 4'b0000,
        B  = 4'b0001,
        C  = 4'b0010,
        D  = 4'b0011,
        E  = 4'b0100,
        F  = 4'b0101,
        G  = 4'b0110,
        H  = 4'b0111,
        W  = 4'b1000,
        K  = 4'b1001,
        MR = 4'b1010,
        LR = 4'b1011,
      zero = 4'b1100,
       t0  = 4'b1101,
       t1  = 4'b1110,
       t2  = 4'b1111
}reg_t;
                      
typedef enum bit[5:0] {
        ADD  = 6'b000000,
        ADDI = 6'b000001,
        OR   = 6'b000010,
        AND  = 6'b000011,
        XOR  = 6'b000100,
        NOR  = 6'b000101,
        SLL  = 6'b000110,
        ROT  = 6'b000111,   
        BNE  = 6'b001000,
        NOP  = 6'b001100,
        
        LDL  = 6'b100100,
        LDH  = 6'b100110,
        STL  = 6'b101000,
        STH  = 6'b101010,	
        JMP  = 6'b101100,
        JAL  = 6'b101001,
        JR   = 6'b101110,
        JALR = 6'b101111
}opcod_t;

class trans;
   rand bit[3:0] imm;
   rand bit[9:0] addr;
   rand reg_t rs;
   rand reg_t rd;
   rand reg_t rt;
   rand opcod_t opcode;
   constraint reg_c {
    rd != zero;
    rt != zero;   
   }
   //varibles of decode 
   opcod_t d_opcode;
   reg_t d_rs;
   reg_t d_rd;
   reg_t d_rt;
   bit[9:0] d_addr;
   bit[3:0] d_imm;
   
   function bit op_type();
      return opcode inside{ADD,ADDI,OR,AND,XOR,NOR,SLL,ROT,BNE,NOP};
   endfunction

   function bit[15:0] pack ();
      bit[15:0] inst;
      if(this.op_type()) begin
         inst[3:0] = opcode[3:0];
         
         if(opcode == ADDI)begin
             inst[7:4] = imm;
             inst[11:8] = rt;
             inst[15:12] = rd;
         end
         else begin
            inst[7:4]=rs;
            inst[11:8]=rt;
             inst[15:12]=rd;
         end
   
      end

      else begin 
      inst[5:0] = opcode;
         if(opcode inside {JR, JALR})begin
         inst[9:8]=0;
         inst[3:0]=0;
         inst[7:4]=rs;
         end
         else begin
         inst[15:6]=addr;
         end
      end
     // $display("%0b",inst);
      return inst;
   endfunction
   
   function decode (bit[15:0] instr);
            int loc;
            if(instr[3:0] inside{4'b1001,4'b1010,4'b1011}) begin
                loc = instr[5:0];
                d_opcode = opcod_t'(loc);
                if(d_opcode inside{JR,JALR})begin
                    loc = instr[7:4];
                    d_rs = reg_t'(loc);
                end
                else begin
                    d_addr = instr[15:6];      
                end
            end
            else begin
                loc = instr[3:0];
                d_opcode = opcod_t'(loc);
                if(d_opcode == ADDI) begin
                    d_imm = instr[7:4];
                    loc = instr[11:8];
                    d_rt = reg_t'(loc);
                    loc = instr[15:12];
                    d_rd = reg_t'(loc);
                end
                else begin
                    loc = instr[7:4];
                    d_rs = reg_t'(loc);    
                    loc = instr[11:8];
                    d_rt = reg_t'(loc);
                    loc = instr[15:12];
                    d_rd = reg_t'(loc);
                    
                end
            end
    
   endfunction
   
   function void print ();
        if(opcode inside{ADD,OR,AND,XOR,NOR,SLL,ROT,BNE})begin
        $display(": instraction is ------------------------- %0s , rs(%0s), rt(%0s), rd(%0s)",opcode.name(),rs.name(),rt.name(),rd.name());
        end
        else begin
            if(opcode inside{ADDI})begin
             $display(": instaraction is ------------------------ %0s , imm(%0b(%0d)), rt(%0s), rd(%0s)", opcode.name(), imm,imm, rt.name(), rd.name());
            end
            else begin
                if(opcode inside{LDL,LDH,STL,STH,JMP,JAL})begin
                $display(": instraction is ------------------------- %0s, addr(%0h(%0d))", opcode.name(), addr, addr);            
                end
                else begin
                    if(opcode inside{JR, JALR})begin
                    $display(": instraction is ------------------------- %0s , rs(%0s)", opcode.name(), rs.name());
                    end
                    else begin
                    $display("TRANSACTION(print method) : ERROR  instraction is not right");
                    end
                end
            end          
        end
   endfunction     
  
function void d_print ();
        if(d_opcode inside{ADD,OR,AND,XOR,NOR,SLL,ROT,BNE})begin
        $display(": decoded instraction is ------------------------- %0s , rs(%0s), rt(%0s), rd(%0s)",d_opcode.name(),d_rs.name(),d_rt.name(),d_rd.name());
        end
        else begin
            if(d_opcode inside{ADDI})begin
             $display(": decoded instaraction is ------------------------ %0s , imm(%0b(%0d)), rt(%0s), rd(%0s)", d_opcode.name(), d_imm,imm, d_rt.name(), d_rd.name());
            end
            else begin
                if(d_opcode inside{LDL,LDH,STL,STH,JMP,JAL})begin
                $display(": decoded instraction is ------------------------- %0s, addr(%0h(%0d))", d_opcode.name(), d_addr, d_addr);            
                end
                else begin
                    if(opcode inside{JR, JALR})begin
                    $display(": decoded instraction is ------------------------- %0s , rs(%0s)", d_opcode.name(), d_rs.name());
                    end
                    else begin
                    $display("TRANSACTION(decode method) : ERROR  instraction is not right");
                    end
                end
            end          
        end
   endfunction     
  
    
  
endclass

    
`endif


/*

this.bin_instr = bin_instr;
        if(this.bin_instr[3:0] inside{4'b1010 , 4'b1001}) begin
            d_opcode = bin_instr[5:0];
            if(d_opcode inside{JR,JALR})begin
                d_rs = bin_instr[7:4];
            end
            else begin
                d_addr = bin_instr[15:6];
            end
        end
        else begin
            d_opcode = bin_instr[3:0];
            if(d_opcode == ADDI) begin
                d_imm =bin_instr[7:4];
                d_rt = bin_instr[11:8];
                d_rd = bin_instr[15:12];
            end
            else begin
              d_rs = bin_instr[7:4];
              d_rt = bin_instr[11:8];
              d_rd = bin_instr[15:12];
            end
        end
*/

