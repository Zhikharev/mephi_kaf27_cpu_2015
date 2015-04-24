//model_cpu
#include "model.h"

void test_sv_c_communication(int arg) {
	printf("Hello from C!\n");
    printf("C: var is %d\n", arg);
}

DECODE(int instr){ 
	printf ("D: instr: 0x%04x\n",instr);
	opcode = (instr >> 12);
	printf ("D: opcode: %x\n",opcode);
	rs = ((instr & 0x0F00) >> 8);
	printf ("D: rs: %x\n",rs);
	imm = ((instr & 0x0F00) >> 8);
	printf ("D: imm: %x\n",imm);
	rt = ((instr & 0x00F0) >> 4);
	printf ("D: rt: %x\n",rt);
	rd = (instr & 0x000F);
	printf ("D: rd: %x\n",rd);
	Mtype = ((instr & 0x0C00) >> 10);
	printf ("D: Mtype: %x\n",Mtype);
	addr = (instr & 0x03FF);
	printf ("D: addr: %x\n",addr);
	addr_rs = (instr & 0x03FF);
	printf ("D: Mrs: %x\n",addr_rs);

	switch (opcode) {
			case 0x0 : printf ("add\n");
					   ADD(rs, rt, rd);   
					break;
			case 0x1 : printf ("addi\n");
				       ADDI(imm, rt, rd); 					  
					break;
			case 0x2 : printf ("or\n");
					   OR(rs, rt, rd);		    
					break; 
			case 0x3 : printf ("and\n");
					   AND(rs, rt, rd);		      
					break;
			case 0x4 : printf ("xor\n");
					   XOR(rs, rt, rd);					   
					break;
			case 0x5 : printf ("nor\n");
					   NOR(rs, rt, rd);					   
					break;
			case 0x6 : printf ("sll\n");
					   SLL(rs, rt, rd);				  
					break;
			case 0x7 : printf ("rot\n");
					   ROT(rs, rt, rd);				       
					break;
			case 0x8 : printf ("bne\n");
					   BNE(rs, rt, rd);					   
					break;
			case 0x9 : switch (Mtype) {
							case 0: printf ("ldl\n");
									LDL(addr);								
								break;
							case 1: printf ("ldl\n");
									LDL(addr);								
								break;
							case 2: printf ("ldh\n");
									LDH(addr);								
								break;
							case 3: printf ("ldh\n");
									LDH(addr);									
								break;
					   }
					break;
			case 0xA : switch (Mtype) {
							case 0: printf ("stl\n");
									STL(addr);									
								break;
							case 1: printf ("stl\n");
									STL(addr);									
								break;
							case 2: printf ("sth\n");
									STH(addr);									
								break;
							case 3: printf ("sth\n");
									STH(addr);									
								break;
					   } 
					break;
			case 0xB : switch (Mtype) {
							case 0: printf ("jmp\n");
									JMP(addr);									
								break;
							case 1: printf ("jal\n");
									JAL(addr);									
								break;
							case 2: printf ("jr\n");
									JR(addr_rs);									
								break;
							case 3: printf ("jarl\n");
									JALR(addr_rs);									
								break;
					   }
					break;
			case 0xC : printf ("nop\n");
					break;  
			default: printf ("This operation doesn't exist\n");
					 return 0;
					break;		
			}
	return 1;
}

