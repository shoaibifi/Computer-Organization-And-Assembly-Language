[org 0x0100]

mov ax, 0


outerloop:
    add ax,6
    
    cmp ax,36
    
    jne outerloop
 
mov ax, 0x4c00

int 0x21

