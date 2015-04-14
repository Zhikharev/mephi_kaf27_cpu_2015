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
short memory[1024]; 
short instr;
int i = 0;
int result;

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
		
	/*char string[50];
	printf("Please set program file\n");
	scanf("%s", string);
	f = fopen(string, "r");*/

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

short readinstr (){
	short buffer[2];
	int g = 0;

	printf ("Set the position at the beginning of the file\n ");
	if (fseek (f, i, SEEK_SET) == 0)
		printf ("Done\n");
	else
		printf ("ERROR\n");

	printf ("i: %i\n",i);
	printf("PC %6d\n", PC);

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


decode(short instr){ 
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
//??????????????????????
short checkmemory(short addr)
{	
	printf("addr %6d\n", addr);
	return memory[addr];
}

