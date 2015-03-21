#include "stdio.h"
#include "svdpi.h"

#ifndef INCLUDED_CHIPKK
#define INCLUDED_CHIPKK

#ifdef __cplusplus
#define DPI_LINK_DECL  extern "C" 
#else
#define DPI_LINK_DECL 
#endif



extern int32_t Acc_reg;
extern int32_t B_reg;
extern int32_t C_reg;
extern int32_t D_reg;
extern int32_t E_reg;
extern int32_t F_reg;
extern int32_t G_reg;

extern int32_t S_reg;

extern uint32_t SREG; //status register

extern int pcounter;//program counter

extern int32_t memory[];

extern FILE  *f;


DPI_LINK_DECL DPI_DLLESPEC int32_t setfile(void);
DPI_LINK_DECL DPI_DLLESPEC int32_t run(char);
DPI_LINK_DECL DPI_DLLESPEC int32_t chekreg(char);
DPI_LINK_DECL DPI_DLLESPEC int32_t checkmemory(int32_t);

#endif
