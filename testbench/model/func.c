//functions
#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include "func.h"

void add (uint32_t operand1, uint32_t operand2) 
{
    uint32_t result;
    result = operand1 + operand2;
    return result;
}

void addi (uint32_t imm, uint32_t operand2) 
{
    uint32_t result;
    result = imm + operand2;
    return result;
}

void or (uint32_t operand1, uint32_t operand2) 
{
    uint32_t result;
    result = operand1 | operand2;
    return result;
}
void and (uint32_t operand1, uint32_t operand2) 
{
    uint32_t result;
    result = operand1 & operand2;
    return result;
}
void xor (uint32_t operand1, uint32_t operand2) 
{
    uint32_t result;
    result = operand1 ^ operand2;
    return result;
}
void nor (uint32_t operand1, uint32_t operand2) 
{
    uint32_t result;
    result = ~(operand1 | operand2);
    return result;
}
void sll (uint32_t operand1, uint32_t operand2) 
{
    uint32_t result;
    result = operand1 << operand2;
    return result;
}
void rot (uint32_t operand1, uint32_t operand2) //?????????????????
{
    uint32_t result;
    result = (operand1 << operand2) | (operand1 >> 4 - operand2);
    return result;
}

/////////////////////////////////////////////////////
////////////???????????????????????//////////////////
void bne (uint32_t operand1, uint32_t operand2) 
{
    uint32_t result;
    if (operand1 != operand2)
		PC = PC + result; //?????? allign ??????
    return PC; //????????
}

// h/l reg ?????????????????????
void ldl (uint32_t addr) 
{
	reg_MR = memory[addr];
}
void ldh (uint32_t addr) 
{
	reg_MR = memory[addr];
}
void stl (uint32_t addr) 
{
	memory[addr] = reg_MR;
}
void sth (uint32_t addr) 
{
	memory[addr] = reg_MR;
}
//?????????????????????????
