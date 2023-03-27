clear
nasm -f elf64 lab4.asm -l lab4.lst
ld -o lab4 lab4.o
./lab4
