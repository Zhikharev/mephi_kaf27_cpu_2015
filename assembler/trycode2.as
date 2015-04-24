.text
addi fuf, $zero, 12 # A=0001100 (12)
addi $C, $zero, 10 # C=0001010 (10)
addi $C, $C, 14 # C=0011000 (24)
addi $MR, $C, 14 # MR=0100110 (38)
st 0xCD # В адресе памяти 0xCD число 0100110 (38)
add $B, $MR, $A # B=0110010 (50)
jmp prg # Перейти по метке prg, пропустив всё промежуточное
and $B, $A, $MR # B=0000100
prg:
addi $B, $B, oops # B=0010000
addi $MR, $MR, 1 # MR=0100111
ld 0xCD # MR=0100110
.set
oops 12
.def
fuf $A
