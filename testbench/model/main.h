#include "stdio.h"
#include "svdpi.h"

#ifndef INCLUDED_CHIPKK
#define INCLUDED_CHIPKK

#ifdef __cplusplus
#define DPI_LINK_DECL  extern "C" 
#else
#define DPI_LINK_DECL 
#endif


extern int reg_A; 
extern int reg_B;
extern int reg_C;
extern int reg_D;
extern int reg_E;
extern int reg_F;
extern int reg_G;
extern int reg_H;
extern int reg_W; 
extern int reg_K; 
extern int reg_MR;
extern int reg_LR; 
extern int reg_zero; 
extern int reg_t0; 
extern int reg_t1;
extern int reg_t2;
extern int PC;
//extern int *PC;
extern int addr_reg;
extern int memory[];
extern FILE  *f;

DPI_LINK_DECL DPI_DLLESPEC openfile();
DPI_LINK_DECL DPI_DLLESPEC int readinstr();
DPI_LINK_DECL DPI_DLLESPEC decode(int);
DPI_LINK_DECL DPI_DLLESPEC int checkreg(int);
DPI_LINK_DECL DPI_DLLESPEC int checkmemory(int);
DPI_LINK_DECL DPI_DLLESPEC int add(int, int, int); 
DPI_LINK_DECL DPI_DLLESPEC int addi (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int or (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int and (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int xor (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int nor (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int sll (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int rot (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int bne (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int ldl (int);
DPI_LINK_DECL DPI_DLLESPEC int ldh (int);
DPI_LINK_DECL DPI_DLLESPEC int stl (int);
DPI_LINK_DECL DPI_DLLESPEC int sth (int);
DPI_LINK_DECL DPI_DLLESPEC int jmp (int);
DPI_LINK_DECL DPI_DLLESPEC int jal (int);
DPI_LINK_DECL DPI_DLLESPEC int jr (int);
DPI_LINK_DECL DPI_DLLESPEC int jalr (int);
DPI_LINK_DECL DPI_DLLESPEC nop;
#endif