int SETREG (int addr_reg, int data_reg)
{
	switch(rd){
			case 0x0 : reg_A = data_reg;
					   printf("reg_A %x\n", reg_A);
					   return reg_A;
					break;
			case 0x1 : reg_B = data_reg;
				       printf("reg_B %x\n", reg_B);
					   return reg_B;
					break;
			case 0x2 : reg_C = data_reg;
					   printf("reg_C %x\n", reg_C);
					   return reg_C;
					break;
			case 0x3 : reg_D = data_reg;
				       printf("reg_D %x\n", reg_D);
					   return reg_D;
					break;	
			case 0x4 : reg_E = data_reg;
				       printf("reg_E %x\n", reg_E);
					   return reg_E;
					break;
			case 0x5 : reg_F = data_reg;
				       printf("reg_F %x\n", reg_F);
					   return reg_F;
					break;
			case 0x6 : reg_G = data_reg;
				       printf("reg_G %x\n", reg_G);
					   return reg_G;
					break;
			case 0x7 : reg_H = data_reg;
				       printf("reg_H %x\n", reg_H);
					   return reg_H;
					break;
			case 0x8 : reg_W = data_reg;
				       printf("reg_W %x\n", reg_W);
					   return reg_W;
					break;
			case 0x9 : reg_K = data_reg;
		        	   printf("reg_K %x\n", reg_K);
					   return reg_K;
					break;	
			case 0xA : reg_MR = data_reg;
				       printf("reg_MR %x\n", reg_MR);
					   return reg_MR;
					break;
			case 0xB : reg_LR = data_reg;
				       printf("reg_LR %x\n", reg_LR);
					   return reg_LR;
					break;
			case 0xC : reg_zero = data_reg;
				       printf("reg_zero %x\n", reg_zero);
					   return reg_zero;
					break;
			case 0xD : reg_t0 = data_reg;
				       printf("reg_t0 %x\n", reg_t0);
					   return reg_t0;
					break;
			case 0xE : reg_t1 = data_reg;
				       printf("reg_t1 %x\n", reg_t1);
					   return reg_t1;
					break;
			case 0xF : reg_t2 = data_reg;
				       printf("reg_t2 %x\n", reg_t2);
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
					   printf("reg_A %x\n", reg_A);
					break;
			case 0x1 : REG = reg_B;
				       printf("reg_B %x\n", reg_B);
					break;
			case 0x2 : REG = reg_C;
					   printf("reg_C %x\n", reg_C);
					break;
			case 0x3 : REG = reg_D;
				       printf("reg_D %x\n", reg_D);
					break;	
			case 0x4 : REG = reg_E;
				       printf("reg_E %x\n", reg_E);
					break;
			case 0x5 : REG = reg_F;
				       printf("reg_F %x\n", reg_F);
					break;
			case 0x6 : REG = reg_G;
				       printf("reg_G %x\n", reg_G);
					break;
			case 0x7 : REG = reg_H;
				       printf("reg_H %x\n", reg_H);
					break;
			case 0x8 : REG = reg_W;
				       printf("reg_W %x\n", reg_W);
					break;
			case 0x9 : REG = reg_K;
		        	   printf("reg_K %x\n", reg_K);
					break;	
			case 0xA : REG = reg_MR;
				       printf("reg_MR %x\n", reg_MR);
					break;
			case 0xB : REG = reg_LR;
				       printf("reg_LR %x\n", reg_LR);
					break;
			case 0xC : REG = reg_zero;
				       printf("reg_zero %x\n", reg_zero);
					break;
			case 0xD : REG = reg_t0;
				       printf("reg_t0 %x\n", reg_t0);
					break;
			case 0xE : REG = reg_t1;
				       printf("reg_t1 %x\n", reg_t1);
					break;
			case 0xF : REG = reg_t2;
				       printf("reg_t2 %x\n", reg_t2);
					break;
			default: return 0;
					break;
		}
	return REG;				
}

int INITMEMORY()
{
	int t = 0;
	printf("Memory: ");
	for(addr = 0; addr < 1024; addr++)
		{
			memory[addr] = t;
			printf("%x ",memory[addr]);
			t++;
		}
	return memory[addr];
}

//Function for set memory from TB
/*
IMPORTMEMORY() 
{  	
	printf("C: Set memory from TB: ");
	SETMEMORY(); 
	printf("%x", memory[addr]);
} 
*/

int GETMEMORY(int addr)
{	
	return memory[addr];
}

