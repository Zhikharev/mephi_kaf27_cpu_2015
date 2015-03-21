/*#################################################################################################################################################################################there_are_functions_for_test###############################################################################################*/

#include "cmd_mcu.h"
#include "mainfile.h"
#include "stdint.h"
#include "svdpi.h"

int32_t Acc_reg;
int32_t B_reg;
int32_t C_reg;
int32_t D_reg;
int32_t E_reg;
int32_t F_reg;
int32_t G_reg;

int32_t S_reg;

uint32_t SREG; //status registe

int pcounter=0;//program counter

int32_t memory[1023]={};

FILE  *f;



int32_t setfile(void)
{
char string[10];
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


int32_t run(char A)
{
uint32_t i;
uint8_t j;
uint32_t strofprog;
uint8_t tmp;
int8_t value;
int32_t operator;
int32_t typeofaddr;
int32_t operand;

value = 0;
strofprog = 0;
tmp = 0;
j = 0;
i = 4*pcounter;

fseek(f,i,0);// set a position in file
if((tmp = getc(f)) != EOF)
	{
		while(j < 4)
			{	
				fseek(f, (i + j), 0);
				tmp = getc(f);
				strofprog += tmp;
				j++;
				if(j < 4)
				strofprog <<= 8;
			};
	}
else
	{ 
	fclose(f);
	value = -1;
	};


operator = ((strofprog & 0xFC000000) >> 26);
typeofaddr = ((strofprog & 0x3000000) >> 24);
operand = (strofprog & 0xFFFFFF);

switch (operator) 
{
	case 0x01 : add_cmd(typeofaddr, operand); //ADD x
				break;
	case 0x02 : sub_cmd(typeofaddr, operand); //SUB x
				break; 
	case 0x03 : Acc_reg++; //inc x
				break;
	case 0x04 : Acc_reg--; //dec x
				break;
	case 0x05 : or_cmd(typeofaddr, operand);//or
				break; 
	case 0x06 : and_cmd(typeofaddr, operand);// and
				break;
	case 0x07 : xor_cmd(typeofaddr, operand);//xor
				break;
	case 0x08 : Acc_reg = ~Acc_reg;//INV x
				break;
	case 0x09 : Acc_reg<<=1;//RLC x
				break;
	case 0x0A : Acc_reg>>=1;//RRC x
				break;
	case 0x0B : ral_cmd();//RAL x
				break;
	case 0x0C : rar_cmd();//RAR x
				break;
	case 0x10 : lds_cmd(typeofaddr, operand);//LDS x
				break;
	case 0x11 : sts_cmd(operand);//STS x
				break;
	case 0x12 : mov_cmd(operand);//mov r1, r2
				break;
	case 0x13 : jmp_cmd(operand);//jmp x
				break;
	case 0x14 : jmi_cmd(operand);
				break;//JMI Y,x
	case 0x15 : break;// nop
	case 0x16 : ret_cmd();
				break;//ret
	default :   value = -2;
		   	    break;		
				};

if(A)
{
printf("*************DEBUG**************\n");
printf("Reg Accumulator %6d\n", Acc_reg);
printf("Reg B %6d\n", B_reg);
printf("Reg C %6d\n", C_reg);
printf("Reg D %6d\n", D_reg);
printf("Reg F %6d\n", F_reg);
printf("Reg G %6d\n", G_reg);
printf("Reg E %6d\n", E_reg);
printf("Reg S %6d\n", S_reg);
printf("Reg SREG %6d\n", SREG);
printf("Program counter %6d\n", pcounter);
printf("*************DEBUG***************\n");
};

return value;
};

int32_t checkreg(char A)
{
int32_t value;

switch (A)
{
	case 0x00:  value = Acc_reg;
				break;
	case 0x01:  value = B_reg;
				break;
	case 0x02:  value = C_reg;
				break;
	case 0x03:  value = D_reg;
				break;
	case 0x04:  value = E_reg;
				break;
	case 0x05:  value = F_reg;
				break;
	case 0x06:  value = G_reg;
				break;
	case 0x07:  value = S_reg;
				break;
	case 0x08:  value = SREG;
				break;
	case 0x09:  value = pcounter;
				break;
	default:    value = -1;
				break;   
};
return value;
};


int32_t checkmemory(int32_t addr)
{
return memory[addr];
};


