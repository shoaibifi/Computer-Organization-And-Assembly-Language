[org 0x0100]

xor ax,ax

mov bx, num1

mov ax,[bx]

mov ax, 0x4c00

int 0x21

num1 : dw 5,10
