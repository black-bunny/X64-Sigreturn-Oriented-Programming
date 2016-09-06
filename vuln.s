; nasm -felf64 vuln.s -o vuln.o
; ld vuln.o -o vuln

section .text
    global _start

vuln:
    sub rsp, 20

    mov rcx, reqlen
    mov rsi, req
    mov rdi, rsp
    rep movsb

    mov rax, 0
    mov rsi, rdi
    xor rdi, rdi
    mov rdx, 0x127
    syscall

    dec rax
    mov rdx, reqlen
    add rdx, rax
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    syscall

    add rsp, 20
    ret
 
_start:

    mov rdx, givelen
    mov rax, 1
    mov rdi, 1
    mov rsi, give
    syscall

    call vuln
    mov rax, 60
    mov rdi, 0
    syscall
    ret

section .data
    give: db 'Give me something: '
    givelen: equ $-give
    req: db 'You gave me:'
    reqlen: equ $-req
