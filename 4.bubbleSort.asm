.data
    cSpace: .asciiz " "
    cEndLine: .asciiz "\n"
    iArraySize: .word 10
    iArray: .word 12, 32, 13, 43, 17, 1, -2, -45, 0, 11
.text
main:
    # print integer array
    lw $t0, iArraySize # load size of iArray
    la $t1, iArray # load base address of iArray
    jal print
    ### StartCodeHere:
    lw $t0, iArraySize # reset t0 as array size
    addi $t0, $t0, -1 # we will loop through a number of index equal size - 1
    outer_loop:
        ble $t0, $zero, out
        li $t5, 0 # curr index
        inner_loop:
            bge  $t5, $t0, cont
            sll  $t8, $t5, 2
            add  $t8, $t8, $t1 # iArray[curr]
            addi $t4, $t5, 1
            sll  $t9, $t4, 2
            add  $t9, $t9, $t1 # iArray[next]
            lw   $t6, ($t8)
            lw   $t7, ($t9)
            bge  $t6, $t7, swap
            addi $t5, $t5, 1		    
            j inner_loop
        swap:
            sw $t6, ($t9)
            sw $t7, ($t8)
            addi $t5, $t5, 1
            j inner_loop
        cont:
            addi $t0, $t0, -1
            j outer_loop 

    ### EndCodeHere:
out:
    # print integer array
    lw $t0, iArraySize # load size of iArray
    la $t1, iArray # Load base address of iArray
    jal print
    #stop program
    li $v0, 10
    syscall
    print: # print function
        add $t2, $0, $0 # index of iArray
    loopPrint:
        beqz $t0, exitPrint # Check condition
        li $v0, 1 # service 1 is print integer
        add $t3, $t1, $t2 # load desired value into $a0
        lw $a0, ($t3)
        syscall
        li $v0, 4
        la $a0, cSpace # print space just like separator
        syscall
        addi $t0, $t0, -1 # decrease loop count
        addi $t2, $t2, 4  # increase index
        b loopPrint
    exitPrint:
        li $v0, 4
        la $a0, cEndLine # print end line
        syscall
        jr $ra # end of print
        #your function start from here