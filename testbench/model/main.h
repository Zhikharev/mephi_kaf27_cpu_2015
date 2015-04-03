#include "stdio.h"
#include "svdpi.h"

#ifndef INCLUDED_CHIPKK
#define INCLUDED_CHIPKK

#ifdef __cplusplus
#define DPI_LINK_DECL  extern "C" 
#else
#define DPI_LINK_DECL 
#endif


extern uint32_t reg_A; 
extern uint32_t reg_B;
extern uint32_t reg_C;
extern uint32_t reg_D;
extern uint32_t reg_E;
extern uint32_t reg_F;
extern uint32_t reg_G;
extern uint32_t reg_H;
extern uint32_t reg_W; 
extern uint32_t reg_K; 
extern uint32_t reg_MR;
extern uint32_t reg_LR; 
extern uint32_t reg_zero; 
extern uint32_t reg_t0; 
extern uint32_t reg_t1;
extern uint32_t reg_t2;
extern uint32_t PC;
extern uint16_t memory[];
//extern int pcounter;
extern FILE  *f;


DPI_LINK_DECL DPI_DLLESPEC int32_t setfile(void);
DPI_LINK_DECL DPI_DLLESPEC int32_t run(char);//????????????????
DPI_LINK_DECL DPI_DLLESPEC int32_t checkmemory(int32_t);

#endif