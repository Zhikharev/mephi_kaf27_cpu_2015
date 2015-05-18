.data
W0 0x61626380
W1 0
W2 0
W3 0
W4 0
W5 0
W6 0
W7 0
W8 0 
W9 0
W10 0
W11 0
W12 0
W13 0
W14 0x18000000
W15 0

A 0x01234567
B 0x89abcdef
C 0xfedcba98
D 0x76543210

CONSTG 0x5A827999
CONSTH 0x6ED9EBA1

s 19

.text
ADDI $ZERO, $ZERO, 0
LD s
ADD $T0, $T0, $MR

LD A
ADD $A, $A, $MR
LD B
ADD $B, $B, $MR
LD C
ADD $C, $C, $MR
LD D
ADD $D, $D, $MR

ADD AA, AA, $A
ADD BB, BB, $B
ADD CC, CC, $C
ADD DD, DD, $D

.def
AA $T1
BB $T2
CC $G
DD $H

.text
# 1 РАУНД 

LD W0
ADDI $K, $ZERO, 3
JAL A1
LD W1
ADDI $K, $ZERO, 7
JAL D1
LD W2
ADDI $K, $ZERO, 11
JAL C1
LD W3
ADD $K, $ZERO, $T0
JAL B1

LD W4
ADDI $K, $ZERO, 3
JAL A1
LD W5
ADDI $K, $ZERO, 7
JAL D1
LD W6
ADDI $K, $ZERO, 11
JAL C1
LD W7
ADD $K, $ZERO, $T0
JAL B1

LD W8
ADDI $K, $ZERO, 3
JAL A1
LD W9
ADDI $K, $ZERO, 7
JAL D1
LD W10
ADDI $K, $ZERO, 11
JAL C1
LD W11
ADD $K, $ZERO, $T0
JAL B1

LD W12
ADDI $K, $ZERO, 3
JAL A1
LD W13
ADDI $K, $ZERO, 7
JAL D1
LD W14
ADDI $K, $ZERO, 11
JAL C1
LD W15
ADD $K, $ZERO, $T0
JAL B1

# 2 РАУНД  

LD W0
ADDI $K, $ZERO, 3
JAL A2
LD W4
ADDI $K, $ZERO, 5
JAL D2
LD W8
ADDI $K, $ZERO, 9
JAL C2
LD W12
ADDI $K, $ZERO, 13
JAL B2

LD W1
ADDI $K, $ZERO, 3
JAL A2
LD W5
ADDI $K, $ZERO, 5
JAL D2
LD W9
ADDI $K, $ZERO, 9
JAL C2
LD W13
ADDI $K, $ZERO, 13
JAL B2

LD W2
ADDI $K, $ZERO, 3
JAL A2
LD W6
ADDI $K, $ZERO, 5
JAL D2
LD W10
ADDI $K, $ZERO, 9
JAL C2
LD W14
ADDI $K, $ZERO, 13
JAL B2

LD W3
ADDI $K, $ZERO, 3
JAL A2
LD W7
ADDI $K, $ZERO, 5
JAL D2
LD W11
ADDI $K, $ZERO, 9
JAL C2
LD W15
ADDI $K, $ZERO, 13
JAL B2

# 3 РАУНД  

LD W0
ADDI $K, $ZERO, 3
JAL A3
LD W8
ADDI $K, $ZERO, 9
JAL D3
LD W4
ADDI $K, $ZERO, 11
JAL C3
LD W12
ADDI $K, $ZERO, 15
JAL B3

LD W2
ADDI $K, $ZERO, 3
JAL A3
LD W10
ADDI $K, $ZERO, 9
JAL D3
LD W6
ADDI $K, $ZERO, 11
JAL C3
LD W14
ADDI $K, $ZERO, 15
JAL B3

LD W1
ADDI $K, $ZERO, 3
JAL A3
LD W9
ADDI $K, $ZERO, 9
JAL D3
LD W5
ADDI $K, $ZERO, 11
JAL C3
LD W13
ADDI $K, $ZERO, 15
JAL B3

LD W3
ADDI $K, $ZERO, 3
JAL A3
LD W11
ADDI $K, $ZERO, 9
JAL D3
LD W7
ADDI $K, $ZERO, 11
JAL C3
LD W15
ADDI $K, $ZERO, 15
JAL B3


#SUBPROGRAMS F

A1:

