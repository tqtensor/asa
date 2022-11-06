.data
    prompt: .asciiz "Please input Number A and B for sum operation: \n"
    result: .asciiz "Result: "
.text

main:
    la      $a0, prompt     
    li      $v0, 4           
    syscall

    # get user's input 1 -> a0
    li      $v0, 5
    syscall               
    add     $a0, $v0, $zero
    # get user's input 1 -> a1
    li      $v0, 5     
    syscall   
    add     $a1, $v0, $zero 

    subu    $sp, $sp,12             
    sw      $a0, 0($sp)
    sw      $a1, 4($sp) 
    
    jal     calculate
    lw      $t2, ($sp)

    la      $a0, result
    li      $v0, 4
    syscall
    li      $v0, 1
    move    $a0, $t2
    syscall
    li      $v0, 10
    syscall

calculate:  
    lw      $t0, 0($sp)
    lw      $t1, 4($sp)
    add     $t3, $t0, $t1
    sw      $t3, 8($sp)
    addu    $sp, $sp, 8
    jr      $ra         # return