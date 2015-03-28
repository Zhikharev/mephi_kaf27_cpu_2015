`ifndef CHU_PAD_SCOREBOARD
`define CHU_PAD_SCOREBOARD

class scoreboard;

	mailbox #(packet) mb_drv2sb;
	mailbox #(packet) mb_mon2sb;
	bit [511:0] ext_queue[$]; // очередь для расширенных сообщений от драйвера
	bit [511:0] ext_from_drv;
	packet pkt_spare; //временный пакет для извлечения туда инф. из мэйлбокса
	packet from_mntr;
	int err = 0;

	function new(mailbox #(packet) mb_drv2sb,mailbox #(packet) mb_mon2sb);
  		this.mb_drv2sb = mb_drv2sb;
  		this.mb_mon2sb = mb_mon2sb;
	endfunction

//****************Get packet from driver**********************
	task write_drv();
		forever begin
			$display("Scoreboard : get packet from driver");
			mb_drv2sb.get(pkt_spare);
			pkt_spare.padder();
			ext_queue.push_back(pkt_spare.ext_mes);
		end	
	endtask

//**************Get packet from monitor**********************
	task write_mntr();
		forever begin
			$display("Scoreboard : get packet from monitor");
    		mb_mon2sb.get(from_mntr);
			$display("Scoreboard : External message from monitor is %h", from_mntr.ext_mes);
			if (ext_queue.size()) begin
				ext_from_drv = ext_queue.pop_front();
				$display("Scoreboard : External message from driver is %h", ext_from_drv);
				if (from_mntr.ext_mes == ext_from_drv)
					$display("Packets matched", $time);
				else begin
					$display("Packets DID NOT matche", $time);
					err++;
				end
				ext_from_drv = 511'b0;
			end
			else
				return;	
		end
	endtask

//****************Check***************************
	task start();
		$display("Scoreboard : start of scoreboard. %0t", $time);
		fork
		write_drv();
		write_mntr();
		join
	endtask

	task report();
		if (err) begin
			$display("//////////////////////////////////////////");
			$display(" ");
			$display(" ");
			$display("        %0d TESTS FAILED", err);
			$display(" ");
			$display(" ");
			$display("//////////////////////////////////////////");
		end
		else begin
			$display("********************************************");
			$display(" ");
			$display(" ");
			$display("ALL TESTS PASSED");
			$display(" ");
			$display(" ");
			$display("********************************************");
		end
	endtask

endclass

`endif


