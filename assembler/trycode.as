addi $A, $zero, 0b0110 # Записали в регистр $A значение 0110
addi $B, $zero, 0b0010 # Записали в регистр $B значение 0010
and $C, $A, $B # В регистре $C значение 0010
or $A, $C, $A # В регистре $A значение 0110
addi $D, $zero, 0b0111 # Записали в регистр $D значение 0111
xor $B, $D, $B # В регистре $B значение 0101
# В результате $A=0110, $B=0101, $C=0010, $D=0111
