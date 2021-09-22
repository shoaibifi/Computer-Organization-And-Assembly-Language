[org 0x0100]

; initiallize stuff

mov ax, 0
mov cx, 3
mov bx, num1


outerloop:
    add ax, [bx]
    add bx,2
    mov 

    sub cx,1
    jnz outerloop

mov [result], ax

mov ax, 0x4c00
int 0x21

num1: dw 5, 6, 7, 8
result: dw 0



