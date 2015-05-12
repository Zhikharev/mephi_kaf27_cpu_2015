#include "model.h"
//**********************************************************
// Author: Svetlana Makarova 
// Project: MEPHI CPU
// Filename: model.c
// Descriptions: 
//		This file contains the functions of decoding 
//		instructions, memory management and other functions 
//		for data communication and interaction with TB
//**********************************************************

void test_sv_c_communication(int arg) {
	printf("Hello from C!\n");
    printf("C: var is %d\n", arg);
}

decode(int instr,int verbosity)
{
	opcode = (instr >> 12);
	if (verbosity == 0){
		printf ("D: opcode: %x\n",opcode);
	}
	rs = ((instr & 0x0F00) >> 8);
	imm = ((instr & 0x0F00) >> 8);
	rt = ((instr & 0x00F0) >> 4);
	rd = (instr & 0x000F);
	Mtype = ((instr & 0x0C00) >> 10);
	addr = (instr & 0x03FF);
	addr_rs = (instr & 0x03FF);
	k++;
	switch (opcode) {
			case 0x0 : if (verbosity == 0){
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   printf ("E: add\n");
					   }				   
					   ADD(rs, rt, rd);
					   COUNT_ADD++;
					break;
			case 0x1 : if (verbosity == 0){
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   printf ("E: addi\n");
					   }
				       ADDI(imm, rt, rd);
					   COUNT_ADDI++;
					break;
			case 0x2 : if (verbosity == 0){
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   printf ("E: or\n");
					   }
					   OR(rs, rt, rd);
					   COUNT_OR++;
					break; 
			case 0x3 : if (verbosity == 0){
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   printf ("E: and\n");
					   }
					   AND(rs, rt, rd);
					   COUNT_AND++;
					break;
			case 0x4 : if (verbosity == 0){
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   printf ("E: xor\n");
					   }
					   XOR(rs, rt, rd);	
					   COUNT_XOR++;
					break;
			case 0x5 : if (verbosity == 0){
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   printf ("E: nor\n");
					   }
					   NOR(rs, rt, rd);	
					   COUNT_NOR++;
					break;
			case 0x6 :  if (verbosity == 0){
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   printf ("E: sll\n");
					   }
					   SLL(rs, rt, rd);
					   COUNT_SLL++;
					break;
			case 0x7 :  if (verbosity == 0){
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   printf ("E: rot\n");
					   }
					   ROT(rs, rt, rd);
					   COUNT_ROT++;
					break;
			case 0x8 :  if (verbosity == 0){
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   printf ("E: bne\n");
					   }
					   BNE(rs, rt, rd);
					   COUNT_BNE++;
					break;
			case 0x9 : switch (Mtype) {
							case 0: if (verbosity == 0){
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									printf ("E: ldl\n");
									}
									LDL(addr);
									COUNT_LDL++;
								break;
							case 1: if (verbosity == 0){
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									printf ("E: ldl\n");
									}
									LDL(addr);
									COUNT_LDL++;
								break;
							case 2: if (verbosity == 0){
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									printf ("E: ldh\n");
									}
									LDH(addr);
									COUNT_LDH++;
								break;
							case 3: if (verbosity == 0){
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									printf ("E: ldh\n");
									}
									LDH(addr);
									COUNT_LDH++;
								break;
					   }
					break;
			case 0xA : switch (Mtype) {
							case 0: if (verbosity == 0){
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									printf ("E: stl\n");
									}
									STL(addr);
									COUNT_STL++;
								break;
							case 1: if (verbosity == 0){
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									printf ("E: stl\n");
									}
									STL(addr);
									COUNT_STL++;
								break;
							case 2: if (verbosity == 0){
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									printf ("E: sth\n");
									}
									STH(addr);
									COUNT_STH++;
								break;
							case 3: if (verbosity == 0){
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									printf ("E: sth\n");
									}
									STH(addr);
									COUNT_STH++;
								break;
					   } 
					break;
			case 0xB : switch (Mtype) {
							case 0: if (verbosity == 0){
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									printf ("E: jmp\n");
									}
									JMP(addr);
									COUNT_JMP++;
								break;
							case 1: if (verbosity == 0){
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									printf ("E: jal\n");
									}
									JAL(addr);
									COUNT_JAL++;
								break;
							case 2: if (verbosity == 0){
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr_rs);
									printf ("E: jr\n");
									}
									JR(addr_rs);
									COUNT_JR++;
								break;
							case 3: if (verbosity == 0){
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr_rs);
									printf ("E: jalr\n");
									}
									JALR(addr_rs);
									COUNT_JALR++;
								break;
					   }
					break;
			case 0xC : if (verbosity == 0)
						   printf ("E: nop\n");
					   NOP();
					   COUNT_NOP++;
					break;  
			default: if (verbosity == 0)
						printf ("This operation doesn't exist\n");
					 PC = PC + 2;
					 return 0;
					break;		
			}
	return 1;
}

