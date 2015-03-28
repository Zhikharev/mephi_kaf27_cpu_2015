`timescale 1ns / 1ps
`include "defines.v"
module chu_pad(
	input sys_clk,
	input sys_reset,
	input eop,
	input [31:0] data,
	input sop,
	input val,
	input [2:0] alg,
	output [31:0] w0,
	output [31:0] w1,
	output [31:0] w2,
	output [31:0] w3,
	output [31:0] w4,
	output [31:0] w5,
	output [31:0] w6,
	output [31:0] w7,
	output [31:0] w8,
	output [31:0] w9,
	output [31:0] wa,
	output [31:0] wb,
	output [31:0] wc,
	output [31:0] wd,
	output [31:0] we,
	output [31:0] wf,
	output w0_val,
	output w1_val,
	output w2_val,
	output w3_val,
	output w4_val,
	output w5_val,
	output w6_val,
	output w7_val,
	output w8_val,
	output w9_val,
	output wa_val,
	output wb_val,
	output wc_val,
	output wd_val,
	output we_val,
	output wf_val,
	output [7:0] mes_cnt,
	output block
		 );
	reg [5:0] r_reg;
	wire [5:0] r_next;
	reg [31:0] size_reg;
	reg [511:0] word_reg;
	wire [1024:0] shift;
	wire [1023:0] shift1;
	reg [15:0] val_reg;
	reg en;
	wire sec_mess;
	reg [31:0] size_reg_last;
	wire [31:0] w0_loc;
	wire [31:0] w1_loc;
	wire [31:0] w2_loc;
	wire [31:0] w3_loc;
	wire [31:0] w4_loc;
	wire [31:0] w5_loc;
	wire [31:0] w6_loc;
	wire [31:0] w7_loc;
	wire [31:0] w8_loc;
	wire [31:0] w9_loc;
	wire [31:0] w10_loc;
	wire [31:0] w11_loc;
	wire [31:0] w12_loc;
	wire [31:0] w13_loc;
	wire [31:0] w14_loc;
	wire [31:0] w15_loc;
	
	localparam [4:0] idle = 5'b00000,
						  w0_state = 5'b00001,
						  w1_state = 5'b00010,
						  w2_state  = 5'b00011,
						  w3_state  = 5'b00100,
						  w4_state = 5'b00101,
						  w5_state = 5'b00110,
						  w6_state = 5'b00111,
						  w7_state = 5'b01000,
						  w8_state = 5'b01001,
						  w9_state = 5'b01010,
						  w10_state = 5'b01011,
						  w11_state = 5'b01100,
						  w12_state = 5'b01101,
						  w13_state = 5'b01110,
						  w14_state = 5'b01111,
						  w15_state = 5'b10000,
						  w14_15 = 5'b10001;
						  
	reg [4:0] state_reg, state_next;
	
	always @(posedge sys_clk)
		if (sys_reset == 1)
			r_reg <= 0;
		else
			r_reg <= r_next;		
	assign r_next = (sop == 1) ? 6'b0 : r_reg + 6'b000001;
	
	assign sec_mess = (r_reg > 16 | en == 1) ? 1'b1 : 1'b0;
	
	always @(posedge sys_clk, posedge sys_reset)
		if (sys_reset)
			state_reg <= idle;
		else
			state_reg <= state_next;
			
	always @*
		case (state_reg)
			idle: 
				if (sop == 1)
					state_next = w0_state;
				else 
					state_next = idle;
			w0_state:
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w1_state;
			w1_state: 
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w2_state ;
			w2_state : 
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w3_state ;
			w3_state : 
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w4_state;
			w4_state: 
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w5_state;
			w5_state: 
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w6_state;
			w6_state: 
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w7_state;
			w7_state:
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w8_state;
			w8_state:
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w9_state;
			w9_state:
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w10_state;
			w10_state: 
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w11_state;
			w11_state:
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w12_state;
			w12_state:
				if (eop == 1 | val == 0)
					state_next = idle;
				else
					state_next = w13_state;
			w13_state:
				if (eop == 1 & size_reg == 448)
					state_next = w14_15;
				else
					if (eop == 1 | val == 0)
						state_next = idle;
					else
						state_next = w14_state;
			w14_state: 
				if (val == 0)
					state_next = idle;
				else
					if (eop == 1)
						state_next = w14_15;
					else
						state_next = w15_state;
			w15_state:
				if (val == 0)
					state_next = idle;
				else
					if (eop == 1)
						state_next = w14_15;
					else
						state_next = w0_state;
			w14_15: 
				if (val == 0)
					state_next = idle;
				else
					state_next = w0_state;		
		endcase;
											
	assign shift1 = {word_reg[511:0], word_reg[511:0]} >> {1024 - size_reg};
	assign shift = {shift1[1023:0], 1'b1} << {1024 - size_reg};

	always @(posedge sys_clk)
		case (state_reg)
			idle:
				begin
				size_reg = data;
				val_reg = 16'b0000000000000000;
				end
			w0_state: 
				begin 
					word_reg = {data, 480'b0};
					if (eop)
						val_reg = 16'b1111111111111111;
					else
						val_reg = 16'b1000000000000000;
				end
			w1_state: 
				begin 
					word_reg = {word_reg[511:480], data, 448'b0};
					if (eop)
						val_reg = 16'b0111111111111111;
					else
						val_reg = 16'b0100000000000000;
				end
			w2_state : 
				begin 
					word_reg = {word_reg[511:448], data, 416'b0};
					if (eop)
						val_reg = 16'b0011111111111111;
					else
						val_reg = 16'b0010000000000000;
				end
			w3_state : 
				begin 
					word_reg = {word_reg[511:416], data, 384'b0};
					if (eop)
						val_reg = 16'b0001111111111111;
					else
						val_reg = 16'b0001000000000000;
				end
			w4_state: 
				begin 
					word_reg = {word_reg[511:384], data, 352'b0};
					if (eop)
						val_reg = 16'b0000111111111111;
					val_reg = 16'b0000100000000000;
				end
			w5_state: 
				begin 
					word_reg = {word_reg[511:352], data, 320'b0};
					if (eop)
						val_reg = 16'b0000011111111111;
					else
						val_reg = 16'b0000010000000000;
				end
			w6_state: 
				begin 
					word_reg = {word_reg[511:320], data, 288'b0};
					if (eop)
						val_reg = 16'b0000001111111111;
					else
						val_reg = 16'b0000001000000000;
				end
			w7_state: 
				begin 
					word_reg = {word_reg[511:288], data, 256'b0};
					if (eop)
						val_reg = 16'b0000000111111111;
						else
						val_reg = 16'b0000000100000000;
				end
			w8_state: 
				begin 
					word_reg = {word_reg[511:256], data, 224'b0};
					if (eop)
						val_reg = 16'b0000000011111111;
					else
						val_reg = 16'b0000000010000000;
				end
			w9_state: 
				begin 
					word_reg = {word_reg[511:224], data, 192'b0};
					if (eop)
						val_reg = 16'b0000000001111111;
					else
						val_reg = 16'b0000000001000000;
				end
			w10_state: 
				begin 
					word_reg = {word_reg[511:192], data, 160'b0};
					if (eop)
						val_reg = 16'b0000000000111111;
					else
						val_reg = 16'b0000000000100000;
				end
			w11_state: 
				begin 
					word_reg = {word_reg[511:160], data, 128'b0};
					if (eop)
						val_reg = 16'b0000000000011111;
					else
						val_reg = 16'b0000000000010000;
				end
			w12_state: 
				begin 
					word_reg = {word_reg[511:128], data, 96'b0};
					if (eop)
						val_reg = 16'b0000000000001111;
					else
						val_reg = 16'b0000000000001000;
				end
			w13_state: 
				begin 
					word_reg = {word_reg[511:96], data, 64'b0};
					if (eop)
						val_reg = 16'b0000000000000111;
					else
						val_reg = 16'b0000000000000100;
				end
			w14_state: 
				begin 
					word_reg = {word_reg[511:64], data, 32'b0};
					if (eop)
						val_reg = 16'b0000000000000011;
					else
						val_reg = 16'b0000000000000010;
				end
			w15_state: 
				begin 
					word_reg = {word_reg[511:32], data};
						val_reg = 16'b0000000000000001;
				end
			w14_15:
				begin
					val_reg = 16'b1111111111111111;
				end
		endcase;
		
	always @(posedge sys_clk)
		if (state_reg == w14_15)
			en <= 1;
		else
			en <= 0;
			
	always @(posedge sys_clk)
		if (sys_reset)
			size_reg_last <= 0;
		else
			size_reg_last <= size_reg;
	
	assign mes_cnt = state_reg;
	
	assign w0_loc = (sec_mess == 0) ? shift[1024:993] : shift[512:481];	
	assign w1_loc = (sec_mess == 0) ? shift[992:961] : shift[480:449];	
	assign w2_loc = (sec_mess == 0) ? shift[960:929] : shift[448:417];
	assign w3_loc = (sec_mess == 0) ? shift[928:897] : shift[416:385];
	assign w4_loc = (sec_mess == 0) ? shift[896:865] : shift[384:353]; 
	assign w5_loc = (sec_mess == 0) ? shift[864:833] : shift[352:321]; 
	assign w6_loc = (sec_mess == 0) ? shift[832:801] : shift[320:289]; 
	assign w7_loc = (sec_mess == 0) ? shift[800:769] : shift[288:257]; 
	assign w8_loc = (sec_mess == 0) ? shift[768:737] : shift[256:225]; 
	assign w9_loc = (sec_mess == 0) ? shift[736:705] : shift[224:193];
	assign w10_loc = (sec_mess == 0) ? shift[704:673] : shift[192:161]; 
	assign w11_loc = (sec_mess == 0) ? shift[672:641] : shift[160:129]; 
	assign w12_loc = (sec_mess == 0) ? shift[640:609] : shift[128:97]; 
	assign w13_loc = (sec_mess == 0) ? shift[608:577] : shift[96:65]; 
	assign w14_loc = (sec_mess == 0) ? shift[576:545] : shift[64:33];
	assign w15_loc = (eop == 1 & state_reg != w14_15 | en == 1) ? size_reg_last : shift[544:513];
	
	assign w0 = (alg == `MD4 | alg == `MD5) ? {w0_loc[7:0], w0_loc[15:8], w0_loc[23:16], w0_loc[31:24]} : w0_loc;
	assign w1 = (alg == `MD4 | alg == `MD5) ? {w1_loc[7:0], w1_loc[15:8], w1_loc[23:16], w1_loc[31:24]} : w1_loc;
	assign w2 = (alg == `MD4 | alg == `MD5) ? {w2_loc[7:0], w2_loc[15:8], w2_loc[23:16], w2_loc[31:24]} : w2_loc;
	assign w3 = (alg == `MD4 | alg == `MD5) ? {w3_loc[7:0], w3_loc[15:8], w3_loc[23:16], w3_loc[31:24]} : w3_loc;
	assign w4 = (alg == `MD4 | alg == `MD5) ? {w4_loc[7:0], w4_loc[15:8], w4_loc[23:16], w4_loc[31:24]} : w4_loc;
	assign w5 = (alg == `MD4 | alg == `MD5) ? {w5_loc[7:0], w5_loc[15:8], w5_loc[23:16], w5_loc[31:24]} : w5_loc; 
	assign w6 = (alg == `MD4 | alg == `MD5) ? {w6_loc[7:0], w6_loc[15:8], w6_loc[23:16], w6_loc[31:24]} : w6_loc;
	assign w7 = (alg == `MD4 | alg == `MD5) ? {w7_loc[7:0], w7_loc[15:8], w7_loc[23:16], w7_loc[31:24]} : w7_loc;
	assign w8 = (alg == `MD4 | alg == `MD5) ? {w8_loc[7:0], w8_loc[15:8], w8_loc[23:16], w8_loc[31:24]} : w8_loc;
	assign w9 = (alg == `MD4 | alg == `MD5) ? {w9_loc[7:0], w9_loc[15:8], w9_loc[23:16], w9_loc[31:24]} : w9_loc;
	assign wa = (alg == `MD4 | alg == `MD5) ? {w10_loc[7:0], w10_loc[15:8], w10_loc[23:16], w10_loc[31:24]} : w10_loc;
	assign wb = (alg == `MD4 | alg == `MD5) ? {w11_loc[7:0], w11_loc[15:8], w11_loc[23:16], w11_loc[31:24]} : w11_loc;
	assign wc = (alg == `MD4 | alg == `MD5) ? {w12_loc[7:0], w12_loc[15:8], w12_loc[23:16], w12_loc[31:24]} : w12_loc;
	assign wd = (alg == `MD4 | alg == `MD5) ? {w13_loc[7:0], w13_loc[15:8], w13_loc[23:16], w13_loc[31:24]} : w13_loc;
	assign we = (alg == `MD4 | alg == `MD5) ? ((eop == 1 & state_reg != w14_15 | en == 1) ? w15_loc : {w14_loc[7:0], w14_loc[15:8], w14_loc[23:16], w14_loc[31:24]}) : w14_loc;
	assign wf = (alg == `MD4 | alg == `MD5) ? ((eop == 1 & state_reg != w14_15 | en == 1) ? w14_loc : {w15_loc[7:0], w15_loc[15:8], w15_loc[23:16], w15_loc[31:24]}) : w15_loc;
	
	assign w0_val = val_reg[15];
	assign w1_val = val_reg[14];
	assign w2_val = val_reg[13];
	assign w3_val = val_reg[12];
	assign w4_val = val_reg[11];
	assign w5_val = val_reg[10];
	assign w6_val = val_reg[9];
	assign w7_val = val_reg[8];
	assign w8_val = val_reg[7];
	assign w9_val = val_reg[6];
	assign wa_val = val_reg[5];
	assign wb_val = val_reg[4];
	assign wc_val = val_reg[3];
	assign wd_val = val_reg[2];
	assign we_val = val_reg[1];
	assign wf_val = val_reg[0];
	
	assign block = sec_mess;
	
endmodule
