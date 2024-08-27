.section .data
hello:     
    .ascii "Hello world!"
helloLen = . - hello

.section .text
.global _start

_start:
    call print_hello
    movq $60, %rax
    xorq %rdi, %rdi
    syscall

print_hello:
    movq $1, %rax
    movq $1, %rdi
    leaq hello(%rip), %rsi
    movq $helloLen, %rdx
    syscall
    ret
