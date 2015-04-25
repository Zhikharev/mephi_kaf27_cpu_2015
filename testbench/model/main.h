#include <stdio.h>
#include <stdlib.h>

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
int PC;
int instr;
int addr;
int memory[1024];
FILE  *f;

int INITMEMORY();
DECODE(int);
STATISTICS();