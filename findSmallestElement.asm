.data
iArraySize: .word 10
iArray: .word 12, 32, 13, 43, 17, 1, -2, -45, 0, 11
numResult: .asciiz "Minimum number: "
idxResult: .asciiz "\nIndex: "
.text
main:
### StartCodeHere:
la $a0, iArray
lw $a1, iArraySize
lw $t2, ($a0) # min
lw $t3, ($a0) # index
loop_array:
    lw $t0, ($a0)
    bge $t0, $t2, not_min # if (current_element >= current_min) {don't modify min} 
    move $t2, $t0
    not_min:
    addi $a1, $a1, -1
    addi $a0, $a0, 4
    j loop_array
### EndCodeHere:
# print your results
la $a0, numResult
li $v0, 4
syscall

move $a0, $s0
li $v0, 1
syscall

la $a0, idxResult
li $v0, 4
syscall

move $a0, $s1
li $v0, 1
syscall

#stop program
li $v0, 10
syscall
#your function start from here