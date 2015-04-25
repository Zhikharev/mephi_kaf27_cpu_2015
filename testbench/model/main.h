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
int k = 0;

int INITMEMORY();
OPENFILE();
int READINSTR();
DECODE(int);
STATISTICS();

int COUNT_ADD; 
int COUNT_ADDI;
int COUNT_OR;
int COUNT_AND;
int COUNT_XOR;
int COUNT_NOR;
int COUNT_SLL;
int COUNT_ROT;
int COUNT_BNE;
int COUNT_LDL;
int COUNT_LDH;
int COUNT_STL;
int COUNT_STH;
int COUNT_JMP;
int COUNT_JAL;
int COUNT_JR;
int COUNT_JALR;
int COUNT_NOP;