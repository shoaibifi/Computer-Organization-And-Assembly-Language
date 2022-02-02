[org 0x0100]

jmp start

data: db "Shoaib"
len : dw 6
        

clrscr:

        push ax
        push es


        mov ax, 0xb800
        mov es, ax

        mov di, 0

        mov ah, 0x07
        mov al, 0x20
        mov cx, 2000

        l1:

        mov word[es:di], ax
        add di,2

        loop l1


        pop es
        pop ax


        ret

printstr:
        push bp
        mov bp, sp
        push ax
        push es
        push si
        push di
        push cx

        mov ax, 0xb800
        mov es, ax
        mov di, 0

        mov cx, [bp+4]
        mov si, [bp+6]

       
        l2:




           mov ah, 0x07


           mov al, [si]

           mov word[es:di], ax

           add di, 2

           add si, 1



           loop l2


        pop cx
        pop di
        pop si
        pop es
        pop ax
        pop bp

        ret 4









start:



        call clrscr

        push data
        push word [len]

        call printstr



        mov ah, 0x1
        int 0x21


        mov ax, 0x4c00
        int 0x21






