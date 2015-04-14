`ifndefTRANSACTION
`defineTRANSACTION

typedefenumbit[3:0]{
   A=4'b0000,
   B=4'b0001,
   C=4'b0010,
   D=4'b0011,
   E=4'b0100,
   F=4'b0101,
   G=4'b0110,
   H=4'b0111,
   W=4'b1000,
   K=4'b1001,
   MR=4'b1010,
   LR=4'b1011,
   zero=4'b1100,
   t0=4'b1101,
   t1=4'b1110,
   t2=4'b1111
}reg_t;

typedefenumbit[5:0]{
   ADD=6'b000000,
   ADDI=6'b000001,
   OR=6'b000010,
   AND=6'b000011,
   XOR=6'b000100,
   NOR=6'b000101,
   SLL=6'b000110,
   ROT=6'b000111,
   BNE=6'b001000,
   NOP=6'b001100,
   //
   LDL=6'b100100,
   LDH=6'b100110,
   STL=6'b101000,
   STH=6'b101010,	
   JMP=6'b101100,
   JAL=6'b101001,
   JR=6'b101110,
   JALR=6'b101111

}opcod_t;

class trans;
   bit op_t;
   bit[15:0]inst;
   opcod_topcode;
   rand bit[3:0]imm;
   rand bit[9:0]addr;
   rand reg_trs;
   rand reg_trd;
   rand reg_trt;
   rand opcod_topcod;

   function bit op_type();
      return op_t inside{ADD,ADDI,OR,AND,XOR,NOR,SLL,ROT,BNE,NOP};
   endfunction

   function bit create_trans();
      if(op_t)begin
      inst[3:0]=opcode[3:0];
         if(opcod==ADDI)begin
         inst[4:7]=imm;
         inst[8:11]=rt;
         inst[12:15]=rd;
         end
         else begin
         inst[4:7]=rs;
         inst[8:11]=rt;
         inst[12:15]=rd;
         end
   
      end

      else begin
      inst[5:0]=opcode;
      //questian I can't use opperatoror betwine JR end JARL line abow
         if(opcode==JR/*JARL*/)begin
         inst[6:11]=0;
         inst[12:15]=rs;
         end
         else begin
         inst[6:15]=addr;
         end
      end
      return inst;
   endfunction



   function void print();

      $display("instraction=%0b",inst);

   endfunction

endclass


`endif
