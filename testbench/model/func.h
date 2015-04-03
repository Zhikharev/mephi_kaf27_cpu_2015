//prototypes of functions
#include <stdint.h>

#define CBIT 01
#define IBIT 02
#define EBIT 04

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

void add (uint32_t, uint32_t); 
void addi (uint32_t, uint32_t);
void or (uint32_t, uint32_t);
void and (uint32_t, uint32_t);
void xor (uint32_t, uint32_t);
void nor (uint32_t, uint32_t);
void sll (uint32_t, uint32_t);
void rot (uint32_t, uint32_t);
void bne (uint32_t, uint32_t);
void ldl (uint32_t);
void ldh (uint32_t);
void stl (uint32_t);
void sth (uint32_t);
void jmp (uint32_t);
void jal (uint32_t);
void jr (uint32_t);
void jalr (uint32_t);


