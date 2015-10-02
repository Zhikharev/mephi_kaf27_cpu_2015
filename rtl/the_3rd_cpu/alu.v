3
module alu(
    input[31:0] srca,
    input[31:0] srcb,
    input[3:0] shift,
    input[2:0] control,
    output[31:0] resalt,
    output zero_flag

    );
localparam ADD = 3'b000;
localparam OR = 3'b001;
localparam AND = 3'b010;
localparam XOR = 3'b011;
localparam NOR = 3'b100;
localparam SLL = 3'b101;
localparam ROT = 3'b110;
localparam SUB = 3'b111;
reg[31:0] local_resalt;
reg local_flag;
always @*
begin
    case(control)
        ADD:begin
            local_resalt = srca + srcb;
            local_flag = 1'b0;    
        end
        OR:begin
            local_resalt = srca | srcb;
            local_falg = 1'b0;
        end
        AND:begin
            local_resalt = srca & srcb;
            local_flag =1'b0;
        end
        XOR:begin
            local_resalt = srca ^ srcb;
            local_flag =1'b0;
        end
        NOR:begin
            local_resalt = ~(srca|srcb);
            local_flag =1'b0;
        end
        
        SLL:begin
            local_resalt = srca << shift;
            local_flag =1'b0;
        end
        ROT:begin
            local_resalt = (srca << shift) | (srca >> shift);
            local_flag =1'b0;
        end
        SUB:begin
            local_resalt = srca - srcb;
            if(local_resalt == 32'b0) local_flag = 1'b1;
            else local_flag =1'b0;
        end
        
        default: local_resalt = 32'b0;
    endcase
end

        
endmodule
