//functions
#include <stdio.h>
#include <math.h>
#include "model.h"

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
//int *PC;
int memory[1024]; 

int opcode;
int rs;
int rt;
int rd;
int imm;   
int Mtype;
int addr;
int addr_rs;

int add (int rs, int rt, int rd) 
{
	int rs_data;
	int rt_data;
	int rd_data;

	switch(rs){                 
			case 0x0 : rs_data = reg_A;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x1 : rs_data = reg_B;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x2 : rs_data = reg_C;
				       printf ("rs_data: %x\n",rs_data);
					break;
			case 0x3 : rs_data = reg_D;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0x4 : rs_data = reg_E;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x5 : rs_data = reg_F;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x6 : rs_data = reg_G;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x7 : rs_data = reg_H;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x8 : rs_data = reg_W;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x9 : rs_data = reg_K;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0xA : rs_data = reg_MR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xB : rs_data = reg_LR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xC : rs_data = reg_zero;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xD : rs_data = reg_t0;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xE : rs_data = reg_t1;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xF : rs_data = reg_t2;
					   printf ("rs_data: %x\n",rs_data);
					break;
			default: 
					break;	
		}
	switch(rt){                    
			case 0x0 : rt_data = reg_A;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x1 : rt_data = reg_B;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x2 : rt_data = reg_C;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x3 : rt_data = reg_D;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0x4 : rt_data = reg_E;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x5 : rt_data = reg_F;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x6 : rt_data = reg_G;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x7 : rt_data = reg_H;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x8 : rt_data = reg_W;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x9 : rt_data = reg_K;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0xA : rt_data = reg_MR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xB : rt_data = reg_LR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xC : rt_data = reg_zero;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xD : rt_data = reg_t0;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xE : rt_data = reg_t1;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xF : rt_data = reg_t2;
				       printf ("rt_data: %x\n",rt_data);
					break;
			default: 
					break;	
		}

	rd_data = rs_data + rt_data;
	result (rd, rd_data);
	PC = PC + 2;
	//PC = PC + 1;
    //printf("PC: %p\n", PC);
    return rd_data;
}


int addi (int imm, int rt, int rd) 
{	
	int rt_data;
	int rd_data;

	switch(rt){                    
			case 0x0 : rt_data = reg_A;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x1 : rt_data = reg_B;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x2 : rt_data = reg_C;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x3 : rt_data = reg_D;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0x4 : rt_data = reg_E;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x5 : rt_data = reg_F;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x6 : rt_data = reg_G;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x7 : rt_data = reg_H;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x8 : rt_data = reg_W;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x9 : rt_data = reg_K;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0xA : rt_data = reg_MR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xB : rt_data = reg_LR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xC : rt_data = reg_zero;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xD : rt_data = reg_t0;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xE : rt_data = reg_t1;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xF : rt_data = reg_t2;
				       printf ("rt_data: %x\n",rt_data);
					break;
			default: 
					break;	
		}

	rd_data = imm + rt_data;
	result (rd, rd_data);
	PC = PC + 2;
	//PC = PC + 1;
	//printf("PC: %p\n", PC);
    return rd_data;
}

