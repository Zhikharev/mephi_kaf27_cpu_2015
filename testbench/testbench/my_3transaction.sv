`ifndef MY_3TRANSACTION
`define MY_3TRANSACTION

class trans;
typedef enum bit[3:0] {A,B,C,D,E,F,G,H,W,K,MR,LR,ZERO,t0,t1,t2} reg_t;
typedef enum bit[3:0] {ADD,ADDI,OR,AND,XOR,NOR,SLL,ROT,BNE,NOP = 4'b1100} r_opcode_t;
typedef enum bit[5:0] {
    LDL = 6'b100100,
    LDH = 6'b100110,
    STL = 6'b101000,
    STH = 6'b101010,
    JMP = 6'b101100,
    JAL = 6'b101101,
    JR = 6'b101110,
    JALR = 6'b101111
} m_opcode_t;  

    rand bit[9:0]addr;
    rand bit select;
    rand r_opcode_t r_opcode;
    rand m_opcode_t m_opcode;
    rand bit[3:0]   imm;
    rand reg_t rs;
    rand reg_t rt;
    rand reg_t rd;
    bit[15:0] instr;
    ////for decode 
    string title;
    r_opcode_t d_r_opcode;
    m_opcode_t d_m_opcode;
    reg_t d_rs;
    reg_t d_rt;
    reg_t d_rd;
    bit[9:0] d_addr;
    bit[3:0] d_imm;
    
    function bit[15:0] pack ();
       // bit[15:0]instr;
        if(select)begin
            instr[15:10] = m_opcode;
            if(m_opcode inside{JR,JALR})begin
                instr[8:0] =0;
                instr[7:4] =rs;
            end
            else begin
                instr[9:0] = addr;
            end
        end
        else begin
            if(r_opcode inside{ADDI})begin
                instr[15:12] = r_opcode;
                instr[11:8] = imm;
                instr[7:4] = rt;
                instr[3:0] = rd;
            end
            else begin
                instr[15:12] = r_opcode;
                instr[11:8] = rs;
                instr[7:4] = rt;
                instr[3:0] = rd;
            end
        end
        $display("FROM PACK METHOD -------- instraction is %0b ",instr);
        $display("FROM PACK METHOD -------- select(%0b),opcode( m_%0b r_%0b),imm(%0b),rs(%0b),rt(%0b),rd(%0b)",select,m_opcode,r_opcode,imm,rs,rt,rd);
        //return instr;
    endfunction
    
        
    function print();
    $display("DOESNT WORK BUt %0b",instr);
    endfunction
    
    
    function decode (bit[15:0] instr);
    $display("DOESNT WORK");
    endfunction


    function d_print ();
    $display("DOESNT WORK");
    endfunction        

endclass

`endif
