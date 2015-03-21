/**************************************************************************
***************************************************************************
******************************source code of commands, which mcu must do***
************************Designed by Ivan Grafsky, NRNU MEPHI, 2012********/


//functions
#include <stdint.h>
#include <stdio.h>
#include "cmd_mcu.h"

void add_cmd(uint8_t A, uint32_t B)
{
switch(A) {
	case 0x01 :		switch (B) {
						case 0x00 : Acc_reg += Acc_reg;
									break;
						case 0x01 : Acc_reg += B_reg;
									break;
						case 0x02 : Acc_reg += C_reg;
									break;
						case 0x03 : Acc_reg += D_reg;
									break;
						case 0x04 : Acc_reg += E_reg;
									break;
						case 0x05 : Acc_reg += F_reg;
									break;
						case 0x06 : Acc_reg += G_reg;
									break;
						case 0x07 : Acc_reg += S_reg;
									break;
					break;					};
					
	case 0x03 : error();
				break;
	case 0x02 :	Acc_reg += B;
				break;					 	
						};
};


void sub_cmd(uint8_t A, uint32_t B)
{
switch(A) {
	case 0x01 :		switch (B) {
						case 0x00 : Acc_reg -= Acc_reg;
									break;
						case 0x01 : Acc_reg -= B_reg;
									break;
						case 0x02 : Acc_reg -= C_reg;
									break;
						case 0x03 : Acc_reg -= D_reg;
									break;
						case 0x04 : Acc_reg -= E_reg;
									break;
						case 0x05 : Acc_reg -= F_reg;
									break;
						case 0x06 : Acc_reg -= G_reg;
									break;
						case 0x07 : Acc_reg -= S_reg;
									break;
										};
					break;
	case 0x03 : error();
					break;
	case 0x02 :	Acc_reg -= B;
					break;					 	
						};
}; 

void or_cmd(uint8_t A, uint32_t B)
{
switch(A) {
	case 0x01 :		switch (B) {
						case 0x00 : Acc_reg |= Acc_reg;
									break;
						case 0x01 : Acc_reg |= B_reg;
									break;
						case 0x02 : Acc_reg |= C_reg;
									break;
						case 0x03 : Acc_reg |= D_reg;
									break;
						case 0x04 : Acc_reg |= E_reg;
									break;
						case 0x05 : Acc_reg |= F_reg;
									break;
						case 0x06 : Acc_reg |= G_reg;
									break;
						case 0x07 : Acc_reg |= S_reg;
									break;
										};
					break;
	case 0x03 : error();
				break;
	case 0x02 :	Acc_reg |= B;
				break;					 	
						};

};

void and_cmd(uint8_t A, uint32_t B)
{
switch(A) {
	case 0x01 :		switch (B) {
						case 0x00 : Acc_reg &= Acc_reg;
						case 0x01 : Acc_reg &= B_reg;
						case 0x02 : Acc_reg &= C_reg;
						case 0x03 : Acc_reg &= D_reg;
						case 0x04 : Acc_reg &= E_reg;
						case 0x05 : Acc_reg &= F_reg;
						case 0x06 : Acc_reg &= G_reg;
						case 0x07 : Acc_reg &= S_reg;
										};
	case 0x03 : error();
	case 0x02 :	Acc_reg &= B;					 	
						};

};

void xor_cmd(uint8_t A, uint32_t B)
{
switch(A) {
	case 0x01 :		switch (B) {
						case 0x00 : Acc_reg ^= Acc_reg;
						case 0x01 : Acc_reg ^= B_reg;
						case 0x02 : Acc_reg ^= C_reg;
						case 0x03 : Acc_reg ^= D_reg;
						case 0x04 : Acc_reg ^= E_reg;
						case 0x05 : Acc_reg ^= F_reg;
						case 0x06 : Acc_reg ^= G_reg;
						case 0x07 : Acc_reg ^= S_reg;
										};
	case 0x03 : error();
	case 0x02 :	Acc_reg ^= B;					 	
						};
};

void ral_cmd(void)
{
char bit;
bit = (Acc_reg & 0x80000000);
Acc_reg<<=1;
if (bit)
	SREG |= (1<<CBIT);
else 
	SREG &=~(1<<CBIT);
	
};


