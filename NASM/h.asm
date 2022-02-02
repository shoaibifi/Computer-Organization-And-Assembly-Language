[org 0x0100]

xor ax, ax 

mov ax, num1

mov bx, [ax]


mov ax, 0x4c00

int 0x21


num1 : db 5, 10
