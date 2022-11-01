# data segment
.data
.word 1
.word 2
# code segment
.text
.globl main
main:
addi $a0, $0, 10
add $t0, $0, $v0