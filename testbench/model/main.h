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
extern short memory[];
extern FILE  *f;

DPI_LINK_DECL DPI_DLLESPEC openfile();
DPI_LINK_DECL DPI_DLLESPEC short readinstr();
DPI_LINK_DECL DPI_DLLESPEC decode(short);
DPI_LINK_DECL DPI_DLLESPEC short checkmemory(short);
DPI_LINK_DECL DPI_DLLESPEC int add(int, int, int); 
DPI_LINK_DECL DPI_DLLESPEC int addi (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int or (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int and (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int xor (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int nor (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int sll (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int rot (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int bne (int, int, int);
DPI_LINK_DECL DPI_DLLESPEC int ldl (short);
DPI_LINK_DECL DPI_DLLESPEC int ldh (short);
DPI_LINK_DECL DPI_DLLESPEC int stl (short);
DPI_LINK_DECL DPI_DLLESPEC int sth (short);
DPI_LINK_DECL DPI_DLLESPEC int jmp (short);
DPI_LINK_DECL DPI_DLLESPEC int jal (short);
DPI_LINK_DECL DPI_DLLESPEC int jr (short);
DPI_LINK_DECL DPI_DLLESPEC int jalr (short);
DPI_LINK_DECL DPI_DLLESPEC nop;
#endif