//main
#include <stdio.h>
#include "model.h"

FILE  *f;
main()
{
	int instr;
	//int *PC;
	int addr;
	int k = 0;
	int i = 0;
	int memory[1024];
	int t = 0;

	for(addr = 0; addr < 1024; addr++)
		{
			memory[addr] = t;
			printf("%x ",memory[addr]);
			t++;
		}

	//PC = &instr;
	openfile();
	while(!feof(f)){ 

		instr = readinstr();
		decode(instr);
		checkmemory(addr);
		//printf("Значение по адресу PC: %x\n", *PC); 
		k++;
	}
	printf ("Close file\n");
	if ( fclose (f) == EOF)
		printf ("ERROR\n");
	else printf ("Done\n");
	
	printf("***************************\n");
	printf("reg_A %x\n", reg_A);
	printf("reg_B %x\n", reg_B);
	printf("reg_C %x\n", reg_C);
	printf("reg_D %x\n", reg_D);
	printf("reg_E %x\n", reg_E);
	printf("reg_F %x\n", reg_F);
	printf("reg_G %x\n", reg_G);
	printf("reg_H %x\n", reg_H);
	printf("reg_W %x\n", reg_W);
	printf("reg_K %x\n", reg_K);
	printf("reg_MR %x\n", reg_MR);
	printf("reg_LR %x\n", reg_LR);
	printf("reg_zero %x\n", reg_zero);
	printf("reg_t0 %x\n", reg_t0);
	printf("reg_t1 %x\n", reg_t1);
	printf("reg_t2 %x\n", reg_t2);
	printf("****************************\n");
}
