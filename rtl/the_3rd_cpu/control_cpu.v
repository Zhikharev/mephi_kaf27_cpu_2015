module control_cpu(
            input clk,
            input[3:0]op_code,
            input[1:0] mem_opcode,
            output a_c_ctr;
            output we_crt,
            output[1:0] pc_ctr,
            output jalr_ctr,
            output[1:0] rf_ctr,
            output brch_ctr,
            output[1:0] src_ctr, 
            output imm_ctr
            output[2:0] alu_ctr;
            output data_ctr;
            output we_mem_ctr;
)
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

reg we;
reg a_c
reg src;
reg[1:0] pc;
reg jalr;
reg[1:0] rf;
reg brch;
reg[1:0] src;
reg imm;
reg[2:0] alu;
reg data;
//terminals with // sighn don't care
always@(posedge clk)
begin
    case(op_code)
        ADD:begin
            we_mem =1'b0;
            we =1;
            a_c =1;
            rf = 0;
            src = 2'b01;
            imm = 0;
            alu[2:0] =0;
            brch = 0;
            pc = 2'b01;
            jarl = 1'b1;            
            data =1'b1;
        ADDI:begin
            we_mem =1'b0;
            we =1;
            a_c =1;
            rf = 0;
            src = 2'b01;
            imm = 1;
            alu[2:0] =0;
            brch = 0;
            pc = 2'b01;
            jarl = 1'b1;
            data =1'b1;
        end
        OR:begin
            we_mem =1'b0;
            we =1;
            a_c =1;
            rf = 0;
            src = 2'b01;
            imm = 0;
            alu[2:0] =3'b001;
            brch = 0;
            pc = 2'b01;
            jarl = 1'b1;
            data =1'b1;
        end
        AND:begin
            we_mem =1'b0;
            we =1;
            a_c =1;
            rf = 0;
            src = 2'b01;
            imm = 0;
            alu[2:0] =3'b010;
            brch = 0;
            pc = 2'b01;
            jarl = 1'b1;
            data =1'b1;
        end
        XOR:begin
            we_mem =1'b0;
            we =1;
            a_c =1;
            rf = 0;
            src = 2'b01;
            imm = 0;
            alu[2:0] =3'b011;
            brch = 0;
            pc = 2'b01;
            jarl = 1'b1;
            data =1'b1;
        end
        NOR:begin
            we_mem =1'b0;
            we =1;
            a_c =1;
            rf = 0;
            src = 2'b01;
            imm = 0;
            alu[2:0] =3'b100;
            brch = 0;
            pc = 2'b01;
            jarl = 1'b1;
            data =1'b1;
        end
        SLL:begin
            we_mem =1'b0;
            we =1;
            a_c =1;
            rf = 0;
            src = 2'b01;
            imm = 0;
            alu[2:0] =3'b101;
            brch = 0; 
            pc = 2'b01;         
            jarl = 1'b1;
            data =1'b1;
        end
        ROT:begin
            we_mem =1'b0;
            we =1;
            a_c =1;
            rf = 0;
            src = 2'b01;
            imm = 0;
            alu[2:0] =3'b110;
            brch = 0;
            pc = 2'b01;
            jarl = 1'b1;
            data =1'b1;
        end
        BNE:begin
            we_mem =1'b0;
            we =0;
            a_c =1'b0;
            rf = 0;
            src = 2'b01;
            imm = 0;
            alu[2:0] =3'b111;
            brch = 1;   
            pc = 2'b01;
            jarl = 1'b1;
            data =1'b1;
        end
        NOP:begin
            we_mem =1'b0;
            we =0;
            pc = 2'b00;
            data =1'b1;//
            imm =1'b1;//
            jarl =1'b1;//
            a_c = 1'b0;//
            brn = 1'b0;//
        end
        LD:begin
            we_mem =1'b0;
            d =1'b0;
            we = 1'b1;
            src = 2'b01;//
            jarl = 1'b1;
            if(mem_opcode[1]) rf = 2'b01
            else rf = 2'b10;         
        end
        ST:begin
            we_mem =1'b1;
            d =1'b1;//
            we = 1'b0;
            src = 2'b00;
            jarl = 1'b1;
            if(mem_opcode[1]) rf = 2'b01
            else rf = 2'b10;
        end
        JMP:begin
            case(mem_opceode)
                2'b00:begin//jmp
                    we_mem =1'b0;
                    pc = 2'b11;
                    we = 1'b0;//
                    src =2'b01;//
                    jarl =1'b1;//
                    brch =1'b0;//
                end
                2'b01:begin//jal
                    we_mem =1'b0;
                    we =1'b1;
                    rf = 2'b11;
                    jarl = 1'b0;
                    brch =1'b0;
                    src =2'b01;//
                end
                2'b10:begin//jr
                    we_mem =1'b0;
                    we =0;
                    src = 2'b10
                    a_c = 1'b1;              
                    pc = 2'b10;
                end
                2'b11:begin//jalr
                    we_mem =1'b0;
                    we = 1'b1;
                    jarl = 1'b0;
                    rf=2'b11;
                    pc 2'b10;
                    a_c 1'b1;             
                end 
            
            endcase;
                 
        end
    endcase;

end
assign a_c_ctr = a_c;
assign src_ctr = src;
assign pc_ctr = pc;
assign jalr_ctr = jalr;
assign rf_ctr = rf;
assign brch_ctr = brch;
assign scr_ctr = src;
assign imm_ctr = imm;
assign alu_ctr = alu;
assign data_ctr = data;
assign we_ctr = we;
assign we_mem_ctr = we_mem;
endmodule 
