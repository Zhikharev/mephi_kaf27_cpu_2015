`ifndef CHU_PAD_PACKET
`define CHU_PAD_PACKET

class packet;

	rand bit mes[];
	bit [511:0] ext_mes;
	bit [2:0] alg;
	int num_of_pkt;

	constraint c_mes {
		mes.size() > 0 && mes.size() <= 512 && mes.size() % 8 == 0;
	}

	function new();
	endfunction

	function print();
		$display("Packet : Length of message = %0h", mes.size());
	endfunction

	function void check_of_pkt(packet pkt);
		if (pkt == null)
			$display("Packet : ERROR - packet is null");
		else if (pkt.mes.size() !== this.mes.size())
			$display("Packet : ERROR - size of packet isn't right");
		else
			foreach(mes[i])
				if(pkt.mes[i] !== this.mes[i])
					$display("Packet : ERROR - first_mes[%0d] isn't right", i);
				else
					$display("Packet: packet is OK");	
	endfunction

	function string bit_to_string ();
		return string'(mes);		
	endfunction

	function void padder(); 
		string str, ext_str;
		bit [31:0] ext [64];
		bit [7:0] dop;
		int size_from_sv = mes.size();
		
		str = string'(mes);    
		if (alg == `MD4 || alg == `MD5) begin
        	md5_align(ext, str, size_from_sv);
        	for (int i = 0; i < 64; i++) begin
        		dop = ext[i][7:0];
        		ext_mes = {ext_mes, dop};
       		end
			return;
		end
		else begin
        	sha1_align(ext, str);
        	for (int i = 0; i < 64; i++) begin
        		dop = ext[i][7:0];
        		ext_mes = {ext_mes, dop};
       		end
			return;
		end
	endfunction

endclass

`endif
