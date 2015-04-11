//#include "stdint.h"
#include <stdio.h>
#include "main.h"

const N = 5;

void main()
{
	short instr;
	int k = 0;
	openfile();
	while(k != N){     /////работает только с одной инструкцией????????????
		instr = readinstr();
		decode(instr);
		//checkmemory(addr);
		k++;
	}
	// Закрытие файла //сделать внутри функций возможность закрыть файл по его окончанию
	printf ("Close file\n");
	if ( fclose (f) == EOF)
		printf ("ERROR\n");
	else printf ("Done\n");
}
