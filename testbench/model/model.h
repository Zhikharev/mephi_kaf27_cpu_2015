#include "stdio.h"
#include "svdpi.h"

#ifndef INCLUDED_CHIPKK
#define INCLUDED_CHIPKK

#ifdef __cplusplus
#define DPI_LINK_DECL  extern "C" 
#else
#define DPI_LINK_DECL 
#endif

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
int memory[1024];

int instr;
int opcode;
int rs;
int rt;
int rd;
int imm;   
int Mtype;
int addr;
int addr_rs;

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
int k;


DPI_LINK_DECL DPI_DLLESPEC void test_sv_c_communication(int arg);
DPI_LINK_DECL DPI_DLLESPEC decode(int, int);
DPI_LINK_DECL DPI_DLLESPEC int init_memory();
DPI_LINK_DECL DPI_DLLESPEC import_memory();
DPI_LINK_DECL DPI_DLLESPEC set_memory();
DPI_LINK_DECL DPI_DLLESPEC int get_memory(int);
DPI_LINK_DECL DPI_DLLESPEC int SETREG(int, int);
DPI_LINK_DECL DPI_DLLESPEC int GETREG(int);
DPI_LINK_DECL DPI_DLLESPEC int ADD(int, int, int); 
DPI_LINK_DECL DPI_DLLESPEC int ADDI (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int OR (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int AND (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int XOR (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int NOR (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int SLL (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int ROT (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int BNE (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int LDL (int);
DPI_LINK_DECL DPI_DLLESPEC int LDH (int);
DPI_LINK_DECL DPI_DLLESPEC int STL (int);
DPI_LINK_DECL DPI_DLLESPEC int STH (int);
DPI_LINK_DECL DPI_DLLESPEC int JMP (int);
DPI_LINK_DECL DPI_DLLESPEC int JAL (int);
DPI_LINK_DECL DPI_DLLESPEC int JR (int);
DPI_LINK_DECL DPI_DLLESPEC int JALR (int);
DPI_LINK_DECL DPI_DLLESPEC NOP();
DPI_LINK_DECL DPI_DLLESPEC allreg(int);
DPI_LINK_DECL DPI_DLLESPEC statistics(int);
DPI_LINK_DECL DPI_DLLESPEC int verbosity;
//DPI_LINK_DECL DPI_DLLESPEC set_verbosity(int);
DPI_LINK_DECL DPI_DLLESPEC write_results();
#endif 
