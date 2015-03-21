//prototypes of functions
#include <stdint.h>

#define CBIT 01
#define IBIT 02
#define EBIT 04

extern uint32_t SREG;


extern int32_t Acc_reg;
extern int32_t B_reg;
extern int32_t C_reg;
extern int32_t D_reg;
extern int32_t E_reg;
extern int32_t F_reg;
extern int32_t G_reg;
extern int32_t S_reg;

extern int pcounter;

extern int32_t memory[];

void add_cmd(uint8_t, uint32_t);
void sub_cmd(uint8_t, uint32_t);
void or_cmd(uint8_t, uint32_t);
void and_cmd(uint8_t, uint32_t);
void xor_cmd(uint8_t, uint32_t);
void ral_cmd(void);
void rar_cmd(void);
void lds_cmd(uint8_t, uint32_t);
void sts_cmd(uint32_t);
void mov_cmd(uint32_t);
void jmp_cmd(uint32_t);
void jmi_cmd(uint32_t);
void ret_cmd(void);


void error(void);

