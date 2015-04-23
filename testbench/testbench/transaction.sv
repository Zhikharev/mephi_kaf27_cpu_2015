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
   string decoded_inst;
   constraint reg_c {
    rd != zero;
    rt != zero;   
   }
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
            decoded_inst = {opcode,imm,rt,rd};
         end
         else begin
            inst[7:4]=rs;
            inst[11:8]=rt;
             inst[15:12]=rd;
            decoded_inst = {opcode,rs,rt,rd};
         end
   
      end

      else begin 
      inst[5:0] = opcode;
         if(opcode inside {JR, JALR})begin
         inst[9:8]=0;
         inst[3:0]=0;
         inst[7:4]=rs;
         decoded_inst = {opcode,rs};
         end
         else begin
         inst[15:6]=addr;
         decoded_inst = {opcode,inst};
         end
      end
      return inst;
   endfunction
   
   function void print ();
        if(opcode inside{ADD,OR,AND,XOR,NOR,SLL,ROT,BNE}); 
        $display(": instraction is %0s , rs(%0s), rt(%0s), rd(%0s)",opcode.name(),rs.name(),rt.name(),rd.name());
        if(opcode inside{ADDI});
        $display(": instaraction is %0s , imm(%0b(%0d)), rt(%0s), rd(%0s)", opcode.name(), imm,imm, rt.name(), rd.name());
        if(opcode inside{LDL,LDH,STL,STH,JMP,JAL});
        $display(": instraction is %0s, addr(%0h(%0d))", opcode.name(), addr, addr);            
        if(opcode inside{JR, JALR});
        $display(": instraction is %0s , rs(%0s)", opcode.name(), rs.name());
   endfunction     
  
endclass



`endif
/*  function decode_inst (bit[15:0] inst);
        opcod_t opcode;
        reg_t rs;
        reg_t rd;
        reg_t rt;
        bit[9:0] addr;
        bit[3:0] imm;
        this.imm = imm;
        this.rs =rs;
        this.rd =rd;
        this.rt =rt;
        this.opcode = opcode;
        this.inst = inst;
        if(inst[3:0] == 4'b1001) begin
            opcode = inst[5:0];
            if(opcode inside {JR,JALR}) begin
              rs = inst[15:12]; 
              decoded_inst = {opcode,rs};           
            end    
            else begin
                addr = inst[9:0];
                decoded_inst = {opcode,addr};
            end
        end        
        else begin
            opcode = inst[3:0];
            if(opcode == ADDI)begin
             imm = inst[7:4]; 
             rt = inst[11:8];
             rd = inst[15:12];
             decoded_inst = {opcode,imm,rt,rd};
            end
         else begin
            rs = inst[7:4];
            rt =inst[11:8];
            rd = inst[15:12];
            decoded_inst = {opcode,rs,rt,rd};
         end
        end 
        
           
    endfunction

   */


