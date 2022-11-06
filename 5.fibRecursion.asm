.data
    prompt: .asciiz "Please input the number of fibonacci to calculate (2 <= x <= 20): "
    result: .asciiz "Result: "
.text

main:
    la   $a0, prompt     
    li   $v0, 4           
    syscall               
    li   $v0, 5        
    syscall               
    add  $a0, $v0, $zero  # user input

    jal     fibo
    move    $t2, $v0

    la      $a0, result
    li      $v0, 4
    syscall
    li      $v0, 1
    move    $a0, $t2
    syscall
    li      $v0, 10
    syscall

main_exit:
    li      $v0, 10
    syscall

fibo:
    bgt     $a0, 1, fibo_full        # go to calculate fibo or return 
    move    $v0, $a0                 
    jr      $ra                     

fibo_full:
    subu    $sp, $sp,12              # create space for push to pointer
    sw      $ra, 4($sp)
    sw      $a0, 8($sp)

    sub     $a0, $a0,1               # fibo(n-1)
    jal     fibo                     # recursive call
    sw      $v0, 0($sp)              # save result in our frame (in extra cell)

    sub     $a0, $a0,1               # fibo(n-2)
    jal     fibo                     # recursive call

    lw      $t0, 0($sp)              # restore fibo(n-1) from our stack frame
    add     $v0, $t0, $v0            # result is: fibo(n-1) + fibo(n-2)

    # pop from stack
    lw      $ra, 4($sp)
    lw      $a0, 8($sp)
    addu    $sp, $sp, 12

    jr      $ra                     # return