int SETREG (int addr_reg, int data_reg)
{
	switch(rd){
			case 0x0 : reg_A = data_reg;
				    //  if (verbosity == 0)
					//	   printf("E: reg_A %x\n", reg_A);
					   return reg_A;
					break;
			case 0x1 : reg_B = data_reg;
				     //  if (verbosity == 0)
					//	   printf("E: reg_B %x\n", reg_B);
					   return reg_B;
					break;
			case 0x2 : reg_C = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_C %x\n", reg_C);
					   return reg_C;
					break;
			case 0x3 : reg_D = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_D %x\n", reg_D);
					   return reg_D;
					break;	
			case 0x4 : reg_E = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_E %x\n", reg_E);
					   return reg_E;
					break;
			case 0x5 : reg_F = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_F %x\n", reg_F);
					   return reg_F;
					break;
			case 0x6 : reg_G = data_reg;
			       	//   if (verbosity == 0)
					//	   printf("E: reg_G %x\n", reg_G);
					   return reg_G;
					break;
			case 0x7 : reg_H = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_H %x\n", reg_H);
					   return reg_H;
					break;
			case 0x8 : reg_W = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_W %x\n", reg_W);
					   return reg_W;
					break;
			case 0x9 : reg_K = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_K %x\n", reg_K);
					   return reg_K;
					break;	
			case 0xA : reg_MR = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_MR %x\n", reg_MR);
					   return reg_MR;
					break;
			case 0xB : reg_LR = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_LR %x\n", reg_LR);
					   return reg_LR;
					break;
			case 0xC : reg_zero = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_zero %x\n", reg_zero);
					   return reg_zero;
					break;
			case 0xD : reg_t0 = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_t0 %x\n", reg_t0);
					   return reg_t0;
					break;
			case 0xE : reg_t1 = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_t1 %x\n", reg_t1);
					   return reg_t1;
					break;
			case 0xF : reg_t2 = data_reg;
				    //   if (verbosity == 0)
					//	   printf("E: reg_t2 %x\n", reg_t2);
					   return reg_t2;
					break;
			default : return 0;
					break;
		}
}

int GETREG(int addr_reg)
{
	int REG;
	switch(addr_reg){
			case 0x0 : REG = reg_A;
					  // if (verbosity == 0)
						//   printf("E: reg_A %x\n", reg_A);
					break;
			case 0x1 : REG = reg_B;
					  // if (verbosity == 0)
						//   printf("E: reg_B %x\n", reg_B);
					break;
			case 0x2 : REG = reg_C;
					  // if (verbosity == 0)
						//   printf("E: reg_C %x\n", reg_C);
					break;
			case 0x3 : REG = reg_D;
				      // if (verbosity == 0)
						//   printf("E: reg_D %x\n", reg_D);
					break;	
			case 0x4 : REG = reg_E;
				      // if (verbosity == 0)
						//   printf("E: reg_E %x\n", reg_E);
					break;
			case 0x5 : REG = reg_F;
				      // if (verbosity == 0)
						//   printf("E: reg_F %x\n", reg_F);
					break;
			case 0x6 : REG = reg_G;
				       //if (verbosity == 0)
						//   printf("E: reg_G %x\n", reg_G);
					break;
			case 0x7 : REG = reg_H;
				      // if (verbosity == 0)
						//   printf("E: reg_H %x\n", reg_H);
					break;
			case 0x8 : REG = reg_W;
				      // if (verbosity == 0)
					//	   printf("E: reg_W %x\n", reg_W);
					break;
			case 0x9 : REG = reg_K;
				     //  if (verbosity == 0)
					//	   printf("E: reg_K %x\n", reg_K);
					break;	
			case 0xA : REG = reg_MR;
				     //  if (verbosity == 0)
					//	   printf("E: reg_MR %x\n", reg_MR);
					break;
			case 0xB : REG = reg_LR;
				     //  if (verbosity == 0)
					//	   printf("E: reg_LR %x\n", reg_LR);
					break;
			case 0xC : REG = reg_zero;
				     //  if (verbosity == 0)
					//	   printf("E: reg_zero %x\n", reg_zero);
					break;
			case 0xD : REG = reg_t0;
				      // if (verbosity == 0)
					//	   printf("E: reg_t0 %x\n", reg_t0);
					break;
			case 0xE : REG = reg_t1;
				     //  if (verbosity == 0)
					//	   printf("E: reg_t1 %x\n", reg_t1);
					break;
			case 0xF : REG = reg_t2;
				    //   if (verbosity == 0)
					//	   printf("E: reg_t2 %x\n", reg_t2);
					break;
			default: return 0;
					break;
		}
	return REG;				
}

