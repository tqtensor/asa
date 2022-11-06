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
    lw $s0, ($a0) # initialize value of first index as minimum
    li $s3, 0 # start index with 0
    li $s1, -1 # 
    for_loop:
        beq $a1, $zero, print_and_exit
        lw $t0, ($a0)
        bge $t0, $s0, not_min
        move $s0, $t0
        move $s1, $s3

    not_min:
        addi $s3, $s3, 1
        addi $a1, $a1, -1
        addi $a0, $a0, 4 # 4 bytes => move to the next index of array
        j for_loop
### EndCodeHere:
 # print your results
    print_and_exit:
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