void rar_cmd(void)
{
char bit;
bit = (Acc_reg & 0x01);
Acc_reg>>=1;
if (bit)
	SREG |= (1<<CBIT);
else 
	SREG &=~(1<<CBIT);
};




void error (void) 
{
printf("error!!!\n");
SREG |= (1<<EBIT); //cpu tells to us about error
};

void lds_cmd (uint8_t A, uint32_t B)
{
switch(A) {
	case 0x01 :		switch (B) {
						case 0x00 : S_reg = Acc_reg;
									break;
						case 0x01 : S_reg = B_reg;
									break;
						case 0x02 : S_reg = C_reg;
									break;
						case 0x03 : S_reg = D_reg;
									break;
						case 0x04 : S_reg = E_reg;
									break;
						case 0x05 : S_reg = F_reg;
									break;
						case 0x06 : S_reg = G_reg;
									break;
						case 0x07 : S_reg = S_reg;
									break;
										};
					break;
	case 0x03 : S_reg = memory[B]; //!?!??!?!?!??!?!?!?
				break;
	case 0x02 :	S_reg = B;
				break;					 	
						};

};

void mov_cmd(uint32_t A)
{
unsigned char R1, R2;
uint32_t Reg1;
uint32_t *Reg2;
R1 = (A & 0x7000)>>12;
switch(R1){
	case 0x00 : Reg1 = Acc_reg;
					break;
	case 0x01 : Reg1 = B_reg;
					break;
	case 0x02 : Reg1 = C_reg;
					break;
	case 0x03 : Reg1 = D_reg;
					break;
	case 0x04 : Reg1 = E_reg;
					break;
	case 0x05 : Reg1 = F_reg;
					break;
	case 0x06 : Reg1 = G_reg;
					break;
	case 0x07 : Reg1 = S_reg;
					break;
			};
R2 = (A & 0x0D);
switch(R2) {
	case 0x00 : Reg2 = &Acc_reg;
					break;
	case 0x01 : Reg2 = &B_reg;
					break;
	case 0x02 : Reg2 = &C_reg;
					break;
	case 0x03 : Reg2 = &D_reg;
					break;
	case 0x04 : Reg2 = &E_reg;
					break;
	case 0x05 : Reg2 = &F_reg;
					break;
	case 0x06 : Reg2 = &G_reg;
					break;
	case 0x07 : Reg2 = &S_reg;
					break;
			};
*Reg2 = Reg1;
};


void jmp_cmd(uint32_t A)
{
pcounter = A-1; 
};




void sts_cmd (uint32_t B)
{
memory[B] = S_reg;//!?!?!?!?!??!?!
};



void jmi_cmd(uint32_t A)
{
uint8_t condition;
uint32_t place;

condition = (A & 0xE00000);
place = (A & 0x1FFFFF);

switch (condition)
{
	case 0x00:
				if(Acc_reg != 0)
					{
						pcounter = place - 1;
					}
				else 
					break;
	case 0x01:
				if(Acc_reg == 0)
					{
						pcounter = place - 1;
					}
				else 
					break;
	case 0x02:	
				if((SREG & 0x01) == 0)
					{
						pcounter = place - 1;	
					}
				else
					break;
	case 0x03:
				if((SREG & 0x01))
					{
						pcounter = place - 1;
					}
				else 
					break;
	case 0x04:
				if((Acc_reg%2) != 0)
					{
						pcounter = place - 1;
					}
				else 
					break;
	case 0x05:
				if((Acc_reg%2) == 0)
					{
						pcounter = place - 1;
					}
				else 
					break;
	case 0x06:
				if(Acc_reg > 0)
					{
						pcounter = place - 1;
					}
				else 
					break;
	case 0x07:
				if(Acc_reg < 0)
					{
						pcounter = place - 1;
					}
				else
					break;
	default: error();
};
};


void ret_cmd(void)
{
Acc_reg = memory[1017];
B_reg = memory[1018];
C_reg = memory[1019];
D_reg = memory[1020];
E_reg = memory[1021];
F_reg = memory[1022];
G_reg = memory[1023];
pcounter = memory[1024]-1;
};
