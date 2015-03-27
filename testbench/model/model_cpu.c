//model_cpu
#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "func.h"

typedef uint32_t register_t; // width of registers
const int n_regs = 12; 
const int m_regs = 3; 
typedef struct {
register_t PC; // Program counter
register_t W; // Register for storing words
register_t K; // Register for storing constants
register_t zero; // Register for storing zero
register_t LR; // Link Register
register_t MR;// Memory Register
register_t hsum[n_regs]; // Register for storing hashsum
register_t temp[m_regs]; // Register for storing temporary variables
register_t conf_cpu; // Register for processor configuration
uint16_t *memory; // a pointer to a RAM
int pcounter = 0;//program counter
} state_t;

//Fetch
FILE  *f;
int32_t setfile(void)
{
char string[16];
printf("Please set program file\n");
scanf("%s", string);
f = fopen(string, "r");
if(f == NULL)
	{
		printf("ERROR opening file\n");
		return -1;
	}
else 
	{
		printf(" All right\n");
		return 0;
	};
};

/*int32_t run(char A)
{
uint32_t i;
uint8_t j;
uint32_t instr;
uint16_t instr_reg;

instr = 0;
instr_reg = 0;
j = 0;
i = 2*pcounter;

fseek(f,i,0);// set a position in file
if((instr_reg = getc(f)) != EOF)
	{
		while(j < 4)//??
			{	
				fseek(f, (i + j), 0);
				instr_reg = getc(f);
				instr += instr_reg;
				j++;
				if(j < 4) //??
				instr <<= 8;//??
			};
	}
else
	{ 
	fclose(f);
	};*/

//Decode
opcode = (instr >> 12);
rs = ((instr & 0x0F00) >> 8);
imm = ((instr & 0x0F00) >> 8);//????????
rt = ((instr & 0x00F0) >> 4);
rd = (instr & 0x000F);
Mtype = ((instr & 0x0C00) >> 10);
addr = (instr & 0x3FF);

//Execute
//ALU
switch (opcode) {
	case 0x0 : add(operand1, operand2); 
				break;
	case 0x1 : addi(operand1, operand2); 
				break;
	case 0x2 : or(operand1, operand2);
				break; 
	case 0x3 : and(operand1, operand2);
				break;
	case 0x4 : xor(operand1, operand2);
				break;
	case 0x5 : nor(operand1, operand2);
				break;
	case 0x6 : sll(operand1, operand2);
				break;
	case 0x7 : rot(operand1, operand2);
				break;
	case 0x8 : bne(operand1, operand2);
				break;
	case 0x9 : ld(addr);
				break;
	case 0xA : st(addr);
				break;
	case 0xB : jmp(addr);
				break;
	case 0xC : break;// nop

	default:     do_undefined; break;		
	};

//Write Back

//PC