int or (int rs, int rt, int rd) 
{	
	int rs_data;
	int rt_data;
	int rd_data;

	switch(rs){                 
			case 0x0 : rs_data = reg_A;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x1 : rs_data = reg_B;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x2 : rs_data = reg_C;
				       printf ("rs_data: %x\n",rs_data);
					break;
			case 0x3 : rs_data = reg_D;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0x4 : rs_data = reg_E;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x5 : rs_data = reg_F;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x6 : rs_data = reg_G;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x7 : rs_data = reg_H;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x8 : rs_data = reg_W;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x9 : rs_data = reg_K;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0xA : rs_data = reg_MR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xB : rs_data = reg_LR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xC : rs_data = reg_zero;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xD : rs_data = reg_t0;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xE : rs_data = reg_t1;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xF : rs_data = reg_t2;
					   printf ("rs_data: %x\n",rs_data);
					break;
			default: 
					break;	
		}
	switch(rt){                    
			case 0x0 : rt_data = reg_A;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x1 : rt_data = reg_B;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x2 : rt_data = reg_C;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x3 : rt_data = reg_D;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0x4 : rt_data = reg_E;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x5 : rt_data = reg_F;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x6 : rt_data = reg_G;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x7 : rt_data = reg_H;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x8 : rt_data = reg_W;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x9 : rt_data = reg_K;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0xA : rt_data = reg_MR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xB : rt_data = reg_LR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xC : rt_data = reg_zero;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xD : rt_data = reg_t0;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xE : rt_data = reg_t1;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xF : rt_data = reg_t2;
				       printf ("rt_data: %x\n",rt_data);
					break;
			default: 
					break;	
		}

	rd_data = rs_data | rt_data;
	result (rd, rd_data);
	PC = PC + 2;
	//PC = PC + 1;
	//printf("PC: %p\n", PC);
    return rd_data;
}

