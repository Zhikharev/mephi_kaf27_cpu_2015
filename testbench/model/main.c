//#include "stdint.h"
#include <stdio.h>
#include "main.h"

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
}
