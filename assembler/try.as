.text
add $a, $3, $zero
addi $1, $2, p1
ld res
.data
res 455
.text
addi $MR, $MR, sum
st res
nop (5)
.set
p1 8
sum 12
