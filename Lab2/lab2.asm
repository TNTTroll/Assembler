%include "../lib64.asm"

section .data
StartMsg db 10, "~ Enter your numbers ~", 10
StartLen equ $-StartMsg

ExitMsg db 10, "~ Your result ~", 10
ExitLen equ $-ExitMsg

section .bss
a resb 10
b resb 10
k resb 10
f resb 10

InBuf resb 10
OutBuf resb 4
lenIn equ $-InBuf
lenOut equ $-OutBuf

section .text
    global _start

_start:
    
    ; вывод строки
    mov rax, 1
    mov rdi, 1
    mov rsi, StartMsg
    mov rdx, StartLen
    syscall
    
    ; ввод переменных
    mov rax, 0
    mov rdi, 0
    mov rsi, InBuf
    mov rdx, lenIn
    syscall
 
    mov rdi, InBuf
    call StrToInt64
    cmp rbx, 0
    jne 0
    mov [a], rax
    
    mov rax, 0
    mov rdi, 0
    mov rsi, InBuf
    mov rdx, lenIn
    syscall
 
    mov rdi, InBuf
    call StrToInt64
    cmp rbx, 0
    jne 0
    mov [b], rax
    
    mov rax, 0
    mov rdi, 0
    mov rsi, InBuf
    mov rdx, lenIn
    syscall
 
    mov rdi, InBuf
    call StrToInt64
    cmp rbx, 0
    jne 0
    mov [k], rax
    
    ; подсчет
    mov ebx, [k]   ; знаменатель 
    imul ebx, [k]
    add ebx, 2
    mov eax, [b] ; левая часть
    imul eax, [b]
    imul eax, [b]
    idiv eax
    mov ebx, [a] ; правая часть
    imul ebx, [b]
    sub ebx, eax ; ответ
    
    mov [f], ebx
    
    ; вывод
    mov rax, 1
    mov rdi, 1
    mov rsi, ExitMsg 
    mov rdx, ExitLen
    syscall 
    
    mov rsi, OutBuf
    mov rax, [f] 
    call IntToStr64
    
    mov rax, 1
    mov rdi, 1
    mov rsi, OutBuf 
    mov rdx, lenOut 
    syscall 
    
    ; выход
    mov rax, 60
    xor rdi, rdi
    syscall