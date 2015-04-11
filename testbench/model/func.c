//functions
#include <stdio.h>
#include <math.h>

int reg_A; // Register for storing hashsum
int reg_B;
int reg_C;
int reg_D;
int reg_E;
int reg_F;
int reg_G;
int reg_H;
int reg_W; // Register for storing words
int reg_K; // Register for storing constants
int reg_MR;// Memory Register
int reg_LR; // Link Register
int reg_zero; // Register for storing zero
int reg_t0; // Register for storing temporary variables
int reg_t1;
int reg_t2;
int PC;
short memory[1024]; 

int opcode;
int rs;
int rt;
int rd;
int imm;   
int Mtype;
int addr;
int operand1;
int operand2;
int result;

void add (int operand1,int operand2) 
{
	switch(rs){                 
			case 0x0 : operand1 = reg_A;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x1 : operand1 = reg_B;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x2 : operand1 = reg_C;
				       printf ("operand1: %d\n",operand1);
					break;
			case 0x3 : operand1 = reg_D;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0x4 : operand1 = reg_E;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x5 : operand1 = reg_F;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x6 : operand1 = reg_G;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x7 : operand1 = reg_H;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x8 : operand1 = reg_W;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x9 : operand1 = reg_K;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0xA : operand1 = reg_MR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xB : operand1 = reg_LR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xC : operand1 = reg_zero;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xD : operand1 = reg_t0;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xE : operand1 = reg_t1;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xF : operand1 = reg_t2;
					   printf ("operand1: %d\n",operand1);
					break;
			default: 
					break;	
		}
		switch(rt){                    
			case 0x0 : operand2 = reg_A;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x1 : operand2 = reg_B;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x2 : operand2 = reg_C;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x3 : operand2 = reg_D;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0x4 : operand2 = reg_E;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x5 : operand2 = reg_F;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x6 : operand2 = reg_G;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x7 : operand2 = reg_H;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x8 : operand2 = reg_W;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x9 : operand2 = reg_K;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0xA : operand2 = reg_MR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xB : operand2 = reg_LR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xC : operand2 = reg_zero;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xD : operand2 = reg_t0;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xE : operand2 = reg_t1;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xF : operand2 = reg_t2;
				       printf ("operand2: %d\n",operand2);
					break;
			default: 
					break;	
		}

		result = operand1 + operand2;

		switch(rd){
			case 0x0 : reg_A = result;
					   printf("reg_A %6d\n", reg_A);
					break;
			case 0x1 : reg_B = result;
				       printf("reg_B %6d\n", reg_B);
					break;
			case 0x2 : reg_C = result;
					   printf("reg_C %6d\n", reg_C);
					break;
			case 0x3 : reg_D = result;
				       printf("reg_D %6d\n", reg_D);
					break;	
			case 0x4 : reg_E = result;
				       printf("reg_E %6d\n", reg_E);
					break;
			case 0x5 : reg_F = result;
				       printf("reg_F %6d\n", reg_F);
					break;
			case 0x6 : reg_G = result;
				       printf("reg_G %6d\n", reg_G);
					break;
			case 0x7 : reg_H = result;
				       printf("reg_H %6d\n", reg_H);
					break;
			case 0x8 : reg_W = result;
				       printf("reg_W %6d\n", reg_W);
					break;
			case 0x9 : reg_K = result;
		        	   printf("reg_K %6d\n", reg_K);
					break;	
			case 0xA : reg_MR = result;
				       printf("reg_MR %6d\n", reg_MR);
					break;
			case 0xB : reg_LR = result;
				       printf("reg_LR %6d\n", reg_LR);
					break;
			case 0xC : reg_zero = result;
				       printf("reg_zero %6d\n", reg_zero);
					break;
			case 0xD : reg_t0 = result;
				       printf("reg_t0 %6d\n", reg_t0);
					break;
			case 0xE : reg_t1 = result;
				       printf("reg_t1 %6d\n", reg_t1);
					break;
			case 0xF : reg_t2 = result;
				       printf("reg_t2 %6d\n", reg_t2);
					break;
			default: 
					break;
		}

	PC = PC + 2;
    //return result;
}


