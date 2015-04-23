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

DPI_LINK_DECL DPI_DLLESPEC IMPORTMEMORY();
DPI_LINK_DECL DPI_DLLESPEC test_sv_c_communication(int);
DPI_LINK_DECL DPI_DLLESPEC DECODE(int);
DPI_LINK_DECL DPI_DLLESPEC int SETREG(int, int);
DPI_LINK_DECL DPI_DLLESPEC int GETREG(int);
DPI_LINK_DECL DPI_DLLESPEC int INITMEMORY();
DPI_LINK_DECL DPI_DLLESPEC IMPORTMEMORY();
DPI_LINK_DECL DPI_DLLESPEC SETMEMORY();
DPI_LINK_DECL DPI_DLLESPEC int GETMEMORY(int);
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
DPI_LINK_DECL DPI_DLLESPEC NOP;

#endif 
