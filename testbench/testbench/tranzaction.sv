`ifndef TRANZACTION
`define TRANZACTION

//////////// typedef for  4 felds instractions
///////////
typedef enum bit[3:0] {
        ADD = 4'b0000,
        ADDI =4'b0001,
        OR =  4'b0010,
        AND = 4'b0011,
        XOR = 4'b0100,
        NOR = 4'b0101,
        SLL = 4'b0110,
        ROT = 4'b0111,
        BNE = 4'b1000              
                        }cot_t;
        
/////// typdef for 3 felds instractions 
//////////             
typedef enum bit[5:0]{
        LDL = 6'b100100,
        LDH = 6'b100110,
        STL = 6'b101000,
        STH = 6'b101010,
        JMP = 6'b101100,
        JAD = 6'b101101,
         JR = 6'b101110,
        JARL= 6'b101111

                       }dcot_t;
/////// typedef for registers
////////////                
typedef enum bit[3:0] {
        A = 4'b0000,
        B = 4'b0001,
        C = 4'b0010,
        D = 4'b0011,
        E = 4'b0100,
        F = 4'b0101,
        G = 4'b0110,
        H = 4'b0111,
        W = 4'b1000,
        K = 4'b1001,
        MR= 4'b1010,
        LR= 4'b1011,
      zero= 4'b1100,
       t0 = 4'b1101,
       t1 = 4'b1110,
       t2 = 4'b1111
                      }reg_t;



                                         

class tranz 
        rand bit type_inst;
        rand cop_t cop;
        rand reg_t reg0;
        rand reg_t reg1;
        rand reg_t reg2;
        rand dcod_t dcot;
        
        function new begin
                
                end         
                 
        
        
        end













`endif 