int init_memory()
{
	int t = 0;
	for(addr = 0; addr < 1024; addr++)
		{
			memory[addr] = t;
			t++;
		}
	return memory[addr];
}

int set_memory(int addr, int data)
{
	memory[addr] = data;
}

int get_memory(int addr)
{	
	return memory[addr];
}

allreg(int verbosity)
{
	if (verbosity == 0) {
		printf("***************************\n");
		printf("reg_A %x\n", reg_A);
		printf("reg_B %x\n", reg_B);
		printf("reg_C %x\n", reg_C);
		printf("reg_D %x\n", reg_D);
		printf("reg_E %x\n", reg_E);
		printf("reg_F %x\n", reg_F);
		printf("reg_G %x\n", reg_G);
		printf("reg_H %x\n", reg_H);
		printf("reg_W %x\n", reg_W);
		printf("reg_K %x\n", reg_K);
		printf("reg_MR %x\n", reg_MR);
		printf("reg_LR %x\n", reg_LR);
		printf("reg_zero %x\n", reg_zero);
		printf("reg_t0 %x\n", reg_t0);
		printf("reg_t1 %x\n", reg_t1);
		printf("reg_t2 %x\n", reg_t2);
		printf("PC %x\n", PC);
		printf("****************************\n");
	}
}

statistics(int verbosity)
{	
	if (verbosity == 0) {

		printf("The number of all instructions: %d\n\n", k-1);

		if (COUNT_ADD != 0)
			printf("The number of instructions ADD: %d\n", COUNT_ADD); 
		if (COUNT_ADDI != 0)
			printf("The number of instructions ADDI: %d\n", COUNT_ADDI);
		if (COUNT_OR != 0)
			printf("The number of instructions OR: %d\n", COUNT_OR);
		if (COUNT_AND != 0)
			printf("The number of instructions AND: %d\n", COUNT_AND);
		if (COUNT_XOR != 0)
			printf("The number of instructions XOR: %d\n", COUNT_XOR);
		if (COUNT_NOR != 0)
			printf("The number of instructions NOR: %d\n", COUNT_NOR);
		if (COUNT_SLL != 0)
			printf("The number of instructions SLL: %d\n", COUNT_SLL);
		if (COUNT_ROT != 0)
			printf("The number of instructions ROT: %d\n", COUNT_ROT);
		if (COUNT_BNE != 0)
			printf("The number of instructions BNE: %d\n", COUNT_BNE);
		if (COUNT_LDL != 0)
			printf("The number of instructions LDL: %d\n", COUNT_LDL);
		if (COUNT_LDH != 0)
			printf("The number of instructions LDH: %d\n", COUNT_LDH);
		if (COUNT_STL != 0)
			printf("The number of instructions STL: %d\n", COUNT_STL);
		if (COUNT_STH != 0)
			printf("The number of instructions STH: %d\n", COUNT_STH);
		if (COUNT_JMP != 0)
			printf("The number of instructions JMP: %d\n", COUNT_JMP);
		if (COUNT_JAL != 0)
			printf("The number of instructions JAL: %d\n", COUNT_JAL);
		if (COUNT_JR != 0)
			printf("The number of instructions JR: %d\n", COUNT_JR);
		if (COUNT_JALR != 0)
			printf("The number of instructions JALR: %d\n", COUNT_JALR);
		if (COUNT_NOP != 0)
			printf("The number of instructions NOP: %d\n", COUNT_NOP);
	}
}

