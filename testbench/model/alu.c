#include "model.h"
//**************************************
// Author: Svetlana Makarova 
// Project: MEPHI CPU
// Filename: alu.c
// Descriptions: instruction execution
//**************************************

int ADD (int rs, int rt, int rd) 
{
	int rs_data;
	int rt_data;
	int rd_data;

	rs_data = GETREG(rs);
	rt_data = GETREG(rt);
	rd_data = rs_data + rt_data;
	SETREG(rd, rd_data);
	PC = PC + 2;
    return rd_data;
}

int ADDI (int imm, int rt, int rd) 
{	
	int rt_data;
	int rd_data;

	rt_data = GETREG(rt);
	rd_data = imm + rt_data;
	SETREG(rd, rd_data);
	PC = PC + 2;
    return rd_data;
}

int OR (int rs, int rt, int rd) 
{	
	int rs_data;
	int rt_data;
	int rd_data;

	rs_data = GETREG(rs);
	rt_data = GETREG(rt);
	rd_data = rs_data | rt_data;
	SETREG(rd, rd_data);
	PC = PC + 2;
    return rd_data;
}

int AND (int rs, int rt, int rd) 
{
	int rs_data;
	int rt_data;
	int rd_data;

	rs_data = GETREG(rs);
	rt_data = GETREG(rt);
	rd_data = rs_data & rt_data;
	SETREG(rd, rd_data);
	PC = PC + 2;
    return rd_data;
}

int XOR (int rs, int rt, int rd) 
{
   	int rs_data;
	int rt_data;
	int rd_data;

	rs_data = GETREG(rs);
	rt_data = GETREG(rt);
	rd_data = rs_data ^ rt_data;
	SETREG(rd, rd_data);
	PC = PC + 2;
    return rd_data;
}

int NOR (int rs, int rt, int rd) 
{
    int rs_data;
	int rt_data;
	int rd_data;

	rs_data = GETREG(rs);
	rt_data = GETREG(rt);
	rd_data = ~(rs_data | rt_data);
	SETREG(rd, rd_data);
	PC = PC + 2;
    return rd_data;
}

int SLL (int rs, int rt, int rd) 
{
   	int rs_data;
	int rt_data;
	int rd_data;

	rs_data = GETREG(rs);
	rt_data = GETREG(rt);
	rd_data = rs_data << rt_data;
	SETREG(rd, rd_data);
	PC = PC + 2;
    return rd_data;
}

int ROT (int rs, int rt, int rd)
{
   	int rs_data;
	int rt_data;
	int rd_data;

	rs_data = GETREG(rs);
	rt_data = GETREG(rt);
	rd_data = (rs_data << rt_data) | (rs_data >> (4 - rt_data));
	SETREG(rd, rd_data);
	PC = PC + 2;
    return rd_data;
}

int BNE (int rs, int rt, int rd) 
{		   
	int rs_data;
	int rt_data;
	int rd_data;

	rs_data = GETREG(rs);
	rt_data = GETREG(rt);
	rd_data = GETREG(rd);
    if (rs_data != rt_data)
		PC = PC + rd_data;
	//if (verbosity == 0){
	//	printf("E: PC: %x\n", PC);
	//}
    return PC;
}

int LDL (int addr) 
{
	reg_MR = memory[addr];
	//if (verbosity == 0){
	//	printf("E: reg_MR %x\n", reg_MR);
	//}
	PC = PC + 2;
	return reg_MR;
}

int LDH (int addr) 
{
	reg_MR = memory[addr];
	reg_MR = reg_MR << 16; 
	//if (verbosity == 0){
	//	printf("E: reg_MR %x\n", reg_MR);
	//}
	PC = PC + 2;
	return reg_MR;
}

 int STL (int addr) 
{	
    reg_MR = reg_MR & 0x00FF;
	memory[addr] = reg_MR;
	PC = PC + 2;
	//if (verbosity == 0){
	//	printf("E: memory[%x] = %x\n", addr, memory[addr]);
	//}
	return memory[addr];
}

 int STH (int addr) 
{   
	reg_MR = reg_MR >> 16;
	memory[addr] = reg_MR;
	PC = PC + 2;
	//if (verbosity == 0){
	//	printf("E: memory[%x] = %x\n", addr, memory[addr]);
	//}
	return memory[addr];
}

 int JMP (int addr)
{
	PC = addr;
	//if (verbosity == 0){
	//	printf("E: PC: %x\n", PC);
	//}
	return PC;
}

int JAL (int addr)
{
	reg_LR = PC + 2;
	PC = addr;
	//if (verbosity == 0){
	//	printf("E: reg_LR: %x\n", reg_LR);
	//	printf("E: PC: %x\n", PC);
	//}
	return PC;
}

int JR (int addr_rs)
{
	PC = GETREG(addr_rs);
	return PC;
}

int JALR (int addr_rs)
{	
	reg_LR = PC + 2;
	//if (verbosity == 0){
	//	printf("E: reg_LR: %x\n", reg_LR);
	//}
	PC = GETREG(addr_rs);
	return PC;
}

NOP()
{
	PC = PC + 2;
}
