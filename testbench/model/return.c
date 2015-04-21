//return result
#include <stdio.h>
#include <math.h>
#include "model.h"

int reg_A; 
int reg_B;
int reg_C;
int reg_D;
int reg_E;
int reg_F;
int reg_G;
int reg_H;
int reg_W; 
int reg_K; 
int reg_MR;
int reg_LR; 
int reg_zero; 
int reg_t0;
int reg_t1;
int reg_t2;

int rd;
int rd_data;

int result (int rd, int rd_data)
{
	switch(rd){
			case 0x0 : reg_A = rd_data;
					   printf("reg_A %x\n", reg_A);
					   return reg_A;
					break;
			case 0x1 : reg_B = rd_data;
				       printf("reg_B %x\n", reg_B);
					   return reg_B;
					break;
			case 0x2 : reg_C = rd_data;
					   printf("reg_C %x\n", reg_C);
					   return reg_C;
					break;
			case 0x3 : reg_D = rd_data;
				       printf("reg_D %x\n", reg_D);
					   return reg_D;
					break;	
			case 0x4 : reg_E = rd_data;
				       printf("reg_E %x\n", reg_E);
					   return reg_E;
					break;
			case 0x5 : reg_F = rd_data;
				       printf("reg_F %x\n", reg_F);
					   return reg_F;
					break;
			case 0x6 : reg_G = rd_data;
				       printf("reg_G %x\n", reg_G);
					   return reg_G;
					break;
			case 0x7 : reg_H = rd_data;
				       printf("reg_H %x\n", reg_H);
					   return reg_H;
					break;
			case 0x8 : reg_W = rd_data;
				       printf("reg_W %x\n", reg_W);
					   return reg_W;
					break;
			case 0x9 : reg_K = rd_data;
		        	   printf("reg_K %x\n", reg_K);
					   return reg_K;
					break;	
			case 0xA : reg_MR = rd_data;
				       printf("reg_MR %x\n", reg_MR);
					   return reg_MR;
					break;
			case 0xB : reg_LR = rd_data;
				       printf("reg_LR %x\n", reg_LR);
					   return reg_LR;
					break;
			case 0xC : reg_zero = rd_data;
				       printf("reg_zero %x\n", reg_zero);
					   return reg_zero;
					break;
			case 0xD : reg_t0 = rd_data;
				       printf("reg_t0 %x\n", reg_t0);
					   return reg_t0;
					break;
			case 0xE : reg_t1 = rd_data;
				       printf("reg_t1 %x\n", reg_t1);
					   return reg_t1;
					break;
			case 0xF : reg_t2 = rd_data;
				       printf("reg_t2 %x\n", reg_t2);
					   return reg_t2;
					break;
			default : return 0;
					break;
		}
}