int and (int rs, int rt, int rd) 
{
	int rs_data;
	int rt_data;
	int rd_data;

	switch(rs){                 
			case 0x0 : rs_data = reg_A;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x1 : rs_data = reg_B;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x2 : rs_data = reg_C;
				       printf ("rs_data: %x\n",rs_data);
					break;
			case 0x3 : rs_data = reg_D;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0x4 : rs_data = reg_E;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x5 : rs_data = reg_F;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x6 : rs_data = reg_G;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x7 : rs_data = reg_H;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x8 : rs_data = reg_W;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x9 : rs_data = reg_K;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0xA : rs_data = reg_MR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xB : rs_data = reg_LR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xC : rs_data = reg_zero;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xD : rs_data = reg_t0;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xE : rs_data = reg_t1;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xF : rs_data = reg_t2;
					   printf ("rs_data: %x\n",rs_data);
					break;
			default: 
					break;	
		}
	switch(rt){                    
			case 0x0 : rt_data = reg_A;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x1 : rt_data = reg_B;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x2 : rt_data = reg_C;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x3 : rt_data = reg_D;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0x4 : rt_data = reg_E;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x5 : rt_data = reg_F;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x6 : rt_data = reg_G;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x7 : rt_data = reg_H;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x8 : rt_data = reg_W;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x9 : rt_data = reg_K;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0xA : rt_data = reg_MR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xB : rt_data = reg_LR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xC : rt_data = reg_zero;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xD : rt_data = reg_t0;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xE : rt_data = reg_t1;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xF : rt_data = reg_t2;
				       printf ("rt_data: %x\n",rt_data);
					break;
			default: 
					break;	
		}

	rd_data = rs_data & rt_data;
	result (rd, rd_data);
	PC = PC + 2;
	//PC = PC + 1;
	//printf("PC: %p\n", PC);
    return rd_data;
}
int xor (int rs, int rt, int rd) 
{
   	int rs_data;
	int rt_data;
	int rd_data;

	switch(rs){                 
			case 0x0 : rs_data = reg_A;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x1 : rs_data = reg_B;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x2 : rs_data = reg_C;
				       printf ("rs_data: %x\n",rs_data);
					break;
			case 0x3 : rs_data = reg_D;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0x4 : rs_data = reg_E;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x5 : rs_data = reg_F;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x6 : rs_data = reg_G;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x7 : rs_data = reg_H;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x8 : rs_data = reg_W;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x9 : rs_data = reg_K;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0xA : rs_data = reg_MR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xB : rs_data = reg_LR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xC : rs_data = reg_zero;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xD : rs_data = reg_t0;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xE : rs_data = reg_t1;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xF : rs_data = reg_t2;
					   printf ("rs_data: %x\n",rs_data);
					break;
			default: 
					break;	
		}
	switch(rt){                    
			case 0x0 : rt_data = reg_A;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x1 : rt_data = reg_B;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x2 : rt_data = reg_C;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x3 : rt_data = reg_D;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0x4 : rt_data = reg_E;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x5 : rt_data = reg_F;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x6 : rt_data = reg_G;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x7 : rt_data = reg_H;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x8 : rt_data = reg_W;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x9 : rt_data = reg_K;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0xA : rt_data = reg_MR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xB : rt_data = reg_LR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xC : rt_data = reg_zero;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xD : rt_data = reg_t0;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xE : rt_data = reg_t1;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xF : rt_data = reg_t2;
				       printf ("rt_data: %x\n",rt_data);
					break;
			default: 
					break;	
		}

	rd_data = rs_data ^ rt_data;
	result (rd, rd_data);
	PC = PC + 2;
	//PC = PC + 1;
	//printf("PC: %p\n", PC);
    return rd_data;
}
int nor (int rs, int rt, int rd) 
{
    int rs_data;
	int rt_data;
	int rd_data;

	switch(rs){                 
			case 0x0 : rs_data = reg_A;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x1 : rs_data = reg_B;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x2 : rs_data = reg_C;
				       printf ("rs_data: %x\n",rs_data);
					break;
			case 0x3 : rs_data = reg_D;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0x4 : rs_data = reg_E;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x5 : rs_data = reg_F;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x6 : rs_data = reg_G;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x7 : rs_data = reg_H;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x8 : rs_data = reg_W;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x9 : rs_data = reg_K;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0xA : rs_data = reg_MR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xB : rs_data = reg_LR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xC : rs_data = reg_zero;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xD : rs_data = reg_t0;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xE : rs_data = reg_t1;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xF : rs_data = reg_t2;
					   printf ("rs_data: %x\n",rs_data);
					break;
			default: 
					break;	
		}
	switch(rt){                    
			case 0x0 : rt_data = reg_A;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x1 : rt_data = reg_B;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x2 : rt_data = reg_C;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x3 : rt_data = reg_D;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0x4 : rt_data = reg_E;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x5 : rt_data = reg_F;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x6 : rt_data = reg_G;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x7 : rt_data = reg_H;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x8 : rt_data = reg_W;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x9 : rt_data = reg_K;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0xA : rt_data = reg_MR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xB : rt_data = reg_LR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xC : rt_data = reg_zero;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xD : rt_data = reg_t0;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xE : rt_data = reg_t1;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xF : rt_data = reg_t2;
				       printf ("rt_data: %x\n",rt_data);
					break;
			default: 
					break;	
		}

	rd_data = ~(rs_data | rt_data);
	result (rd, rd_data);
	PC = PC + 2;
	//PC = PC + 1;
	//printf("PC: %p\n", PC);
    return rd_data;
}
int sll (int rs, int rt, int rd) 
{
   	int rs_data;
	int rt_data;
	int rd_data;

	switch(rs){                 
			case 0x0 : rs_data = reg_A;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x1 : rs_data = reg_B;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x2 : rs_data = reg_C;
				       printf ("rs_data: %x\n",rs_data);
					break;
			case 0x3 : rs_data = reg_D;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0x4 : rs_data = reg_E;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x5 : rs_data = reg_F;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x6 : rs_data = reg_G;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x7 : rs_data = reg_H;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x8 : rs_data = reg_W;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x9 : rs_data = reg_K;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0xA : rs_data = reg_MR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xB : rs_data = reg_LR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xC : rs_data = reg_zero;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xD : rs_data = reg_t0;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xE : rs_data = reg_t1;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xF : rs_data = reg_t2;
					   printf ("rs_data: %x\n",rs_data);
					break;
			default: 
					break;	
		}
	switch(rt){                    
			case 0x0 : rt_data = reg_A;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x1 : rt_data = reg_B;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x2 : rt_data = reg_C;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x3 : rt_data = reg_D;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0x4 : rt_data = reg_E;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x5 : rt_data = reg_F;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x6 : rt_data = reg_G;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x7 : rt_data = reg_H;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x8 : rt_data = reg_W;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x9 : rt_data = reg_K;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0xA : rt_data = reg_MR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xB : rt_data = reg_LR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xC : rt_data = reg_zero;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xD : rt_data = reg_t0;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xE : rt_data = reg_t1;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xF : rt_data = reg_t2;
				       printf ("rt_data: %x\n",rt_data);
					break;
			default: 
					break;	
		}

	rd_data = rs_data << rt_data;
	result (rd, rd_data);
	PC = PC + 2;
	//PC = PC + 1;
	//printf("PC: %p\n", PC);
    return rd_data;
}
int rot (int rs, int rt, int rd)
{
   	int rs_data;
	int rt_data;
	int rd_data;

	switch(rs){                 
			case 0x0 : rs_data = reg_A;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x1 : rs_data = reg_B;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x2 : rs_data = reg_C;
				       printf ("rs_data: %x\n",rs_data);
					break;
			case 0x3 : rs_data = reg_D;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0x4 : rs_data = reg_E;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x5 : rs_data = reg_F;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x6 : rs_data = reg_G;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x7 : rs_data = reg_H;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x8 : rs_data = reg_W;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x9 : rs_data = reg_K;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0xA : rs_data = reg_MR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xB : rs_data = reg_LR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xC : rs_data = reg_zero;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xD : rs_data = reg_t0;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xE : rs_data = reg_t1;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xF : rs_data = reg_t2;
					   printf ("rs_data: %x\n",rs_data);
					break;
			default: 
					break;	
		}
	switch(rt){                    
			case 0x0 : rt_data = reg_A;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x1 : rt_data = reg_B;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x2 : rt_data = reg_C;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x3 : rt_data = reg_D;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0x4 : rt_data = reg_E;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x5 : rt_data = reg_F;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x6 : rt_data = reg_G;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x7 : rt_data = reg_H;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x8 : rt_data = reg_W;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x9 : rt_data = reg_K;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0xA : rt_data = reg_MR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xB : rt_data = reg_LR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xC : rt_data = reg_zero;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xD : rt_data = reg_t0;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xE : rt_data = reg_t1;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xF : rt_data = reg_t2;
				       printf ("rt_data: %x\n",rt_data);
					break;
			default: 
					break;	
		}

	rd_data = (rs_data << rt_data) | (rs_data >> (4 - rt_data));
	result (rd, rd_data);
	PC = PC + 2;
	//PC = PC + 1;
	//printf("PC: %p\n", PC);
    return rd_data;
}

