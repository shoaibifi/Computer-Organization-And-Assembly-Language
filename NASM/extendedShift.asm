[org 0x0100]


jmp start

num1: dw 0x40ff


dest : dw 0x40ff
src : dw 0x1001


start:

shl byte [num1], 1

rcl byte [num1 + 1], 1


mov ax, 0x4c00
int 0x21

