`ifndef CHU_PAD_TOP
`define CHU_PAD_TOP

module top();

	bit sys_clk;	

	initial begin
		sys_clk = 1'b0;
		forever #10 sys_clk = ~sys_clk;
	end
		input_interface input_intf(sys_clk);
		output_interface output_intf(sys_clk, input_intf.sys_rst);
		testcase TC(input_intf, output_intf);
		chu_pad DUT(.sys_clk(input_intf.sys_clk),
			.sys_reset(input_intf.sys_rst),
			.eop(input_intf.eop),
			.data(input_intf.data),
			.sop(input_intf.sop),
			.val(input_intf.val),
			.alg(input_intf.alg),
			.w0(output_intf.w[0]),
			.w1(output_intf.w[1]),
			.w2(output_intf.w[2]),
			.w3(output_intf.w[3]),
			.w4(output_intf.w[4]),
			.w5(output_intf.w[5]),
			.w6(output_intf.w[6]),
			.w7(output_intf.w[7]),
			.w8(output_intf.w[8]),
			.w9(output_intf.w[9]),
			.wa(output_intf.w[10]),
			.wb(output_intf.w[11]),
			.wc(output_intf.w[12]),
			.wd(output_intf.w[13]),
			.we(output_intf.w[14]),
			.wf(output_intf.w[15]),
			.w0_val(output_intf.w_val[0]),
			.w1_val(output_intf.w_val[1]),
			.w2_val(output_intf.w_val[2]),
			.w3_val(output_intf.w_val[3]),
			.w4_val(output_intf.w_val[4]),
			.w5_val(output_intf.w_val[5]),
			.w6_val(output_intf.w_val[6]),
			.w7_val(output_intf.w_val[7]),
			.w8_val(output_intf.w_val[8]),
			.w9_val(output_intf.w_val[9]),
			.wa_val(output_intf.w_val[10]),
			.wb_val(output_intf.w_val[11]),
			.wc_val(output_intf.w_val[12]),
			.wd_val(output_intf.w_val[13]),
			.we_val(output_intf.w_val[14]),
			.wf_val(output_intf.w_val[15]),
			.mes_cnt(output_intf.mes_cnt));
endmodule
		

`endif
