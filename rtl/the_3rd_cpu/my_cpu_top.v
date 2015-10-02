module cpu_top(
        input[15:0] instr_in,
        output[9:0] addr_instr,
        input[31:0] data_in,
        output[31:0] data_out,
        output[9:0] data_addr,
        input sys_clk,
        input sys_rst
);
module mux4_1 (#parametr WIDTH) (
        input[WIDTH-1:0] a,//upper terminal piked by 00 
        input[WIDTH-1:0] b, //piked by 01
        input[WIDTH-1:0] c,//piked by 10
        input[WIDTH-1:0] d,//piked by 11       
        output[WIDTH-1:0] y,
        input[1:0] s;
);
assign y=s[1]?(s[0]d:c):(s[0]?b:a);
endmodule mux2_1;
module mux2_1 (#paramert WIDTH)(
        input[WIDTH-1:0] a,//picked by o
        input[WIDTH-1:0]b, //picled by 1
        output[WIDTH-1:0]y,
        input s
);
assign y= s?b:a; 
endmodule mux2_1; 
module demux1_2(#parametr WIDTH)(
            input[WIDTH-1:0] y, 
            output[WIDTH-1:0] a,//pickde by 1
            output[WIDTH-1:0] b,//picked by 0
            input s
);
wire[WIDTH-1:0]a_loc;
wire[WIDTH-1:0]b_loc;
if(s) a_loc = a;
else b_loc =b;
assign a = a_loc;
assign b = b_loc;
endmodule demux1_2;
module demux1_4(#parametr WIDTH)(
            input[WIDTH-1;0] y,
            input[1:0] s,
            output[WIDTH-1:0] a,
            output[WIDTH-1:0] b,
            output[WIDTH-1;0] c,
            output[WIDTH-1:0] d
);
wire[WIDTH-1:0] a_loc;
wire[WIDTH-1:0] b_loc;
wire[WIDTH-1:0] c_loc;
wire[WIDTH-1:0] d_loc;
if(s==2'b00) a_loc = a;
if(s==2'b01) b_loc = b;
if(s==2'b10) c_loc = c;
if(s==2'b11) d_loc = d;
assign a = a_loc;
assign b = b_loc;
assign c = c_loc;
assign d = d_loc;
endmodule demux1_4;

wire[31:0] 1_mux2rf;
wire[3:0] 2_demux2rf_1;
wire[3:0] 2_demux2rf_2;
wire[31:0] 3_mux2rf; 
wire[31:0] src2_4_demux;
wire[31:0] rf2_7mux;
register_file RF_U (
    .addr_sourse(1_mux2rf)
    .addr_temp(instr_in[7:4])
    .addr_dest(2_demux2rf_1)
    .addr_wr_dest(2_demux2rf_2),
    .data_in(3_mux2rf),
    .clk(sys_clk),
    .we(we_ctr),//
    .control_rf(rf_ctr),//
    .s_data_out(src2_4_demux),
    .t_data_out(rf2alu_srcb),
    .d_data_out(rf2_7mux)


);


endmodule cpu_top;
