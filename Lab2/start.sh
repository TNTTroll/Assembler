clear
nasm -f elf64 lab2.asm -l lab2.lst
ld -o lab2 lab2.o
./lab2
