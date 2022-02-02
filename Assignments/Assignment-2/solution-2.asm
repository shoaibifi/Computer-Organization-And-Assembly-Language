[org 0x0100]

    jmp start

RollNO:     db   '20P-0147'   
length:      dw   8

screenClearAbove:     
    push es
    push ax
    push di

    mov  ax, 0xb800
    mov  es, ax
    mov  di, 0

    l1:
        mov  word [es:di], 0x0720
        add  di, 2
        cmp  di, 4000
        jne  l1

    pop  di 
    pop  ax
    pop  es
    ret 4


printscreen:
    push bp
    mov  bp, sp
    push es
    push ax
    push cx 
    push si 
    push di 

    mov ax, 0xb800 
    mov es, ax 
    mov di, 1992               


    mov si, [bp + 6]
    mov cx, [bp + 4]
    mov ah, 0x07 

    l2: 
        mov al, [si]
        mov [es:di], ax 
        add di, 2 
        add si, 1 
        
        loop l2


    pop di 
    pop si 
    pop cx 
    pop ax 
    pop es 
    pop bp 

    

    ret 4 



screenClear:     
    push es
    push ax
    push di

    mov  ax, 0xb800
    mov  es, ax
    mov  di, 2000

    l3:
        mov  word [es:di], 0x0720
        add  di, 2
        cmp  di, 4000
        jne  l3

    pop  di 
    pop  ax
    pop  es
    ret


start: 
    call screenClearAbove

    mov ax, RollNO 
    push ax 
    push word [length]
    call printscreen 

   ; call screenClear



    mov ah, 0x1   
    int 0x21 

    mov ax, 0x4c00 
    int 0x21 