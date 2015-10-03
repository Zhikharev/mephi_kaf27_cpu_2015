module cpu_top (
    input[31:0]instr,
    input[31:0]data_in,
    output[31:0]data_addr,
    output[31:0]data_out,
    output stb_out
);

module demux4_1 (#parametr WIDTH)
            (
                output[WIDTH-1:0] a,
                output[WIDTH-1:0] b,
                output[WIDTH-1:0] c,
                output[WIDTH-1:0] d,
                input[1:0] s,
                input[WIDTH-1:0] y 
              );
reg[WIDTH-1:0]loc_a,
reg[WIDTH-1:0]loc_b,
reg[WIDTH-1:0]loc_c,
reg[WIDTH-1:0]loc_d,
always@*
begin
    case(s)
        00:begin
            loc_a = a;
        end
        01:begin
            loc_b =b;
        end    
        10:begin
            loc_c =c;
        end
        
        11:begin
            loc_d =d;
        end
    
    endcase
end
assign a=loc_a;
assign b=loc_b;
assign c=loc_c;
assign d=loc_d;
endmodule demux4_1;


module demux2_1 (#parametr WIDTH)
        (
            output[WIDTH-1:0] a,
            output[WIDTH-1:0] b,
            input s,
            input[WIDTH-1:0] y         
        
        );
reg[WIDTH-1:0] loc_a;
reg[WIDTH-1:0] loc_b;
always@*
begin   
    if(s) loc_b = b
    else loc_a = a; 
end
assign a = loc_a;
assign b = loc_b;
endmodule demux2_1;

//wire from controll unit will be allone sighn form Caps Lock 

wire A_C_CTR;
wire WE_RF;
wire JARL_CTR;
wire[1:0] SRC_CTR;
wire IMM_CTR;
wire[2:0] ALU_CTR;
wire BRCH_CNT;
wire WE_MEM;
wire GLB_BCH;
wire[1:0] PC_CTR;
wire[1:0] RF_CTR;
wire DATA_CTR;
///
//// wires from and to register file 
wire[31:0] rf(s)_2_4demux;
wire[31:0] rf_t_2_alu(b);
wire[31:0] rf(d)_2_7mux;

wire[3:0]1mux_2_rf(s);
wire[3:0]2dmux(a)_2_rf(addr_dest);
wire[3:0]2dmux(b)_2_rf(addr_wr_dest);
wire[31:0]3mux_2_rf(data_in);

///// wires form andto alu
wire[31:0]5mux_2_alu(a);
wire[31:0]alu_2_6mux(b);
wire zf_2_nor;
//////
///// athers wires 
wire[31:0]4demux(c)_2_8mux(c);
wire[31:0]6mux_2_3mux(b); 
wire[31:0]adder_2_3mux(a);
wire[31:0]4demux(b)_2_5mux(a);
wire[31:0]7mux_2_adder;
wire[31:0]8demux_2_pc;
wire[31:0] loc_addr_instr;
control_cpu control_cpu(
    .opcode(instr[15:12]),
    .mem_opcode(instr[11:10]),
    .pc_ctr(PC_CTR),
    .a_c_ctr(A_C_CTR),
    .rf_ctr(RF_CTR),
    .we(WE_CTR),
    .jarl_ctr(JARL_CTR),
    .src_ctr(SRC_CTR),
    .imm_ctr(IMM_CTR),
    .alu_ctr(ALU_CTR),
    .brch_ctr(BRCH_CTR),
    .we_mem(stb_out),
    .data_ctr(DATA_CTR)
);
register_file regiser_file (
     .addr_sorce(1mux_2_rf(s)),
     .addr_temp(instr[7:4]),
     .addr_dest(2dmux(a)_2_rf(addr_deat)),
     .addr_wr_dest(2dmux(b)_2_rf(addr_we_dest)),
     .data_in(3mux_2_rf(data_in)),
     .clk(sys_clk),
     .reset(sys_reset),
     .control_rf(RF_CTR),
     .s_data_out(rf(s)_2_4demux),
     .t_data_out(rf(t)_2_alu(b)),
     .d_data_out(rf9(d)_2_7mux)   
);

denux4_1 4demux(
     #WIDTH = 32;
    .y(rf(s)_2_4demux),
    .a(data_out),
    .b(4demux(b)_2_5mux(a)),
    .c(4demux(c)_2_8mux(c)),
    .s(SRC_CTR),
    .d()
);
assign 5mux_2_alu(a) = IMM_CTR ?instr[11:8]:4demux_2_5mux(a);///5mux

alu alu(
    .srca(5mux_2_alu(a)),
    .srcb(rf(t)_2_alu(b)),
    .resalt(alu(res)_2_6mux(b)),
    .control(ALU_CTR),
    .zero_flag(zf_2_nor)
);
assign GLB_BRCH = ~(BRCH_CTR | zf_2_nor);//not next to alu
assign 6mux_2_3mux(b) = DATA_CTR ? alu(res)_2_6mux(b):data_in ;//6mux  
assign 3mux_2_rf(data_in) = JARL_CTR ? 6mux(y)_2_3mux(b) : adder_2_3mux(a);//3mux
assign 1mux_2_rf(s) = A_C_CTR ? instr[7:4] : instr[11:8]; //1mux
demux2_1 demux2 (
    #WIDTH =4; 
    .y(instr[3:0]),
    .a(2demux(a)_2_rf(dest)),
    .b(2demux(b)_2_rf(addr_wr_dest)),
    .s(GLB_BRCH)
);
assign 7mux_2_adder = GLB_BRCH ? rf(d)_2_7mux : 32'b10; //7mux 
assign adder_2_3mux(a) = loc_addr_instr + 7mux_2_adder; //adder
assign 8mux_2_pc = PC_CTR[1]?(PC_CTR[0]?instr[9:0]:4demux(c)_2_8mux(c)):(PC_CTR[0]?adder_2_3mux(a):loc_addr_instr);//8mux
assign addr_instr = loc_addr_instr;
pc pc(
    .clk(sys_clk),
    .reset(sys_reset),
    
) 

 
endmodule cpu_top;
