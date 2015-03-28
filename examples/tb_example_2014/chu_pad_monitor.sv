`ifndef CHU_PAD_MONITOR
`define CHU_PAD_MONITOR

class monitor;
	
	virtual output_interface vif; 
	virtual input_interface in_vif;
	mailbox #(packet) mb_mon2sb;
	packet pkt;
	bit long_word[];

	function new(virtual output_interface vif_new, virtual input_interface in_vif_new, mailbox #(packet) mb_mon2sb);
		this.vif = vif_new;
		this.in_vif = in_vif_new;
		if (mb_mon2sb == null) begin
			$display("Monitor : Error - mailbox mb_mon2sb is empty");
			$finish;
		end
		else
			this.mb_mon2sb = mb_mon2sb;
	endfunction

	task start();
		$display("Monitor : start of monitor. %0t", $time);
		forever begin 
			if ((!vif.sys_rst) && in_vif.mon.sop) begin
				pkt = new();
				make_transaction(pkt);
				send_transaction(pkt);
			end
			@ (posedge vif.sys_clk);
		end
	endtask

	task make_transaction(packet pkt);
		bit [31:0] word;
		pkt.ext_mes = 512'b0;
		$display("Monitor : start make transaction. %0t", $time); 

		for (int i = 0; i < 16; i++) begin
			@(posedge vif.sys_clk);
			if (vif.mon.w_val[i] && in_vif.mon.eop != 1) begin
				word = vif.mon.w[i];
				$display("Monitor : start make transaction. %0t", $time); 
				pkt.ext_mes = {pkt.ext_mes, word};
				word = 32'b0;	
			end
			else begin
				for (int j = i; j < 16; j++) begin
					word = vif.mon.w[j];
					pkt.ext_mes = {pkt.ext_mes, word};
				end	
				return;
			end
		end			
	endtask
	
	task send_transaction(packet pkt);
    		mb_mon2sb.put(pkt);
  	endtask

endclass

`endif
