module test_control_cpu ();

    logic[3:0] op_code;
    logic[1:0] mem_opcode;
    logic a_c_ctr;
    logic we_crt,
    logic[1:0] pc_ctr,
    logic jalr_ctr,
    logic[1:0] rf_ctr,
    logic brch_ctr,
    logic[1:0] src_ctr, 
    logic imm_ctr
    logic[2:0] alu_ctr;
    logic data_ctr;
    logic we_mem_ctr;

localparam ADD = 4'b0000;
localparam ADDI =4'b0001;
localparam OR =  4'b0010;
localparam AND = 4'b0011;
localparam XOR = 4'b0100;
localparam NOR = 4'b0101;
localparam SLL = 4'b0110;
localparam ROT = 4'b0111;
localparam BNE = 4'b1000;
localparam NOP = 4'b1100;

localparam LD = 4'b1001;
localparam ST = 4'b1010;
localparam JMP= 4'b1011;

 controll_cpu uut (
    .op_code(op_code);
    .mem_opcode(mem_opcode);
    .a_c_ctr(a_c_ctr);
    .we_crt(we_ctr),
    .pc_ctr(pc_ctr),
    .jalr_ctr(jalr_ctr),
    .rf_ctr(rf_ctr),
    .brch_ctr(brnh_ctr),
    .src_ctr(src_ctr), 
    .imm_ctr(imm_ctr)
    .alu_ctr(alu_ctr);
    .data_ctr(data_ctr);
    .we_mem_ctr(we_mem_ctr);
    );

initial begin
    $display("_________ADD__________");
    opcode = ADD;
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    #1
    opcode = ADDI;
    $display("________ADDI__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    #1
    opcode = OR;
    $display("________OR__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    #1
    opcode = AND;
    $display("________AND__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
        
    #1
    opcode = XOR;
    $display("________ADDI__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    
    #1
    opcode = NOR;
    $display("________NOR__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    
    #1
    opcode = SLL;
    $display("________SLL__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    
    #1
    opcode = ROT;
    $display("________ROT__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    
    #1
    opcode = BNE;
    $display("________BNE__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    
    #1
    opcode = NOP;
    $display("________NOP__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    
    #1
    opcode = LD;
    mem_opcode[1] = 1'b0;
    mem_opcode[0] = x;
    $display("________LDL__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    
    #1
    opcode = LD;
    mem_opcode[1] = 1'b1;
    mem_opcode[0] = x;
    $display("________LDH__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    
    #1
    opcode = ST;
    mem_opcode[1] = 1'b0;
    mem_opcode[0] = x;
    $display("________STL__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
      
    #1
    opcode = ST;
    mem_opcode[1] = 1'b1;
    mem_opcode[0] = x;
    $display("________LDL__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    
    #1
    opcode = JMP;
    mem_opcode = 2'b00;
    $display("________JMP__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    
    #1
    opcode = JMP;
    mem_opcode = 2'b01;
    $display("________JAl__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
   
    #1
    opcode = JMP;
    mem_opcode = 2'b10;
    $display("________JR__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
     
    #1
    opcode = JMP;
    mem_opcode = 2'b11;
    $display("________JALR__________")
    $display("a_c_controll = %b",a_c_controll);
    $display("we_ctr = %b",we_ctr);
    $display("pc_ctr = %b",pc_ctr);
    $display("jalr_ctr = %b",jalr_ctr);
    $display("rf_ctr = %b",rf_ctr);
    $display("brch_ctr = %b",brch_ctr);
    $display("src_ctr = %b",src_ctr);
    $display("imm_ctr = %b",imm_ctr);
    $display("alu_ctr = %b",alu_ctr);
    $display("data_ctr = %b",data_ctr);
    $display("we_mem_ctr = %b",we_mem_ctr);
    
end;

