//model_cpu
#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "svdpi.h"
#include "func.h"

uint32_t reg_A; // Register for storing hashsum
uint32_t reg_B;
uint32_t reg_C;
uint32_t reg_D;
uint32_t reg_E;
uint32_t reg_F;
uint32_t reg_G;
uint32_t reg_H;
uint32_t reg_W; // Register for storing words
uint32_t reg_K; // Register for storing constants
uint32_t reg_MR;// Memory Register
uint32_t reg_LR; // Link Register
uint32_t reg_zero; // Register for storing zero
uint32_t reg_t0; // Register for storing temporary variables
uint32_t reg_t1;
uint32_t reg_t2;
uint32_t PC;
uint16_t memory[1024]; 
//int pcounter = 0;//program counter

//Fetch
FILE *f;
int32_t setfile(void){
    char str[16];
    printf("Please set program file\n");
    scanf("%s", string);
    f = fopen(string, "r");
    if(f == NULL)
	{
		printf("ERROR opening file\n");
		return -1;
	}
    else 
	{
		printf(" All right\n");
		return 0;
}
////////main???????!!!!!!!!
///////связь с setfile!!!!!

int32_t run(char A){ //  char A ?????????????
	uint32_t i;
	uint32_t instr;
	uint32_t opcode;
	uint32_t rs;
	uint32_t rt;
	uint32_t rd;
	uint32_t imm;
	uint32_t Mtype;
	uint32_t addr;
	uint32_t operand1;
	uint32_t operand2;
	uint32_t result;

	i = 0;
	instr = 0;
	while (1)
	{
		//Установка текущей позиции
		printf ("Установка позиции на начало файла\n ");
		if (fseek (f,i,0)==0)
			printf ("Выполнено\n");
		else
			printf ("Ошибка\n");

		//Чтение строки из файла
		printf ("Считываем строку\n");
		if (fgets (instr, 16, f)==NULL)
		{
			printf ("Строка не считана\n");
			// Закрытие файла
			printf ("Закрытие файла\n");
			if ( fclose (f) == EOF)
				printf ("Ошибка\n");
			else printf ("Выполнено\n");
			return 0;
		}
		else
			printf (“%s\n”,instr);

		//Decode 
		opcode = (instr >> 12);
		rs = ((instr & 0x0F00) >> 8);
		imm = ((instr & 0x0F00) >> 8);
		rt = ((instr & 0x00F0) >> 4);
		rd = (instr & 0x000F);
		Mtype = ((instr & 0x0C00) >> 10);
		addr = (instr & 0x3FF);
		
		switch(rs){                      //все регистры использовать????????
			case 0x0 : operand1 = reg_A;
					break;
			case 0x1 : operand1 = reg_B;
					break;
			case 0x2 : operand1 = reg_C;
					break;
			case 0x3 : operand1 = reg_D;
					break;	
			case 0x4 : operand1 = reg_E;
					break;
			case 0x5 : operand1 = reg_F;
					break;
			case 0x6 : operand1 = reg_G;
					break;
			case 0x7 : operand1 = reg_H;
					break;
			case 0x8 : operand1 = reg_W;
					break;
			case 0x9 : operand1 = reg_K;
					break;	
			case 0xA : operand1 = reg_MR;
					break;
			case 0xB : operand1 = reg_LR;
					break;
			case 0xC : operand1 = reg_zero;
					break;
			case 0xD : operand1 = reg_t0;
					break;
			case 0xE : operand1 = reg_t1;
					break;
			case 0xF : operand1 = reg_t2;
					break;
			default: do_undefined; 
					break;	
		}
		switch(rt){                    //все регистры использовать????????
			case 0x0 : operand2 = reg_A;
					break;
			case 0x1 : operand2 = reg_B;
					break;
			case 0x2 : operand2 = reg_C;
					break;
			case 0x3 : operand2 = reg_D;
					break;	
			case 0x4 : operand2 = reg_E;
					break;
			case 0x5 : operand2 = reg_F;
					break;
			case 0x6 : operand2 = reg_G;
					break;
			case 0x7 : operand2 = reg_H;
					break;
			case 0x8 : operand2 = reg_W;
					break;
			case 0x9 : operand2 = reg_K;//imm = reg_K ???????
					break;	
			case 0xA : operand2 = reg_MR;
					break;
			case 0xB : operand2 = reg_LR;
					break;
			case 0xC : operand2 = reg_zero;
					break;
			case 0xD : operand2 = reg_t0;
					break;
			case 0xE : operand2 = reg_t1;
					break;
			case 0xF : operand2 = reg_t2;
					break;
			default: do_undefined; 
					break;	
		}
		//Execute
		//ALU
		switch (opcode) {
			case 0x0 : add(operand1, operand2); 
					break;
			case 0x1 : addi(imm, operand2); 
					break;
			case 0x2 : or(operand1, operand2);
					break; 
			case 0x3 : and(operand1, operand2);
					break;
			case 0x4 : xor(operand1, operand2);
					break;
			case 0x5 : nor(operand1, operand2);
					break;
			case 0x6 : sll(operand1, operand2);
					break;
			case 0x7 : rot(operand1, operand2);
					break;
			case 0x8 : bne(operand1, operand2);
					break;

			//что делать со вторым битом 0*???? он не определен!!!!
			//рассматривать два варианта????
			case 0x9 : switch (Mtype) {
							case 0: ldl(addr);
								break;
							case 1: ldl(addr);
								break;
							case 2: ldh(addr);
								break;
							case 3: ldh(addr);
								break;
					   }
					break;
			case 0xA : switch (Mtype) {
							case 0: stl(addr);
								break;
							case 1: stl(addr);
								break;
							case 2: sth(addr);
								break;
							case 3: sth(addr);
								break;
					   } 
					break;
			case 0xB : switch (Mtype) {
							case 0: jmp(addr);
								break;
							case 1: jal(addr);
								break;
							case 2: jr(operand1);
								break;
							case 3: jalr(operand1);
								break;
					   }
					break;
			case 0xC : 
					break;// nop
			default: do_undefined; 
					break;		
			}

		//Write Back
		switch(rd){
			case 0x0 : reg_A = result;
					   printf("reg_A %6d\n", reg_A);
					break;
			case 0x1 : reg_B = result;
				       printf("reg_A %6d\n", reg_B);
					break;
			case 0x2 : reg_C = result;
					   printf("reg_A %6d\n", reg_C);
					break;
			case 0x3 : reg_D = result;
				       printf("reg_A %6d\n", reg_D);
					break;	
			case 0x4 : reg_E = result;
				       printf("reg_A %6d\n", reg_E);
					break;
			case 0x5 : reg_F = result;
				       printf("reg_A %6d\n", reg_F);
					break;
			case 0x6 : reg_G = result;
				       printf("reg_A %6d\n", reg_G);
					break;
			case 0x7 : reg_H = result;
				       printf("reg_A %6d\n", reg_H);
					break;
			case 0x8 : reg_W = result;
				       printf("reg_A %6d\n", reg_W);
					break;
			case 0x9 : reg_K = result;
		        	   printf("reg_A %6d\n", reg_K);
					break;	
			case 0xA : reg_MR = result;
				       printf("reg_A %6d\n", reg_MR);
					break;
			case 0xB : reg_LR = result;
				       printf("reg_A %6d\n", reg_LR);
					break;
			case 0xC : reg_zero = result;
				       printf("reg_A %6d\n", reg_zero);
					break;
			case 0xD : reg_t0 = result;
				       printf("reg_A %6d\n", reg_t0);
					break;
			case 0xE : reg_t1 = result;
				       printf("reg_A %6d\n", reg_t1);
					break;
			case 0xF : reg_t2 = result;
				       printf("reg_A %6d\n", reg_t2);
					break;
			default: do_undefined; 
					break;	
		}
	i = i + 16;
	}
}
/////////???????????????
int32_t checkmemory(int32_t addr)
{
	return memory[addr];
};
/////// PC ????????????? 

