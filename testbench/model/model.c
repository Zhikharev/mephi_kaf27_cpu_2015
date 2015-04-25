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
	imm = ((instr & 0x0F00) >> 8);
	rt = ((instr & 0x00F0) >> 4);
	rd = (instr & 0x000F);
	Mtype = ((instr & 0x0C00) >> 10);
	addr = (instr & 0x03FF);
	addr_rs = (instr & 0x03FF);

	switch (opcode) {
			case 0x0 : printf ("add\n");
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   ADD(rs, rt, rd);
					   COUNT_ADD++;
					break;
			case 0x1 : printf ("addi\n");
					   printf ("D: imm: %x\n",imm);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
				       ADDI(imm, rt, rd);
					   COUNT_ADDI++;
					break;
			case 0x2 : printf ("or\n");
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   OR(rs, rt, rd);
					   COUNT_OR++;
					break; 
			case 0x3 : printf ("and\n");
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   AND(rs, rt, rd);
					   COUNT_AND++;
					break;
			case 0x4 : printf ("xor\n");
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   XOR(rs, rt, rd);	
					   COUNT_XOR++;
					break;
			case 0x5 : printf ("nor\n");
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   NOR(rs, rt, rd);	
					   COUNT_NOR++;
					break;
			case 0x6 : printf ("sll\n");
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   SLL(rs, rt, rd);
					   COUNT_SLL++;
					break;
			case 0x7 : printf ("rot\n");
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   ROT(rs, rt, rd);
					   COUNT_ROT++;
					break;
			case 0x8 : printf ("bne\n");
					   printf ("D: rs: %x\n",rs);
					   printf ("D: rt: %x\n",rt);
					   printf ("D: rd: %x\n",rd);
					   BNE(rs, rt, rd);
					   COUNT_BNE++;
					break;
			case 0x9 : switch (Mtype) {
							case 0: printf ("ldl\n");
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									LDL(addr);
									COUNT_LDL++;
								break;
							case 1: printf ("ldl\n");
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									LDL(addr);
									COUNT_LDL++;
								break;
							case 2: printf ("ldh\n");
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									LDH(addr);
									COUNT_LDH++;
								break;
							case 3: printf ("ldh\n");
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									LDH(addr);
									COUNT_LDH++;
								break;
					   }
					break;
			case 0xA : switch (Mtype) {
							case 0: printf ("stl\n");
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									STL(addr);
									COUNT_STL++;
								break;
							case 1: printf ("stl\n");
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									STL(addr);
									COUNT_STL++;
								break;
							case 2: printf ("sth\n");
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									STH(addr);
									COUNT_STH++;
								break;
							case 3: printf ("sth\n");
								    printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									STH(addr);
									COUNT_STH++;
								break;
					   } 
					break;
			case 0xB : switch (Mtype) {
							case 0: printf ("jmp\n");
									printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									JMP(addr);
									COUNT_JMP++;
								break;
							case 1: printf ("jal\n");
									printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr: %x\n",addr);
									JAL(addr);
									COUNT_JAL++;
								break;
							case 2: printf ("jr\n");
									printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr_rs: %x\n",addr_rs);
									JR(addr_rs);
									COUNT_JR++;
								break;
							case 3: printf ("jarl\n");
									printf ("D: Mtype: %x\n",Mtype);
									printf ("D: addr_rs: %x\n",addr_rs);
									JALR(addr_rs);
									COUNT_JALR++;
								break;
					   }
					break;
			case 0xC : printf ("nop\n");
					   NOP();
					   COUNT_NOP++;
					break;  
			/*case 0xf: if ((rs = 0xf) & (rt = 0xf) & (rd = 0xf))
					  {
						  printf("End of instructions");
						  //????????????????
					  }
					break;*/
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

