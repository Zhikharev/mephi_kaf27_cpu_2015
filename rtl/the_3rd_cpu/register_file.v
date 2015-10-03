/*
####################



###################
*/

module register_file (
    input[4:0] addr_source,
    input[4:0] addr_temp,
    input[4:0] addr_dest,
    input[4:0] addr_wr_dest,
    input [31:0] data_in,
    input clk,
    input we,
    input[1:0] control_rf,
    output [31:0] s_data_out,
    output [31:0] t_data_out,
    output [31:0] d_data_out

        );
reg [31:0]rf[0:15];
integer i;
always @(posedge clk,posedge reset)
begin
    if(reset == 1) begin
       for(i=0; i<16; i=i+1)begin
        rf[i]<=0;
       end 
    end
    else
        if(we==1)begin
            if(control_rf == 0) rf[addr_wr_dest]<=data_in;
            if(control_rf == 2'b01) rf[2'd10][31:16] <= data_in[31:16];
            if(control_rf == 2'b10) rf[2'd10][15:0] <=data_in[15:0];
            if(control_rf == 2'b11) rf[2'd11] <= data_in; 
        end
        else begin
        end
end
assign s_data_out = rf[addr_source];
assign t_data_out = rf[addr_temp];
assign d_data_out = rf[addr_dest];

endmodule
