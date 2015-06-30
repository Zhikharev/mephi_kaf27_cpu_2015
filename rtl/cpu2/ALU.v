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
    input [3:0] shift,
    output [31:0] aluresult,
    output zero
    );

reg zero_reg;
reg [31:0] aluresult_reg;

always @*
begin
    case (alucontrol)
        3'b000 : 
            begin
                aluresult_reg = srca + srcb; // сложение (сложение с константой)
                zero_reg = 1'b0;
            end
        3'b001 : 
            begin
                aluresult_reg = srca | srcb; // побитовое ИЛИ
                zero_reg = 1'b0;
            end
        3'b010 : 
            begin
                aluresult_reg = srca & srcb; // побитовое И
                zero_reg = 1'b0;
            end
        3'b011 : 
            begin
                aluresult_reg = srca ^ srcb; // побитовое ИСКЛ ИЛИ
                zero_reg = 1'b0;
            end
        3'b100 : 
            begin
                aluresult_reg = ~(srca | srcb); // побитовое ИЛИ НЕ
                zero_reg = 1'b0;
            end
        3'b101 : 
            begin
                aluresult_reg = srca << shift; // логический сдвиг влево
                zero_reg = 1'b0;
            end
        3'b110 : 
            begin
                aluresult_reg = (srca << shift) | (srca >> shift); // цикличекий сдвиг влево
                zero_reg = 1'b0;
            end
        3'b111 : 
            begin
                aluresult_reg = srca - srcb;
                if (aluresult_reg == 32'b0)
                    zero_reg = 1'b1;
                else
                    zero_reg = 1'b0;
            end
        default : aluresult_reg = 32'b0;        
    endcase  
end

assign aluresult = aluresult_reg;
assign zero = zero_reg;
endmodule
