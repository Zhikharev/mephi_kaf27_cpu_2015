#include "main.h"
//*************************************************
// Author: Svetlana Makarova 
// Project: MEPHI CPU
// Filename: main.c
// Descriptions: 
//		Part of the program for working with files 
//*************************************************

open_file(){

    char string[16];
    printf("Please set program file\n");
    scanf("%s", string);
    f = fopen(string, "rb");
	printf ("Opening a file : ");
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
}

int read_instr(){
	int buffer[2];
	int g = 0;

	printf ("Set the position at the beginning of the file\n ");

	if (fseek (f, PC, SEEK_SET) == 0)
		printf ("Done\n");
	else
		printf ("ERROR\n");

	printf("PC: %x\n",PC);

	while (g < 2) {
		buffer[g] = fgetc (f);
		if (buffer[g] == EOF)
		{
			if ( feof (f) != 0)
				printf ("Reading the file finished\n");
			else
				printf ("ERROR\n");
		}
		g++;
	}
	buffer[0] = buffer[0] << 8;
	instr = buffer[0] | buffer[1];
	printf ("F: instr: 0x%04x\n",instr);
    return (instr);
}

main()
{	
	init_memory();
	open_file();
	while(!feof(f)){ 

		instr = read_instr();
		decode(instr);
	}
	printf ("Close file\n");
	if ( fclose (f) == EOF)
		printf ("ERROR\n");
	else printf ("Done\n");
	allreg();
	statistics();
	write_results();
}
