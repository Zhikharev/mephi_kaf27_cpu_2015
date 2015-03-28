`ifndef CHU_PAD_TESTCASE
`define CHU_PAD_TESTCASE

class small_packet extends packet;
	constraint s_constr {
		mes.size() < 64;
	}
endclass

class mini_packet extends packet;
	constraint s_constr {
		mes.size() < 32;
	}
endclass

class big_packet extends packet;
	constraint s_constr {
		mes.size() > 128;
	}
endclass

program testcase (input_interface input_intf, output_interface output_intf);

	environment env;
	small_packet spkt;
	mini_packet mpkt;
	big_packet bpkt;
	string testType;
	string algType;
	bit [2:0] a;
	int num;
	int rand_num;

	initial begin
		$display("Testcase : start of testcase. %0t", $time);

		// Get amount of packets
		if ($value$plusargs("packets_amount=%d",num))
			$display("Testcase : We have %0d packets",num);
		else begin
			std::randomize(rand_num) with {rand_num < 10;};
			num = rand_num;
			$display("Testcase : We have %0d packets",num);
		end

		// Get type of algorithm
		if ($value$plusargs("alg=%s", algType))
			case(1)
				(algType == "MD5"): a = `MD5;
				(algType == "MD4"): a = `MD4;
				(algType == "SHA1"): a = `SHA1;
				(algType == "SHA256"): a = `SHA256;
			endcase
		else
			a = `SHA1;

		// Get type of test
		if ($value$plusargs("test_type=%s", testType)) begin
			case (1)
				(testType == "small_TC"): begin
					spkt = new();
					spkt.alg = a;
					spkt.num_of_pkt = num;
					env = new(input_intf, output_intf);
					env.build();
					env.drv.gpkt = spkt;
				end
				(testType == "mini_TC"): begin
					mpkt = new();
					mpkt.alg = a;
					mpkt.num_of_pkt = num;
					env = new(input_intf, output_intf);
					env.build();
					env.drv.gpkt = mpkt;
				end	
				(testType == "big_TC"): begin
					bpkt = new();
					bpkt.alg = a;
					bpkt.num_of_pkt = num;
					env = new(input_intf, output_intf);
					env.build();
					env.drv.gpkt = bpkt;
				end
			endcase
		end
		else begin
			spkt = new();
			spkt.alg = a;
			spkt.num_of_pkt = num;
			env = new(input_intf, output_intf);
			env.build();
			env.drv.gpkt = spkt;
		end

		// Run test
		env.run();
		#1000;
		$display("Testcase : end of testcase. %0t", $time);
	end
endprogram

`endif