void addi (int imm,int operand2) 
{	
		switch(rt){                    
			case 0x0 : operand2 = reg_A;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x1 : operand2 = reg_B;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x2 : operand2 = reg_C;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x3 : operand2 = reg_D;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0x4 : operand2 = reg_E;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x5 : operand2 = reg_F;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x6 : operand2 = reg_G;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x7 : operand2 = reg_H;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x8 : operand2 = reg_W;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x9 : operand2 = reg_K;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0xA : operand2 = reg_MR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xB : operand2 = reg_LR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xC : operand2 = reg_zero;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xD : operand2 = reg_t0;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xE : operand2 = reg_t1;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xF : operand2 = reg_t2;
				       printf ("operand2: %d\n",operand2);
					break;
			default: 
					break;	
		}

		result = imm + operand2;

		switch(rd){
			case 0x0 : reg_A = result;
					   printf("reg_A %6d\n", reg_A);
					break;
			case 0x1 : reg_B = result;
				       printf("reg_B %6d\n", reg_B);
					break;
			case 0x2 : reg_C = result;
					   printf("reg_C %6d\n", reg_C);
					break;
			case 0x3 : reg_D = result;
				       printf("reg_D %6d\n", reg_D);
					break;	
			case 0x4 : reg_E = result;
				       printf("reg_E %6d\n", reg_E);
					break;
			case 0x5 : reg_F = result;
				       printf("reg_F %6d\n", reg_F);
					break;
			case 0x6 : reg_G = result;
				       printf("reg_G %6d\n", reg_G);
					break;
			case 0x7 : reg_H = result;
				       printf("reg_H %6d\n", reg_H);
					break;
			case 0x8 : reg_W = result;
				       printf("reg_W %6d\n", reg_W);
					break;
			case 0x9 : reg_K = result;
		        	   printf("reg_K %6d\n", reg_K);
					break;	
			case 0xA : reg_MR = result;
				       printf("reg_MR %6d\n", reg_MR);
					break;
			case 0xB : reg_LR = result;
				       printf("reg_LR %6d\n", reg_LR);
					break;
			case 0xC : reg_zero = result;
				       printf("reg_zero %6d\n", reg_zero);
					break;
			case 0xD : reg_t0 = result;
				       printf("reg_t0 %6d\n", reg_t0);
					break;
			case 0xE : reg_t1 = result;
				       printf("reg_t1 %6d\n", reg_t1);
					break;
			case 0xF : reg_t2 = result;
				       printf("reg_t2 %6d\n", reg_t2);
					break;
			default: 
					break;	
		}

	PC = PC + 2;
    //return result;
}

