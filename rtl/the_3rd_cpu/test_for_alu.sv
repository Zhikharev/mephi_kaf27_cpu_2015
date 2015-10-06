module alu_test;

    logic[31:0] resalt;
    logic zero_flag;
    rand logic[31:0] srca,srcb;
    
    alu uut (
        .resalt(resalt),
        .srca(srca),
        .srcb(srcb),
        .zero_flag(zero_flag),
        .controll(controll)
    );
    
    initial begin
        $display("START TEST FOR ADD");
        controll = 3'b0;//ADD
        for(i=0;i<20;i=i+1;)begin
            assert (resalt == (srca + srsb)) else $error("ADD error %d, op %d = %d (%b op %b = %b) ",scra, srsb,resalt,scra, srsb,resalt);
        end
        $display("START TEST FOR OR");
        controll = 3'b001;//OR
        for(i=0;i<20;i=i+1;)begin
            assert (resalt == (srca|srsb)) else $error("OR error %d, op %d = %d (%b op %b = %b) ",scra, srsb,resalt,scra, srsb,resalt);
        end
        $display("START TEST FOR AND");
        controll = 3'b010;//AND
        for(i=0;i<20;i=i+1;)begin
            assert (resalt == (srca&srsb)) else $error("AND error %d, op %d = %d (%b op %b = %b) ",scra, srsb,resalt,scra, srsb,resalt);
        end
        $display("START TEST FOR XOR");
        controll = 3'b011;//XOR
        for(i=0;i<20;i=i+1;)begin
            assert (resalt == (srca^srsb)) else $error("XOR error %d, op %d = %d (%b op %b = %b) ",scra, srsb,resalt,scra, srsb,resalt);
        end
        $display("START TEST FOR NOR");
        controll = 3'b100;//NOR
        for(i=0;i<20;i=i+1;)begin
            assert (resalt == ~(srca|srsb)) else $error("NOR error %d, op %d = %d (%b op %b = %b) ",scra, srsb,resalt,scra, srsb,resalt);
        end
        $display("START TEST FOR SLL");
        controll = 3'b101;//SLL
        for(i=0;i<20;i=i+1;)begin
            assert (resalt == (srca<<srsb)) else $error("SLL error %d, op %d = %d (%b op %b = %b) ",scra, srsb,resalt,scra, srsb,resalt);
        end
        $display("START TEST FOR ROT");
        controll = 3'b110;//ROT
        for(i=0;i<20;i=i+1;)begin
            assert (resalt == (srca << srcb) | (srca >> srcb)) else $error("ADD error %d, op %d = %d (%b op %b = %b) ",scra, srsb,resalt,scra, srsb,resalt);
        end
        $display("START TEST FOR SUB");
        controll = 3'b111//SUB
        for(i=0:i<20;i=i+1;)begin
            assert (resatl == (srca - srcb))  else $error ("SUB error %d, op %d = %d (%b op %b = %b) ",scra, srsb,resalt,scra, srsb,resalt);
        end
    
    end;
