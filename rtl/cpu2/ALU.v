/*
###########################################################
#
# Author: Gerasimchuk Aleksey
#
# Project: MEPHI CPU
# Filename: ALU.v
# Descriptions:
#   
###########################################################
*/
module ALU(
    input [31:0] srca,
    input [31:0] srcb,
    input  [2:0] alucontrol,
    output [31:0] aluresult,
    output zero
    );

reg zero_reg;
reg [31:0] aluresult_reg;

always @*
begin
    case (alucontrol)
        3'b000 : aluresult_reg = srca + srcb;   // сложение
        3'b001 : aluresult_reg = srca | srcb; // побитовое ИЛИ
        3'b010 : aluresult_reg = srca & srcb; // побитовое И
        3'b011 : aluresult_reg = srca ^ srcb; // побитовое ИСКЛ ИЛИ
        3'b100 : aluresult_reg = ~(srca | srcb); // побитовое ИЛИ НЕ
        3'b101 : aluresult_reg = srca << shift; //  логический сдвиг влево
        3'b110 : aluresult_reg = (srca << shift) | (srca >> shift); // цикличекий сдвиг влево
        3'b111 : 
            begin
                aluresult_reg = srca - srcb;
                if (aluresult_reg == 0)
                    zero_reg = 1;
                else
                    zero_reg = 0;
            end
        default : aluresult_reg = 0;        
    endcase  
end

assign aluresult = aluresult_reg;
assign zero = zero_reg;
endmodule