int bne (int rs, int rt, int rd) 
{		   
	int rs_data;
	int rt_data;
	int rd_data;

	switch(rs){                 
			case 0x0 : rs_data = reg_A;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x1 : rs_data = reg_B;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x2 : rs_data = reg_C;
				       printf ("rs_data: %x\n",rs_data);
					break;
			case 0x3 : rs_data = reg_D;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0x4 : rs_data = reg_E;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x5 : rs_data = reg_F;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x6 : rs_data = reg_G;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x7 : rs_data = reg_H;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x8 : rs_data = reg_W;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0x9 : rs_data = reg_K;
					   printf ("rs_data: %x\n",rs_data);
					break;	
			case 0xA : rs_data = reg_MR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xB : rs_data = reg_LR;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xC : rs_data = reg_zero;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xD : rs_data = reg_t0;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xE : rs_data = reg_t1;
					   printf ("rs_data: %x\n",rs_data);
					break;
			case 0xF : rs_data = reg_t2;
					   printf ("rs_data: %x\n",rs_data);
					break;
			default: 
					break;	
		}
	switch(rt){                    
			case 0x0 : rt_data = reg_A;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x1 : rt_data = reg_B;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x2 : rt_data = reg_C;
					   printf ("rt_data: %x\n",rt_data);
					break;
			case 0x3 : rt_data = reg_D;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0x4 : rt_data = reg_E;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x5 : rt_data = reg_F;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x6 : rt_data = reg_G;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x7 : rt_data = reg_H;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x8 : rt_data = reg_W;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0x9 : rt_data = reg_K;
				       printf ("rt_data: %x\n",rt_data);
					break;	
			case 0xA : rt_data = reg_MR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xB : rt_data = reg_LR;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xC : rt_data = reg_zero;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xD : rt_data = reg_t0;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xE : rt_data = reg_t1;
				       printf ("rt_data: %x\n",rt_data);
					break;
			case 0xF : rt_data = reg_t2;
				       printf ("rt_data: %x\n",rt_data);
					break;
			default: 
					break;	
		}
	
	switch(rd){                    
			case 0x0 : rd_data = reg_A;
					   printf ("rd_data: %x\n",rd_data);
					break;
			case 0x1 : rd_data = reg_B;
					   printf ("rd_data: %x\n",rd_data);
					break;
			case 0x2 : rd_data = reg_C;
					   printf ("rd_data: %x\n",rd_data);
					break;
			case 0x3 : rd_data = reg_D;
				       printf ("rd_data: %x\n",rd_data);
					break;	
			case 0x4 : rd_data = reg_E;
				       printf ("rd_data: %x\n",rd_data);
					break;
			case 0x5 : rd_data = reg_F;
				       printf ("rd_data: %x\n",rd_data);
					break;
			case 0x6 : rd_data = reg_G;
				       printf ("rd_data: %x\n",rd_data);;
					break;
			case 0x7 : rd_data = reg_H;
				       printf ("rd_data: %x\n",rd_data);
					break;
			case 0x8 : rd_data = reg_W;
				       printf ("rd_data: %x\n",rd_data);
					break;
			case 0x9 : rd_data = reg_K;
				       printf ("rd_data: %x\n",rd_data);
					break;	
			case 0xA : rd_data = reg_MR;
				       printf ("rd_data: %x\n",rd_data);
					break;
			case 0xB : rd_data = reg_LR;
				       printf ("rd_data: %x\n",rd_data);
					break;
			case 0xC : rd_data = reg_zero;
				       printf ("rd_data: %x\n",rd_data);
					break;
			case 0xD : rd_data = reg_t0;
				       printf ("rd_data: %x\n",rd_data);
					break;
			case 0xE : rd_data = reg_t1;
				       printf ("rd_data: %x\n",rd_data);
					break;
			case 0xF : rd_data = reg_t2;
				       printf ("rd_data: %x\n",rd_data);
					break;
			default: 
					break;	
		}

    if (rs_data != rt_data)
		PC = PC + rd_data; //?????? allign ??????
	printf("PC: %d\n", PC);
	//printf("PC: %p\n", PC);
	//PC = PC + 1;//???????????????
	//return *PC; //????????
    return PC; //????????
}

