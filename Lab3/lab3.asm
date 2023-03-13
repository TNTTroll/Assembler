%include "../lib64.asm"

section .data
StartMsg db 10, "~ Enter your numbers ~", 10
StartLen equ $-StartMsg

ExitMsg db 10, "~ Your result ~", 10
ExitLen equ $-ExitMsg

section .bss
a resb 10
b resb 10
f resb 10

up resb 10
down resb 10

left resb 10
right resb 10

InBuf resb 10
OutBuf resb 4
lenIn equ $-InBuf
lenOut equ $-OutBuf

section	.text
   global _start    ; должно быть объявлено для использования gcc
	
_start:             ; сообщаем линкеру входную точку
    
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
    
    ; левая часть
        ; подсчет числителя и знаменателя
        mov eax, [a]
        mov ebx, [b]
        add eax, ebx
        mov [up], eax
    
        mov eax, [a]
        mov ebx, [b]
        sub eax, ebx
        mov [down], eax
        
        ; деление    
        mov eax, [up]
        idiv byte[down]
        mov [left], ax
        
    ; правая часть        
        ; деление    
        mov eax, [a]
        idiv byte[b]
        mov [right], eax
    
    ; проверка больше/меньше
        mov ebx, [a]
        mov eax, [left]
        cmp eax, [right]
        jl less
        add ebx, [b]
        jmp continue
        
        less: sub ebx, [b]
              
        continue:
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