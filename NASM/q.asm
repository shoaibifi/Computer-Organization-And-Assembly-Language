[org 0x100]


xor bx, bx

mov ax, [data]

mov bl, [data+1]

add ax, bx

mov [data +6], ax

mov ax, 0x4c00

int 0x21

data : dw 2, 20 ,0
