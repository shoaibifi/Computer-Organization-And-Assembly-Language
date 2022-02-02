[org 0x0100]

mov dx, 27
mov bx, 3

mov ax,dx
div cx



mov ax, 0x4c00

int 0x21
