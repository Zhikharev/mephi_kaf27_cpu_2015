package model;

	import "DPI-C" function void test_sv_c_communication(input int val);
	import "DPI-C" function void openfile();
	import "DPI-C" function readinstr();
	import "DPI-C" function decode(int);
	import "DPI-C" function checkreg(int);
    import "DPI-C" function checkmemory(int);
    import "DPI-C" function add(int,int,int);
    import "DPI-C" function addi(int,int,int);
    import "DPI-C" function or_1(int,int,int);
    import "DPI-C" function and_1(int,int,int);
    import "DPI-C" function xor_1(int,int,int);
    import "DPI-C" function nor_1(int,int,int);
    import "DPI-C" function sll(int,int,int);
    import "DPI-C" function rot(int,int,int);
    import "DPI-C" function bne(int,int,int);
    import "DPI-C" function ldl(int);
    import "DPI-C" function ldh(int);
    import "DPI-C" function stl(int);
    import "DPI-C" function sth(int);
    import "DPI-C" function jmp(int);
    import "DPI-C" function jal(int);
    import "DPI-C" function jr(int);
    import "DPI-C" function jalr(int);
    import "DPI-C" function nop();


    
    
endpackage
