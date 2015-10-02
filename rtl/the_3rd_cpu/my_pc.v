module pc (
    input[9:0] pc_in,
    input reset,
    input clk,
    output[9:0] pc_out
    
        );
        
reg[9:0] pc;
always (posedge clk, posedge reset)
begin
    if(reset) begin
        pc <= 10'b0
    end
    else pc <= pc_in;
end        
assign pc_out = pc;        
endmodule
