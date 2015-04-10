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
        logic pak[15:0];
        logic imm [3:0];
        logic type_inst[3:0];  
        logic addr[9:0];
        /////////////////
        ////random chouse type instraction
        /////////////////
        rand  type_inst;
        rand imm; 
        rand addr;    
        
        rand cop_t cop;
        rand reg_t reg0; ///rs
        rand reg_t reg1; ///rt 
        rand reg_t reg2; ///rd
        constraint reg2,reg1 {        
                reg2 != 4'b1100;
        }
        rand dcod_t dcot;
        
        function new begin
                
                end         
                 
       
            
       if (tupe_inst[2] & tupe_inst[0]) begin
                //////// the 1st kind of instraction
                pak[3:0] = cop;
                if(cop == 4'b0011) begin
                        ////////// the 1st type with immidiate
                        pak[4:7] = imm;
                        pak[8:11] = reg1;
                        pak[12:15] = reg2;
                                        
                end
                else begin
                        /////////// the 2nd type with 3 registers
                        
                        pak[4:7] =reg0;
                        pak[8:11] = reg1;
                        pak[12:15] = reg2;
                
                
                end 
                
      end
      else begin
      /////// jump with rs
         if((dcot == 6'b101110) or (dcot == 6'b1011111)) begin
                
                pak[3:0] = dcot;
                pak[11:4] = 0;
                pak[15:12] = reg0;
         end
         else begin
         ////// jump with imm
                pak[3:0] = dcot;
                pak[15:4] = addr;
         end
        
      
      end

   function print (pak) begin
        $display(pak,/n);        
   
   end
endclass


`endif 