int ldl (int addr) 
{
	reg_MR = memory[addr];
	printf("reg_MR %6d\n", reg_MR);
	PC = PC + 2;
	//PC = PC + 1;
	//printf("PC: %p\n", PC);
	return reg_MR;
}
int ldh (int addr) 
{
	reg_MR = memory[addr];
	reg_MR = reg_MR << 16; //можно сделать сдвиг, чтобы MR[15:0] занулились, или нам нужна эта часть регистра???
	printf("reg_MR %6d\n", reg_MR);
	PC = PC + 2;
	//PC = PC + 1;
	//printf("PC: %p\n", PC);
	return reg_MR;
}
 int stl (int addr) 
{
    reg_MR = reg_MR & 0x00FF;
	memory[addr] = reg_MR;
	PC = PC + 2;
	//PC = PC + 1;
	//printf("PC: %p\n", PC);
	return memory[addr];
}
 int sth (int addr) 
{   
	reg_MR = reg_MR >> 16;
	memory[addr] = reg_MR;
	PC = PC + 2;
	//PC = PC + 1;
	//printf("PC: %p\n", PC);
	return memory[addr];
}
 int jmp (int addr)
{
	PC = addr;
	//PC = PC + 1;
	//printf("PC: %p\n", PC);
	//return *PC;//?????????????
	return PC;//?????????????
}
int jal (int addr)
{
	reg_LR = PC + 2;
	PC = addr;
	//PC = PC + 1;//????????????
    //printf("PC: %p\n", PC);
	//return *PC;//?????????????
	return PC;//?????
}

