module adder(
        input[9:0] srca, srcb,
        output[9:0] resalt
        )
reg[31:0] local_res;
always@*
begin
    local_res = srca + srcb;
end        
assign resalt = local_res;        
endmodule         
