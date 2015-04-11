//model_cpu
#include <stdio.h>
#include <math.h>
//#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "svdpi.h"
#include "func.h"

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
int operand1;
int operand2;


//Fetch
FILE *f;
int openfile(void){

	/*char string[50];
	printf("Please set program file\n");
	scanf("%s", string);
	f = fopen(string, "r");*/

	printf ("Opening a file : ");
    f = fopen ("D:/instr/instructions.bin","rb");
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

//считывает только 8 бит!!!!!!!!!!
int readinstr (void){
	int g = 0;

		printf ("Set the position at the beginning of the file\n ");
		if (fseek (f,i,0) == 0)
			printf ("Done\n");
		else
			printf ("ERROR\n");

		printf ("i: %d\n",i);
		printf("PC %6d\n", PC);

		while (g != 2) {
		instr = fgetc (f);
		//instr += instr;
		if (instr == EOF)
		{
			if ( feof (f) != 0)
				printf ("Reading the file finished\n");
			else
				printf ("ERROR\n");
		}

		g = g + 1;

		}
		i = i + 16;

	printf ("i: %d\n",i);
	printf ("instr: %d\n",instr);
    return (instr);
}

void decode(int instr){ 

	opcode = (instr >> 12);
	printf ("opcode: %d\n",opcode);
	rs = ((instr & 0x0F00) >> 8);
	printf ("rs: %d\n",rs);
	imm = ((instr & 0x0F00) >> 8);
	printf ("imm: %d\n",imm);
	rt = ((instr & 0x00F0) >> 4);
	printf ("rt: %d\n",rt);
	rd = (instr & 0x000F);
	printf ("rd: %d\n",rd);
	Mtype = ((instr & 0x0C00) >> 10);
	printf ("Mtype: %d\n",Mtype);
	addr = (instr & 0x03FF);
	printf ("addr: %d\n",addr);

	switch (opcode) {
			case 0x0 :  add(operand1, operand2); 
					    printf ("add\n");
					break;
			case 0x1 : addi(imm, operand2); 
					   printf ("addi\n");
					break;
			case 0x2 : or(operand1, operand2);
				       printf ("or\n");
					break; 
			case 0x3 : and(operand1, operand2);
				       printf ("and\n");
					break;
			case 0x4 : xor(operand1, operand2);
					   printf ("xor\n");
					break;
			case 0x5 : nor(operand1, operand2);
					   printf ("nor\n");
					break;
			case 0x6 : sll(operand1, operand2);
					   printf ("sll\n");
					break;
			case 0x7 : rot(operand1, operand2);
				       printf ("rot\n");
					break;
			case 0x8 : bne(operand1, operand2);
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
							case 2: jr(operand1);
									printf ("jr\n");
								break;
							case 3: jalr(operand1);
									printf ("jarl\n");
								break;
					   }
					break;
			case 0xC : printf ("nop\n");
					break;// nop     
			default: printf ("Такого кода операции не сущетвует\n");
					break;		
			}
		printf ("opcode: %d\n",opcode);
}
//??????????????????????
short checkmemory(short addr)
{	
	printf("addr %6d\n", addr);
	return memory[addr];
}

