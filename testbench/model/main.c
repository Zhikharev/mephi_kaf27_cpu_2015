//#include "stdint.h"
#include <stdio.h>
#include "main.h"

const N = 5;

void main()
{
	short instr;
	int k = 0;
	openfile();
	while(k != N){     /////�������� ������ � ����� �����������????????????
		instr = readinstr();
		decode(instr);
		//checkmemory(addr);
		k++;
	}
	// �������� ����� //������� ������ ������� ����������� ������� ���� �� ��� ���������
	printf ("Close file\n");
	if ( fclose (f) == EOF)
		printf ("ERROR\n");
	else printf ("Done\n");
}
