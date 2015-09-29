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
   string title;
   
   
   function bit op_type();
      return opcode inside{ADD,ADDI,OR,AND,XOR,NOR,SLL,ROT,BNE,NOP};
   endfunction

   function bit[15:0] pack ();
      bit[15:0] inst;
      if(this.op_type()) begin
         inst[15:12] = opcode[3:0];
         if(opcode == ADDI)begin
             inst[11:8] = imm;
             inst[8:4] = rt;
             inst[3:0] = rd;
         end
         else begin
            inst[11:8]=rs;
            inst[8:4]=rt;
            inst[3:0]=rd;
         end
      end
      else begin 
      inst[15:10] = opcode;
         if(opcode inside {JR, JALR})begin
         inst[8:0]=0;
         inst[7:4]=rs;
         end
         else begin
         inst[9:0]=addr;
         end
      end
      $display("EXAMINATION from pack TRANSACTION ---------------- opcode is(%0b) rs(%0b) or imm(%0b) rt(%0b) rd(%0b)",opcode,rs,imm,rt,rd);
      $display("EXAMINATION from pack INSTRACTION is ------------------- %0b",inst);      
      return inst;
   endfunction
   
   function decode (bit[15:0] instr);
            int loc;
            $display("TRANSACTION --------- decode method has accepted instraction %0b",instr);
            if(instr[15:12] inside{4'b1001,4'b1010,4'b1011}) begin
                loc = instr[15:10];
                d_opcode = opcod_t'(loc);
                if(d_opcode inside{JR,JALR})begin
                    loc = instr[7:4];
                    d_rs = reg_t'(loc);
                end
                else begin
                    d_addr = instr[9:0];      
                end
            end
            else begin
                loc = instr[15:12];
                d_opcode = opcod_t'(loc);
                if(d_opcode == ADDI) begin
                    d_imm = instr[11:8];
                    loc = instr[8:4];
                    d_rt = reg_t'(loc);
                    loc = instr[3:0];
                    d_rd = reg_t'(loc);
                end
                else begin
                    loc = instr[11:8];
                    d_rs = reg_t'(loc);    
                    loc = instr[8:4];
                    d_rt = reg_t'(loc);
                    loc = instr[3:0];
                    d_rd = reg_t'(loc);
                    
                end
            end
    
   endfunction
   
   function void print ();
        if(opcode inside{ADD,OR,AND,XOR,NOR,SLL,ROT,BNE})begin
        $display("%0s: instraction is -------------------------  %0s(%0b), rs(%0s), rt(%0s), rd(%0s)",title,opcode.name(),opcode,rs.name(),rt.name(),rd.name());
        end
        else begin
            if(opcode inside{ADDI})begin
             $display("%0s : instaraction is ------------------------- %0s(%0b) , imm(%0b(%0d)), rt(%0s), rd(%0s)",title, opcode.name(),opcode, imm,imm, rt.name(), rd.name());
            end
            else begin
                if(opcode inside{LDL,LDH,STL,STH,JMP,JAL})begin
                $display("%0s: instraction is -------------------------- %0s(%0b), addr(%0h(%0d))",title, opcode.name(),opcode, addr, addr);            
                end
                else begin
                    if(opcode inside{JR, JALR})begin
                    $display("%0s: instraction is -------------------------- %0s(%0b) , rs(%0s)",title, opcode.name(),opcode, rs.name());
                    end
                    else begin
                    $display("FROM %0s TRANSACTION(print method) : ERROR  instraction is not right",title);
                    end
                end
            end          
        end
   endfunction     
  
function void d_print ();
        if(d_opcode inside{ADD,OR,AND,XOR,NOR,SLL,ROT,BNE})begin
        $display("%0s: decoded instraction is -----------------  %0s(%0b) , rs(%0s), rt(%0s), rd(%0s)",title,d_opcode.name(),d_opcode,d_rs.name(),d_rt.name(),d_rd.name());
        end
        else begin
            if(d_opcode inside{ADDI})begin
             $display("%0s: decoded instaraction is ----------------  %0s(%0b) , imm(%0b(%0d)), rt(%0s), rd(%0s)",title, d_opcode.name(),d_opcode, d_imm,imm, d_rt.name(), d_rd.name());
            end
            else begin
                if(d_opcode inside{LDL,LDH,STL,STH,JMP,JAL})begin
                $display("%0s: decoded instraction is -----------------  %0s(%0b), addr(%0h(%0d))",title, d_opcode.name(),d_opcode, d_addr, d_addr);            
                end
                else begin
                    if(d_opcode inside{JR, JALR})begin
                    $display("%0s: decoded instraction is -----------------  %0s(%0b) , rs(%0s)",title, d_opcode.name(),d_opcode, d_rs.name());
                    end
                    else begin
                    $display("FROM %0s TRANSACTION(decode method) : ERROR  instraction is not right %0b",title,d_opcode);
                    end
                end
            end          
        end
   endfunction     
  
    
  
endclass

    
`endif

/*

//viribles for not full randomisation
   
   opcode_t nr_opcode;
   rand bit[3:0] nr_imm;
   rand bit[9:0] nr_addr;
   rand reg_t nr_rs;
   rand reg_t nr_rd;
   rand reg_t nr_rt;
   


  function bit nr_op_type();
      return nr_opcode inside{ADD,ADDI,OR,AND,XOR,NOR,SLL,ROT,BNE,NOP};
   endfunction

   
   function bit[15:0] nr_pack ();
      bit[15:0] inst;
      if(this.nr_op_type()) begin
         nr_inst[15:12] = nr_opcode[3:0];
         if(nr_opcode == ADDI)begin
             inst[11:8] = nr_imm;
             inst[8:4] = nr_rt;
             inst[3:0] = nr_rd;
         end
         else begin
            inst[11:8]=nr_rs;
            inst[8:4]=nr_rt;
            inst[3:0]=nr_rd;
         end
      end
      else begin 
      inst[15:10] = nr_opcode;
         if(opcode inside {JR, JALR})begin
         inst[8:0]=0;
         inst[7:4]=nr_rs;
         end
         else begin
         inst[9:0]=nr_addr;
         end
      end
      return inst;
   endfunction



*/



