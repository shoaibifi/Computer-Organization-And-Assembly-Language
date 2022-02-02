[org 0x0100]

mov ax , 0x8787

xor ax, ax ; BY doing this the ax will become 0000

mov al, [num1]

mov bl, [num1+1]

add al, bl

mov bl, [num1+2]

add al, bl

mov [num1+3], al


mov ax , 0x4c00

int 0x21

num1: db 5, 10, 8,10




