`ifndef CHU_PAD_DRIVER
`define CHU_PAD_DRIVER

class driver;
	
	virtual input_interface vif;
	mailbox #(packet) mb_drv2sb;
	packet gpkt;
	int num;
	bit [31:0] data;
	int k;
	int rand_delay;

	function new (virtual input_interface vif_new, mailbox #(packet) mb_drv2sb);
		this.vif = vif_new;
		gpkt = new();
		if (mb_drv2sb == null) begin
			$display("Driver : ERROR - mailbox is empty");
			$finish;	
		end
		else
			this.mb_drv2sb = mb_drv2sb;
	endfunction

	task start();
			packet pkt_drv;
			bit [64:0] dop;
			num = gpkt.num_of_pkt;
			k = num;
			while (k != 0) begin
				std::randomize(rand_delay) with {rand_delay >=0 && rand_delay < 5;};
				$display("Rand delay = %0d", rand_delay);
				$display("Driver : start of driver");
				$cast(pkt_drv, gpkt);
				pkt_drv.num_of_pkt = num - k;
				if (!pkt_drv.randomize()) begin  
                    $display("ERROR: Randomization failed.%0t", $time);
               		clear_interface();
				end
				else begin
					//pkt_drv.check_of_pkt();
					mb_drv2sb.put(pkt_drv);
					$display("Driver : num of packets = %0d", pkt_drv.num_of_pkt); 
					$display("Driver : msg.size = %0d", pkt_drv.mes.size());
					for (int i = 0; i < pkt_drv.mes.size(); i++)
						dop = {dop, pkt_drv.mes[i]};
					$display("Driver : msg = %0h", dop);
					dop = 64'b0;
					send_transaction(pkt_drv);	
					k--;
				end
				for (int i = 1; i < rand_delay; i++)
					@(posedge vif.sys_clk); 
			end
			@(posedge vif.sys_clk);
	endtask

	task send_transaction(packet item);
		forever begin
			@(posedge vif.sys_clk);
			vif.alg = item.alg;
			vif.sop = 1'b1;
			vif.val = 1'b1;
			vif.eop = 1'b0;
			vif.data = item.mes.size();
			$display("Driver : start send", $time);

			if (item.mes.size() < 33) begin
				@(posedge vif.sys_clk);
				for (int i = 0; i < item.mes.size(); i++)
					data = {data, item.mes[i]};
				$display("Driver: data = %0h", data);
				vif.data = data;
				vif.eop = 1'b1;
				vif.sop = 1'b0;
				@(posedge vif.sys_clk);
				vif.eop = 1'b0;
				vif.val = 1'b0;
				return;
			end
			else begin
				@(posedge vif.sys_clk);
				vif.sop = 1'b0;

				for (int i = 0; i < item.mes.size(); i++) begin
					if ( (i % 32 != 0) || (i == 0) )
						data = {data, item.mes[i]};
					else begin
						vif.data = data;
						$display("Driver: data [%0d] = %0h", i, data);
						data = 32'b0;
						data = {data, item.mes[i]};
						@(posedge vif.sys_clk);
					end
					if (i == item.mes.size() - 1) begin
						vif.data = data;
						$display("Driver: data [%0d] = %0h", i, data);
						vif.eop = 1'b1;
						data = 32'b0;
						@(posedge vif.sys_clk);
						vif.eop = 1'b0;
						vif.val = 1'b0;
						return;
					end
				end
				
				//for (int i = 1; i < r_delay.delay; i++)
					//@(posedge vif.sys_clk); 
			end
		end
	endtask

	task clear_interface();
        vif.val <= 1'b0;
		vif.sop <= 1'b0;
		vif.eop <= 1'b0;
	endtask
	
endclass

`endif