void or (int operand1,int operand2) 
{	
	switch(rs){                 
			case 0x0 : operand1 = reg_A;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x1 : operand1 = reg_B;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x2 : operand1 = reg_C;
				       printf ("operand1: %d\n",operand1);
					break;
			case 0x3 : operand1 = reg_D;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0x4 : operand1 = reg_E;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x5 : operand1 = reg_F;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x6 : operand1 = reg_G;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x7 : operand1 = reg_H;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x8 : operand1 = reg_W;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x9 : operand1 = reg_K;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0xA : operand1 = reg_MR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xB : operand1 = reg_LR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xC : operand1 = reg_zero;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xD : operand1 = reg_t0;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xE : operand1 = reg_t1;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xF : operand1 = reg_t2;
					   printf ("operand1: %d\n",operand1);
					break;
			default: 
					break;	
		}
		switch(rt){                    
			case 0x0 : operand2 = reg_A;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x1 : operand2 = reg_B;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x2 : operand2 = reg_C;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x3 : operand2 = reg_D;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0x4 : operand2 = reg_E;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x5 : operand2 = reg_F;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x6 : operand2 = reg_G;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x7 : operand2 = reg_H;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x8 : operand2 = reg_W;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x9 : operand2 = reg_K;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0xA : operand2 = reg_MR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xB : operand2 = reg_LR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xC : operand2 = reg_zero;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xD : operand2 = reg_t0;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xE : operand2 = reg_t1;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xF : operand2 = reg_t2;
				       printf ("operand2: %d\n",operand2);
					break;
			default: 
					break;	
		}

		result = operand1 | operand2;

		switch(rd){
			case 0x0 : reg_A = result;
					   printf("reg_A %6d\n", reg_A);
					break;
			case 0x1 : reg_B = result;
				       printf("reg_B %6d\n", reg_B);
					break;
			case 0x2 : reg_C = result;
					   printf("reg_C %6d\n", reg_C);
					break;
			case 0x3 : reg_D = result;
				       printf("reg_D %6d\n", reg_D);
					break;	
			case 0x4 : reg_E = result;
				       printf("reg_E %6d\n", reg_E);
					break;
			case 0x5 : reg_F = result;
				       printf("reg_F %6d\n", reg_F);
					break;
			case 0x6 : reg_G = result;
				       printf("reg_G %6d\n", reg_G);
					break;
			case 0x7 : reg_H = result;
				       printf("reg_H %6d\n", reg_H);
					break;
			case 0x8 : reg_W = result;
				       printf("reg_W %6d\n", reg_W);
					break;
			case 0x9 : reg_K = result;
		        	   printf("reg_K %6d\n", reg_K);
					break;	
			case 0xA : reg_MR = result;
				       printf("reg_MR %6d\n", reg_MR);
					break;
			case 0xB : reg_LR = result;
				       printf("reg_LR %6d\n", reg_LR);
					break;
			case 0xC : reg_zero = result;
				       printf("reg_zero %6d\n", reg_zero);
					break;
			case 0xD : reg_t0 = result;
				       printf("reg_t0 %6d\n", reg_t0);
					break;
			case 0xE : reg_t1 = result;
				       printf("reg_t1 %6d\n", reg_t1);
					break;
			case 0xF : reg_t2 = result;
				       printf("reg_t2 %6d\n", reg_t2);
					break;
			default: 
					break;
		}

	PC = PC + 2;
    //return result;
}