write_results()
{	FILE  *fo;
	fo = fopen("result.txt","wt");
	fprintf(fo, "********* data of registers ********\n");
	fprintf(fo, "reg_A %x\n", reg_A);
	fprintf(fo, "reg_B %x\n", reg_B);
	fprintf(fo, "reg_C %x\n", reg_C);
	fprintf(fo, "reg_D %x\n", reg_D);
	fprintf(fo, "reg_E %x\n", reg_E);
	fprintf(fo, "reg_F %x\n", reg_F);
	fprintf(fo, "reg_G %x\n", reg_G);
	fprintf(fo, "reg_H %x\n", reg_H);
	fprintf(fo, "reg_W %x\n", reg_W);
	fprintf(fo, "reg_K %x\n", reg_K);
	fprintf(fo, "reg_MR %x\n", reg_MR);
	fprintf(fo, "reg_LR %x\n", reg_LR);
	fprintf(fo, "reg_zero %x\n", reg_zero);
	fprintf(fo, "reg_t0 %x\n", reg_t0);
	fprintf(fo, "reg_t1 %x\n", reg_t1);
	fprintf(fo, "reg_t2 %x\n", reg_t2);
	fprintf(fo, "PC %x\n", PC);
	fprintf(fo, "****************************\n");
	
	fprintf(fo, "The number of all instructions: %d\n\n", k-1);
	if (COUNT_ADD != 0)
		fprintf(fo, "The number of instructions ADD: %d\n", COUNT_ADD); 
	if (COUNT_ADDI != 0)
		fprintf(fo, "The number of instructions ADDI: %d\n", COUNT_ADDI);
	if (COUNT_OR != 0)
		fprintf(fo, "The number of instructions OR: %d\n", COUNT_OR);
	if (COUNT_AND != 0)
		fprintf(fo, "The number of instructions AND: %d\n", COUNT_AND);
	if (COUNT_XOR != 0)
		fprintf(fo, "The number of instructions XOR: %d\n", COUNT_XOR);
	if (COUNT_NOR != 0)
		fprintf(fo, "The number of instructions NOR: %d\n", COUNT_NOR);
	if (COUNT_SLL != 0)
		fprintf(fo, "The number of instructions SLL: %d\n", COUNT_SLL);
	if (COUNT_ROT != 0)
		fprintf(fo, "The number of instructions ROT: %d\n", COUNT_ROT);
	if (COUNT_BNE != 0)
		fprintf(fo, "The number of instructions BNE: %d\n", COUNT_BNE);
	if (COUNT_LDL != 0)
		fprintf(fo, "The number of instructions LDL: %d\n", COUNT_LDL);
	if (COUNT_LDH != 0)
		fprintf(fo, "The number of instructions LDH: %d\n", COUNT_LDH);
	if (COUNT_STL != 0)
		fprintf(fo, "The number of instructions STL: %d\n", COUNT_STL);
	if (COUNT_STH != 0)
		fprintf(fo, "The number of instructions STH: %d\n", COUNT_STH);
	if (COUNT_JMP != 0)
		fprintf(fo, "The number of instructions JMP: %d\n", COUNT_JMP);
	if (COUNT_JAL != 0)
		fprintf(fo, "The number of instructions JAL: %d\n", COUNT_JAL);
	if (COUNT_JR != 0)
		fprintf(fo, "The number of instructions JR: %d\n", COUNT_JR);
	if (COUNT_JALR != 0)
		fprintf(fo, "The number of instructions JALR: %d\n", COUNT_JALR);
	if (COUNT_NOP != 0)
		fprintf(fo, "The number of instructions NOP: %d\n", COUNT_NOP);

   fclose(fo);
}