# a = (a + F(b,c,d) + X[k]) <<< s        
# a = (a + ((b & c) | (~b & d)) + X[k]) rol s
# a = (a  + (d ^ (b & (c ^ d))) + X[k]) rol s

XOR $E, $C, $D
AND $E, $B, $E
XOR $E, $D, $E
ADD $A, $A, $E
ADD $A, $A, $MR # MR будут загружаться слова из .data
ROT $A, $A, $K # K будут загружаться значения сдвига s из .data

D1:

# d = (d  + (c ^ (a & (b ^ c))) + X[k]) rol s

XOR $E, $B, $C
AND $E, $A, $E
XOR $E, $C, $E
ADD $D, $D, $E
ADD $D, $D, $MR
ROT $D, $D, $K

C1:

# c = (c  + (b ^ (d & (a ^ b))) + X[k]) rol s

XOR $E, $A, $B
AND $E, $D, $E
XOR $E, $B, $E
ADD $C, $C, $E
ADD $C, $C, $MR
ROT $C, $C, $K

B1:

# b = (b  + (a ^ (c & (d ^ a))) + X[k]) rol s

XOR $E, $D, $A
AND $E, $C, $E
XOR $E, $A, $E
ADD $B, $B, $E
ADD $B, $B, $MR
ROT $B, $B, $K


#SUBPROGRAMS G

A2:

# a = (a + G(b,c,d) + X[k] + 5A827999H) <<< s 
# a = (a + ((b & c) | (b & d)|(c & d)) + X[k] + 0x5A827999) rol s
# a = (a + ((b & c) | (d & (b | c))) + X[k] + 0x5A827999) rol s

OR $E, $B, $C
AND $E, $D, $E
AND $F, $B, $C
OR $F, $F, $E
ADD $A, $A, $F
ADD $A, $A, $MR
LD CONSTG
ADD $A, $A, $MR
ROT $A, $A, $K

D2:

# d = (d + ((a & b) | (c & (a | b))) + X[k] + 0x5A827999) rol s

OR $E, $A, $B
AND $E, $C, $E
AND $F, $A, $B
OR $F, $F, $E
ADD $D, $D, $F
ADD $D, $D, $MR
LD CONSTG
ADD $D, $D, $MR
ROT $D, $D, $K

C2:

# c = (c + ((d & a) | (b & (d | a))) + X[k] + 0x5A827999) rol s

OR $E, $A, $D
AND $E, $B, $E
AND $F, $A, $D
OR $F, $F, $E
ADD $C, $C, $F
ADD $C, $C, $MR
LD CONSTG
ADD $C, $C, $MR
ROT $C, $C, $K

B2:

# b = (b + ((c & d) | (a & (c | d))) + X[k] + 0x5A827999) rol s

OR $E, $C, $D
AND $E, $A, $E
AND $F, $C, $D
OR $F, $F, $E
ADD $B, $B, $F
ADD $B, $B, $MR
LD CONSTG
ADD $B, $B, $MR
ROT $B, $B, $K


#SUBPROGRAMS H

A3:

# a = (a + H(b,c,d) + X[k] + 0x6ED9EBA1) <<< s 
# a = (a + (b ^ c ^ d) + X[k] + 0x6ED9EBA1) rol s

XOR $E, $B, $C
XOR $E, $E, $D
ADD $A, $A, $E
ADD $A, $A, $MR
LD CONSTH
ADD $A, $A, $MR
ROT $A, $A, $K

D3:

# d = (d + (a ^ b ^ c) + X[k] + 0x6ED9EBA1) rol s

XOR $E, $B, $C
XOR $E, $E, $A
ADD $D, $D, $E
ADD $D, $D, $MR
LD CONSTH
ADD $D, $D, $MR
ROT $D, $D, $K

C3:

# c = (c + (d ^ a ^ b) + X[k] + 0x6ED9EBA1) rol s

XOR $E, $B, $A
XOR $E, $E, $D
ADD $C, $C, $E
ADD $C, $C, $MR
LD CONSTH
ADD $C, $C, $MR
ROT $C, $C, $K

B3:

# b = (b + (c ^ d ^ a) + X[k] + 0x6ED9EBA1) rol s

XOR $E, $D, $A
XOR $E, $E, $C
ADD $B, $B, $E
ADD $B, $B, $MR
LD CONSTH
ADD $B, $B, $MR
ROT $B, $B, $K

ADD $A, $A, $AA
ADD $B, $B, $BB
ADD $C, $C, $CC
ADD $D, $D, $DD