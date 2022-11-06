.data
    myarray: .word 0 : 20
    size: .word 20
    prompt: .asciiz "Please input the number of fibonacci to calculate (2 <= x <= 20): "
    result: .asciiz "Result: "
.text
main:
    la   $s0, myarray     # load  address of array
    la   $s5, size        # load address of size variable
    lw   $s5, 0($s5)      # load array size
    
    la   $a0, prompt     
    li   $v0, 4           
    syscall               
    li   $v0, 5        
    syscall               
    add  $s5, $v0, $zero  # user input
    
    li   $s2, 1           
    sw   $s2, 0($s0)      # arr[0] = 1
    sw   $s2, 4($s0)      # arr[1] = arr[0] = 1
    addi $s6, $s5, -2     # size minus the first 2 element
    
    # Loop to compute each Fibonacci number using the previous two Fib. numbers.
while: 
    lw   $s3, 0($s0)      # value in F[n-2]
    lw   $s4, 4($s0)      # value in F[n-1]
    add  $s2, $s3, $s4    # F[n] = F[n-1] + F[n-2]
    sw   $s2, 8($s0)      # store to next index in array
    addi $s0, $s0, 4      # increase address to known Fib. number storage
    addi $s6, $s6, -1     # decrement loop counter
    bgt  $s6, $zero, while  # while loop
    lw   $t3 4($s0)

    la      $a0, result
    li      $v0, 4
    syscall
    li      $v0, 1
    move    $a0, $t3
    syscall
    li      $v0, 10
    syscall