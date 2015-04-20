//model_cpu
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "svdpi.h"

int reg_A = 1; // Register for storing hashsum
int reg_B = 2;
int reg_C = 3;
int reg_D = 4;
int reg_E = 5;
int reg_F = 6;
int reg_G = 7;
int reg_H = 8;
int reg_W = 9; // Register for storing words
int reg_K = 10; // Register for storing constants
int reg_MR = 11;// Memory Register
int reg_LR = 12; // Link Register
int reg_zero = 0; // Register for storing zero
int reg_t0 = 13; // Register for storing temporary variables
int reg_t1 = 14;
int reg_t2 = 15;
int PC;
//int *PC;
int memory[1024]; 
int instr;
int i = 0;
int REG;
int addr_reg;

int opcode;
int rs;
int rt;
int rd;
int imm;   
int Mtype;
int addr;
int addr_rs;

//Fetch
FILE *f;
openfile(){

	printf ("Opening a file : ");
    f = fopen ("prog.bin","rb");
    if(f == NULL)
	{
		printf("ERROR opening file\n");
		return -1;
	}
    else 
	{
		printf(" All right\n");
		return 0;
	}
}

int readinstr (){
	int buffer[2];
	int g = 0;

	printf ("Set the position at the beginning of the file\n ");
	if (fseek (f, i, SEEK_SET) == 0)
		printf ("Done\n");
	else
		printf ("ERROR\n");

	printf ("i: %i\n",i);
	//printf("PC %6p\n", PC);
	printf("PC: %d\n",PC);

	while (g < 2) {
		buffer[g] = fgetc (f);
		printf ("F: buffer[%d]: %x\n", g, buffer[g]);
		if (buffer[g] == EOF)
		{
			if ( feof (f) != 0)
				printf ("Reading the file finished\n");
			else
				printf ("ERROR\n");
		}
		g++;
	}
	buffer[0] = buffer[0] << 8;
	printf ("F: buffer[0]: %x\n", buffer[0]);
	instr = buffer[0]  | buffer[1];
	printf ("F: instr: 0x%04x\n",instr);
	i = i + 2;
	printf ("i: %d\n",i);
    return (instr);
}


    decode(int instr){ 
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
			case 0x0 : add(rs, rt); 
					   printf ("add\n");
					break;
			case 0x1 : addi(imm, rt, rd); 
					   printf ("addi\n");
					break;
			case 0x2 : or(rs, rt, rd);
				       printf ("or\n");
					break; 
			case 0x3 : and(rs, rt, rd);
				       printf ("and\n");
					break;
			case 0x4 : xor(rs, rt, rd);
					   printf ("xor\n");
					break;
			case 0x5 : nor(rs, rt, rd);
					   printf ("nor\n");
					break;
			case 0x6 : sll(rs, rt, rd);
					   printf ("sll\n");
					break;
			case 0x7 : rot(rs, rt, rd);
				       printf ("rot\n");
					break;
			case 0x8 : bne(rs, rt, rd);
					   printf ("bne\n");
					break;
			case 0x9 : switch (Mtype) {
							case 0: ldl(addr);
									printf ("ldl\n");
								break;
							case 1: ldl(addr);
									printf ("ldl\n");
								break;
							case 2: ldh(addr);
									printf ("ldh\n");
								break;
							case 3: ldh(addr);
									printf ("ldh\n");
								break;
					   }
					break;
			case 0xA : switch (Mtype) {
							case 0: stl(addr);
									printf ("stl\n");
								break;
							case 1: stl(addr);
									printf ("stl\n");
								break;
							case 2: sth(addr);
									printf ("sth\n");
								break;
							case 3: sth(addr);
									printf ("sth\n");
								break;
					   } 
					break;
			case 0xB : switch (Mtype) {
							case 0: jmp(addr);
									printf ("jmp\n");
								break;
							case 1: jal(addr);
									printf ("jal\n");
								break;
							case 2: jr(addr_rs);
									printf ("jr\n");
								break;
							case 3: jalr(addr_rs);
									printf ("jarl\n");
								break;
					   }
					break;
			case 0xC : printf ("nop\n");
					break;// nop     
			default: printf ("This operation doesn't exist\n");
					 return 0;
					break;		
			}
}

int checkreg(int addr_reg)
{
	int REG;
	switch(addr_reg){
			case 0x0 : REG = reg_A;
					   printf("reg_A %6d\n", reg_A);
					break;
			case 0x1 : REG = reg_B;
				       printf("reg_B %6d\n", reg_B);
					break;
			case 0x2 : REG = reg_C;
					   printf("reg_C %6d\n", reg_C);
					break;
			case 0x3 : REG = reg_D;
				       printf("reg_D %6d\n", reg_D);
					break;	
			case 0x4 : REG = reg_E;
				       printf("reg_E %6d\n", reg_E);
					break;
			case 0x5 : REG = reg_F;
				       printf("reg_F %6d\n", reg_F);
					break;
			case 0x6 : REG = reg_G;
				       printf("reg_G %6d\n", reg_G);
					break;
			case 0x7 : REG = reg_H;
				       printf("reg_H %6d\n", reg_H);
					break;
			case 0x8 : REG = reg_W;
				       printf("reg_W %6d\n", reg_W);
					break;
			case 0x9 : REG = reg_K;
		        	   printf("reg_K %6d\n", reg_K);
					break;	
			case 0xA : REG = reg_MR;
				       printf("reg_MR %6d\n", reg_MR);
					break;
			case 0xB : REG = reg_LR;
				       printf("reg_LR %6d\n", reg_LR);
					break;
			case 0xC : REG = reg_zero;
				       printf("reg_zero %6d\n", reg_zero);
					break;
			case 0xD : REG = reg_t0;
				       printf("reg_t0 %6d\n", reg_t0);
					break;
			case 0xE : REG = reg_t1;
				       printf("reg_t1 %6d\n", reg_t1);
					break;
			case 0xF : REG = reg_t2;
				       printf("reg_t2 %6d\n", reg_t2);
					break;
			default: return 0;
					break;
		}
	return REG;				
}

int checkmemory(int addr)
{	
	return memory[addr];
}