//PC = адрес регистра или значение регистра???????
int jr (int addr_rs)
{
	switch(addr_rs){                 
			case 0x0 : PC = reg_A;
					   printf ("PC: %d\n",PC);
					   //PC = &reg_A;//???????????
					   //printf ("PC: %p\n",PC);
					break;
			case 0x1 : PC = reg_B;
					   printf ("PC: %x\n",PC);
					break;
			case 0x2 : PC = reg_C;
				       printf ("PC: %x\n",PC);
					break;
			case 0x3 : PC = reg_D;
					   printf ("PC: %x\n",PC);
					break;	
			case 0x4 : PC = reg_E;
					   printf ("PC: %x\n",PC);
					break;
			case 0x5 : PC = reg_F;
					   printf ("PC: %x\n",PC);
					break;
			case 0x6 : PC = reg_G;
					   printf ("PC: %x\n",PC);
					break;
			case 0x7 : PC = reg_H;
					   printf ("PC: %x\n",PC);
					break;
			case 0x8 : PC = reg_W;
					   printf ("PC: %x\n",PC);
					break;
			case 0x9 : PC = reg_K;
					   printf ("PC: %x\n",PC);
					break;	
			case 0xA : PC = reg_MR;
					   printf ("PC: %x\n",PC);
					break;
			case 0xB : PC = reg_LR;
					   printf ("PC: %x\n",PC);
					break;
			case 0xC : PC = reg_zero;
					   printf ("PC: %x\n",PC);
					break;
			case 0xD : PC = reg_t0;
					   printf("PC: %x\n", PC);
					break;
			case 0xE : PC = reg_t1;
					   printf("PC: %x\n", PC);
					break;
			case 0xF : PC = reg_t2;
					   printf("PC: %x\n", PC);
					break;
			default: 
					break;	
		}
	//PC = PC + 1;
    //printf("PC: %p\n", PC);
	//return *PC;//?????????????
	return PC;//?????????????
}
int jalr (int addr_rs)
{	
	reg_LR = PC + 2;
	switch(addr_rs){                 
			case 0x0 : PC = reg_A;
					   printf ("PC: %x\n",PC);
					   //PC = &reg_A;//???????????
					   //printf ("PC: %p\n",PC);
					break;
			case 0x1 : PC = reg_B;
					   printf ("PC: %x\n",PC);
					break;
			case 0x2 : PC = reg_C;
				       printf ("PC: %x\n",PC);
					break;
			case 0x3 : PC = reg_D;
					   printf ("PC: %x\n",PC);
					break;	
			case 0x4 : PC = reg_E;
					   printf ("PC: %x\n",PC);
					break;
			case 0x5 : PC = reg_F;
					   printf ("PC: %x\n",PC);
					break;
			case 0x6 : PC = reg_G;
					   printf ("PC: %x\n",PC);
					break;
			case 0x7 : PC = reg_H;
					   printf ("PC: %x\n",PC);
					break;
			case 0x8 : PC = reg_W;
					   printf ("PC: %x\n",PC);
					break;
			case 0x9 : PC = reg_K;
					   printf ("PC: %x\n",PC);
					break;	
			case 0xA : PC = reg_MR;
					   printf ("PC: %x\n",PC);
					break;
			case 0xB : PC = reg_LR;
					   printf ("PC: %x\n",PC);
					break;
			case 0xC : PC = reg_zero;
					   printf ("PC: %x\n",PC);
					break;
			case 0xD : PC = reg_t0;
					   printf("PC: %x\n", PC);
					break;
			case 0xE : PC = reg_t1;
					   printf("PC: %x\n", PC);
					break;
			case 0xF : PC = reg_t2;
					   printf("PC: %x\n", PC);
					break;
			default: 
					break;	
		}
	//PC = PC + 1;
    //printf("PC: %p\n", PC);
	//return *PC;//?????????????
	return PC;//?????????????
}
