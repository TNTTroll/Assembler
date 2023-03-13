clear
nasm -f elf64 lab3.asm -l lab3.lst
ld -o lab3 lab3.o
./lab3
