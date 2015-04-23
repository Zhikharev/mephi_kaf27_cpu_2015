//main
#include "main.h"

OPENFILE(){

	printf ("Opening a file : ");
    //f = fopen ("prog.bin","rb");
    f = fopen ("prog2.bin","rb");
	//f = fopen ("file.bin","rb");
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

int READINSTR (){
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
		printf ("F: buffer[%d]: %x\n", g, buffer[g]);
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
	printf ("F: buffer[0]: %x\n", buffer[0]);
	instr = buffer[0] | buffer[1];
	printf ("F: instr: 0x%04x\n",instr);
    return (instr);
}

main()
{
	int k = 0;
	INITMEMORY();
	OPENFILE();
	while(!feof(f)){ 

		instr = READINSTR();
		DECODE(instr);
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
	printf("PC %x\n", PC);
	printf("****************************\n");

	printf("The number of instructions: k = %d\n", k-1);
}
