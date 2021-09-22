[org 0x0100]
xor ax, ax

mov bx, num1 

add ax, [bx]
add bx, 2

add ax, [bx]
add bx, 2

add ax, [bx]
add bx, 2

mov [result], ax 

mov ax, 0x4c00
int 0x21


num1 : dw 5, 6, 7, 8, 10, 11, 12, 13
result : dw 0