void and (int operand1,int operand2) 
{
    switch(rs){                 
			case 0x0 : operand1 = reg_A;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x1 : operand1 = reg_B;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x2 : operand1 = reg_C;
				       printf ("operand1: %d\n",operand1);
					break;
			case 0x3 : operand1 = reg_D;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0x4 : operand1 = reg_E;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x5 : operand1 = reg_F;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x6 : operand1 = reg_G;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x7 : operand1 = reg_H;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x8 : operand1 = reg_W;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x9 : operand1 = reg_K;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0xA : operand1 = reg_MR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xB : operand1 = reg_LR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xC : operand1 = reg_zero;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xD : operand1 = reg_t0;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xE : operand1 = reg_t1;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xF : operand1 = reg_t2;
					   printf ("operand1: %d\n",operand1);
					break;
			default: 
					break;	
		}
		switch(rt){                    
			case 0x0 : operand2 = reg_A;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x1 : operand2 = reg_B;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x2 : operand2 = reg_C;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x3 : operand2 = reg_D;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0x4 : operand2 = reg_E;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x5 : operand2 = reg_F;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x6 : operand2 = reg_G;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x7 : operand2 = reg_H;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x8 : operand2 = reg_W;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x9 : operand2 = reg_K;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0xA : operand2 = reg_MR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xB : operand2 = reg_LR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xC : operand2 = reg_zero;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xD : operand2 = reg_t0;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xE : operand2 = reg_t1;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xF : operand2 = reg_t2;
				       printf ("operand2: %d\n",operand2);
					break;
			default: 
					break;	
		}

		result = operand1 & operand2;

		switch(rd){
			case 0x0 : reg_A = result;
					   printf("reg_A %6d\n", reg_A);
					break;
			case 0x1 : reg_B = result;
				       printf("reg_B %6d\n", reg_B);
					break;
			case 0x2 : reg_C = result;
					   printf("reg_C %6d\n", reg_C);
					break;
			case 0x3 : reg_D = result;
				       printf("reg_D %6d\n", reg_D);
					break;	
			case 0x4 : reg_E = result;
				       printf("reg_E %6d\n", reg_E);
					break;
			case 0x5 : reg_F = result;
				       printf("reg_F %6d\n", reg_F);
					break;
			case 0x6 : reg_G = result;
				       printf("reg_G %6d\n", reg_G);
					break;
			case 0x7 : reg_H = result;
				       printf("reg_H %6d\n", reg_H);
					break;
			case 0x8 : reg_W = result;
				       printf("reg_W %6d\n", reg_W);
					break;
			case 0x9 : reg_K = result;
		        	   printf("reg_K %6d\n", reg_K);
					break;	
			case 0xA : reg_MR = result;
				       printf("reg_MR %6d\n", reg_MR);
					break;
			case 0xB : reg_LR = result;
				       printf("reg_LR %6d\n", reg_LR);
					break;
			case 0xC : reg_zero = result;
				       printf("reg_zero %6d\n", reg_zero);
					break;
			case 0xD : reg_t0 = result;
				       printf("reg_t0 %6d\n", reg_t0);
					break;
			case 0xE : reg_t1 = result;
				       printf("reg_t1 %6d\n", reg_t1);
					break;
			case 0xF : reg_t2 = result;
				       printf("reg_t2 %6d\n", reg_t2);
					break;
			default: 
					break;	
		}

	PC = PC + 2;
    //return result;
}
void xor (int operand1,int operand2) 
{
    switch(rs){                 
			case 0x0 : operand1 = reg_A;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x1 : operand1 = reg_B;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x2 : operand1 = reg_C;
				       printf ("operand1: %d\n",operand1);
					break;
			case 0x3 : operand1 = reg_D;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0x4 : operand1 = reg_E;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x5 : operand1 = reg_F;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x6 : operand1 = reg_G;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x7 : operand1 = reg_H;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x8 : operand1 = reg_W;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x9 : operand1 = reg_K;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0xA : operand1 = reg_MR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xB : operand1 = reg_LR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xC : operand1 = reg_zero;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xD : operand1 = reg_t0;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xE : operand1 = reg_t1;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xF : operand1 = reg_t2;
					   printf ("operand1: %d\n",operand1);
					break;
			default: 
					break;	
		}
		switch(rt){                    
			case 0x0 : operand2 = reg_A;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x1 : operand2 = reg_B;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x2 : operand2 = reg_C;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x3 : operand2 = reg_D;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0x4 : operand2 = reg_E;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x5 : operand2 = reg_F;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x6 : operand2 = reg_G;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x7 : operand2 = reg_H;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x8 : operand2 = reg_W;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x9 : operand2 = reg_K;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0xA : operand2 = reg_MR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xB : operand2 = reg_LR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xC : operand2 = reg_zero;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xD : operand2 = reg_t0;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xE : operand2 = reg_t1;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xF : operand2 = reg_t2;
				       printf ("operand2: %d\n",operand2);
					break;
			default: 
					break;	
		}

		result = operand1 ^ operand2;

		switch(rd){
			case 0x0 : reg_A = result;
					   printf("reg_A %6d\n", reg_A);
					break;
			case 0x1 : reg_B = result;
				       printf("reg_B %6d\n", reg_B);
					break;
			case 0x2 : reg_C = result;
					   printf("reg_C %6d\n", reg_C);
					break;
			case 0x3 : reg_D = result;
				       printf("reg_D %6d\n", reg_D);
					break;	
			case 0x4 : reg_E = result;
				       printf("reg_E %6d\n", reg_E);
					break;
			case 0x5 : reg_F = result;
				       printf("reg_F %6d\n", reg_F);
					break;
			case 0x6 : reg_G = result;
				       printf("reg_G %6d\n", reg_G);
					break;
			case 0x7 : reg_H = result;
				       printf("reg_H %6d\n", reg_H);
					break;
			case 0x8 : reg_W = result;
				       printf("reg_W %6d\n", reg_W);
					break;
			case 0x9 : reg_K = result;
		        	   printf("reg_K %6d\n", reg_K);
					break;	
			case 0xA : reg_MR = result;
				       printf("reg_MR %6d\n", reg_MR);
					break;
			case 0xB : reg_LR = result;
				       printf("reg_LR %6d\n", reg_LR);
					break;
			case 0xC : reg_zero = result;
				       printf("reg_zero %6d\n", reg_zero);
					break;
			case 0xD : reg_t0 = result;
				       printf("reg_t0 %6d\n", reg_t0);
					break;
			case 0xE : reg_t1 = result;
				       printf("reg_t1 %6d\n", reg_t1);
					break;
			case 0xF : reg_t2 = result;
				       printf("reg_t2 %6d\n", reg_t2);
					break;
			default: 
					break;	
		}

	PC = PC + 2;
    //return result;
}
void nor (int operand1,int operand2) 
{
    switch(rs){                 
			case 0x0 : operand1 = reg_A;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x1 : operand1 = reg_B;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x2 : operand1 = reg_C;
				       printf ("operand1: %d\n",operand1);
					break;
			case 0x3 : operand1 = reg_D;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0x4 : operand1 = reg_E;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x5 : operand1 = reg_F;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x6 : operand1 = reg_G;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x7 : operand1 = reg_H;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x8 : operand1 = reg_W;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x9 : operand1 = reg_K;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0xA : operand1 = reg_MR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xB : operand1 = reg_LR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xC : operand1 = reg_zero;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xD : operand1 = reg_t0;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xE : operand1 = reg_t1;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xF : operand1 = reg_t2;
					   printf ("operand1: %d\n",operand1);
					break;
			default: 
					break;	
		}
		switch(rt){                    
			case 0x0 : operand2 = reg_A;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x1 : operand2 = reg_B;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x2 : operand2 = reg_C;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x3 : operand2 = reg_D;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0x4 : operand2 = reg_E;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x5 : operand2 = reg_F;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x6 : operand2 = reg_G;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x7 : operand2 = reg_H;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x8 : operand2 = reg_W;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x9 : operand2 = reg_K;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0xA : operand2 = reg_MR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xB : operand2 = reg_LR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xC : operand2 = reg_zero;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xD : operand2 = reg_t0;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xE : operand2 = reg_t1;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xF : operand2 = reg_t2;
				       printf ("operand2: %d\n",operand2);
					break;
			default: 
					break;	
		}

		result = ~(operand1 | operand2);

		switch(rd){
			case 0x0 : reg_A = result;
					   printf("reg_A %6d\n", reg_A);
					break;
			case 0x1 : reg_B = result;
				       printf("reg_B %6d\n", reg_B);
					break;
			case 0x2 : reg_C = result;
					   printf("reg_C %6d\n", reg_C);
					break;
			case 0x3 : reg_D = result;
				       printf("reg_D %6d\n", reg_D);
					break;	
			case 0x4 : reg_E = result;
				       printf("reg_E %6d\n", reg_E);
					break;
			case 0x5 : reg_F = result;
				       printf("reg_F %6d\n", reg_F);
					break;
			case 0x6 : reg_G = result;
				       printf("reg_G %6d\n", reg_G);
					break;
			case 0x7 : reg_H = result;
				       printf("reg_H %6d\n", reg_H);
					break;
			case 0x8 : reg_W = result;
				       printf("reg_W %6d\n", reg_W);
					break;
			case 0x9 : reg_K = result;
		        	   printf("reg_K %6d\n", reg_K);
					break;	
			case 0xA : reg_MR = result;
				       printf("reg_MR %6d\n", reg_MR);
					break;
			case 0xB : reg_LR = result;
				       printf("reg_LR %6d\n", reg_LR);
					break;
			case 0xC : reg_zero = result;
				       printf("reg_zero %6d\n", reg_zero);
					break;
			case 0xD : reg_t0 = result;
				       printf("reg_t0 %6d\n", reg_t0);
					break;
			case 0xE : reg_t1 = result;
				       printf("reg_t1 %6d\n", reg_t1);
					break;
			case 0xF : reg_t2 = result;
				       printf("reg_t2 %6d\n", reg_t2);
					break;
			default: 
					break;	
		}

	PC = PC + 2;
    //return result;
}
void sll (int operand1,int operand2) 
{
    switch(rs){                 
			case 0x0 : operand1 = reg_A;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x1 : operand1 = reg_B;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x2 : operand1 = reg_C;
				       printf ("operand1: %d\n",operand1);
					break;
			case 0x3 : operand1 = reg_D;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0x4 : operand1 = reg_E;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x5 : operand1 = reg_F;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x6 : operand1 = reg_G;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x7 : operand1 = reg_H;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x8 : operand1 = reg_W;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x9 : operand1 = reg_K;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0xA : operand1 = reg_MR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xB : operand1 = reg_LR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xC : operand1 = reg_zero;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xD : operand1 = reg_t0;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xE : operand1 = reg_t1;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xF : operand1 = reg_t2;
					   printf ("operand1: %d\n",operand1);
					break;
			default: 
					break;	
		}
		switch(rt){                    
			case 0x0 : operand2 = reg_A;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x1 : operand2 = reg_B;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x2 : operand2 = reg_C;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x3 : operand2 = reg_D;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0x4 : operand2 = reg_E;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x5 : operand2 = reg_F;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x6 : operand2 = reg_G;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x7 : operand2 = reg_H;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x8 : operand2 = reg_W;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x9 : operand2 = reg_K;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0xA : operand2 = reg_MR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xB : operand2 = reg_LR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xC : operand2 = reg_zero;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xD : operand2 = reg_t0;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xE : operand2 = reg_t1;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xF : operand2 = reg_t2;
				       printf ("operand2: %d\n",operand2);
					break;
			default: 
					break;	
		}

		result = operand1 << operand2;

		switch(rd){
			case 0x0 : reg_A = result;
					   printf("reg_A %6d\n", reg_A);
					break;
			case 0x1 : reg_B = result;
				       printf("reg_B %6d\n", reg_B);
					break;
			case 0x2 : reg_C = result;
					   printf("reg_C %6d\n", reg_C);
					break;
			case 0x3 : reg_D = result;
				       printf("reg_D %6d\n", reg_D);
					break;	
			case 0x4 : reg_E = result;
				       printf("reg_E %6d\n", reg_E);
					break;
			case 0x5 : reg_F = result;
				       printf("reg_F %6d\n", reg_F);
					break;
			case 0x6 : reg_G = result;
				       printf("reg_G %6d\n", reg_G);
					break;
			case 0x7 : reg_H = result;
				       printf("reg_H %6d\n", reg_H);
					break;
			case 0x8 : reg_W = result;
				       printf("reg_W %6d\n", reg_W);
					break;
			case 0x9 : reg_K = result;
		        	   printf("reg_K %6d\n", reg_K);
					break;	
			case 0xA : reg_MR = result;
				       printf("reg_MR %6d\n", reg_MR);
					break;
			case 0xB : reg_LR = result;
				       printf("reg_LR %6d\n", reg_LR);
					break;
			case 0xC : reg_zero = result;
				       printf("reg_zero %6d\n", reg_zero);
					break;
			case 0xD : reg_t0 = result;
				       printf("reg_t0 %6d\n", reg_t0);
					break;
			case 0xE : reg_t1 = result;
				       printf("reg_t1 %6d\n", reg_t1);
					break;
			case 0xF : reg_t2 = result;
				       printf("reg_t2 %6d\n", reg_t2);
					break;
			default: 
					break;	
		}

	PC = PC + 2;
    //return result;
}
void rot (int operand1,int operand2)
{
    switch(rs){                 
			case 0x0 : operand1 = reg_A;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x1 : operand1 = reg_B;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x2 : operand1 = reg_C;
				       printf ("operand1: %d\n",operand1);
					break;
			case 0x3 : operand1 = reg_D;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0x4 : operand1 = reg_E;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x5 : operand1 = reg_F;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x6 : operand1 = reg_G;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x7 : operand1 = reg_H;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x8 : operand1 = reg_W;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0x9 : operand1 = reg_K;
					   printf ("operand1: %d\n",operand1);
					break;	
			case 0xA : operand1 = reg_MR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xB : operand1 = reg_LR;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xC : operand1 = reg_zero;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xD : operand1 = reg_t0;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xE : operand1 = reg_t1;
					   printf ("operand1: %d\n",operand1);
					break;
			case 0xF : operand1 = reg_t2;
					   printf ("operand1: %d\n",operand1);
					break;
			default: 
					break;	
		}
		switch(rt){                    
			case 0x0 : operand2 = reg_A;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x1 : operand2 = reg_B;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x2 : operand2 = reg_C;
					   printf ("operand2: %d\n",operand2);
					break;
			case 0x3 : operand2 = reg_D;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0x4 : operand2 = reg_E;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x5 : operand2 = reg_F;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x6 : operand2 = reg_G;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x7 : operand2 = reg_H;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x8 : operand2 = reg_W;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0x9 : operand2 = reg_K;
				       printf ("operand2: %d\n",operand2);
					break;	
			case 0xA : operand2 = reg_MR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xB : operand2 = reg_LR;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xC : operand2 = reg_zero;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xD : operand2 = reg_t0;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xE : operand2 = reg_t1;
				       printf ("operand2: %d\n",operand2);
					break;
			case 0xF : operand2 = reg_t2;
				       printf ("operand2: %d\n",operand2);
					break;
			default: 
					break;	
		}

		result = (operand1 << operand2) | (operand1 >> (4 - operand2));

		switch(rd){
			case 0x0 : reg_A = result;
					   printf("reg_A %6d\n", reg_A);
					break;
			case 0x1 : reg_B = result;
				       printf("reg_B %6d\n", reg_B);
					break;
			case 0x2 : reg_C = result;
					   printf("reg_C %6d\n", reg_C);
					break;
			case 0x3 : reg_D = result;
				       printf("reg_D %6d\n", reg_D);
					break;	
			case 0x4 : reg_E = result;
				       printf("reg_E %6d\n", reg_E);
					break;
			case 0x5 : reg_F = result;
				       printf("reg_F %6d\n", reg_F);
					break;
			case 0x6 : reg_G = result;
				       printf("reg_G %6d\n", reg_G);
					break;
			case 0x7 : reg_H = result;
				       printf("reg_H %6d\n", reg_H);
					break;
			case 0x8 : reg_W = result;
				       printf("reg_W %6d\n", reg_W);
					break;
			case 0x9 : reg_K = result;
		        	   printf("reg_K %6d\n", reg_K);
					break;	
			case 0xA : reg_MR = result;
				       printf("reg_MR %6d\n", reg_MR);
					break;
			case 0xB : reg_LR = result;
				       printf("reg_LR %6d\n", reg_LR);
					break;
			case 0xC : reg_zero = result;
				       printf("reg_zero %6d\n", reg_zero);
					break;
			case 0xD : reg_t0 = result;
				       printf("reg_t0 %6d\n", reg_t0);
					break;
			case 0xE : reg_t1 = result;
				       printf("reg_t1 %6d\n", reg_t1);
					break;
			case 0xF : reg_t2 = result;
				       printf("reg_t2 %6d\n", reg_t2);
					break;
			default: 
					break;	
		}

	PC = PC + 2;
    //return result;
}

/////////////////////////////////////////////////////
////////////???????????????????????//////////////////
void bne (int operand1,int operand2) 
{
    int result;
    if (operand1 != operand2)
		PC = PC + result; //?????? allign ??????
    //return PC; //????????
}



// h/l reg ?????????????????????
//загрузить и сделать сдвиги???
//сделать регистр массивом???
void ldl (short addr) 
{
	reg_MR = memory[addr];
	printf("reg_MR %6d\n", reg_MR);

}
void ldh (short addr) 
{
	reg_MR = memory[addr];
	printf("reg_MR %6d\n", reg_MR);
}
void stl (short addr) 
{
	memory[addr] = reg_MR;
}
void sth (short addr) 
{
	memory[addr] = reg_MR;
}
void jmp (short addr)
{
	//JumpAddr???????
}
void jal (short addr)
{
	//JumpAddr???????
}
void jr (int operand1)
{

}
void jalr (int operand1)
{

}
