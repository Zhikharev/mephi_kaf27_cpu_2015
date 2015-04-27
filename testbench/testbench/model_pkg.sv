package model;

	import "DPI-C" function void test_sv_c_communication(input int val);
	import "DPI-C" function void OPENFILE();
	import "DPI-C" function READINSTRACTION();
	import "DPI-C" function DECODE(int);
	import "DPI-C" function CHEKREG(int);
    import "DPI-C" function CHECKMEMORY(int);
    import "DPI-C" function ADD(int,int,int);
    import "DPI-C" function ADDI(int,int,int);
    import "DPI-C" function OR(int,int,int);
    import "DPI-C" function AND(int,int,int);
    import "DPI-C" function XOR(int,int,int);
    import "DPI-C" function NOR(int,int,int);
    import "DPI-C" function SLL(int,int,int);
    import "DPI-C" function ROT(int,int,int);
    import "DPI-C" function BNE(int,int,int);
    import "DPI-C" function LDL(int);
    import "DPI-C" function LDH(int);
    import "DPI-C" function STL(int);
    import "DPI-C" function STH(int);
    import "DPI-C" function JMP(int);
    import "DPI-C" function JAL(int);
    import "DPI-C" function JR(int);
    import "DPI-C" function JARL(int);
    import "DPI-C" function NOP();


    
    
endpackage
