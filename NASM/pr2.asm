[org 0x0100]


jmp start


clrscr:

        push ax
        push es
        push di


        mov ax, 0xb800
        mov es, ax
        mov di, 0


        l2:
                mov word [es:di], 0x0720
                add di, 2

                cmp di, 4000
                jne l2


        pop di
        pop es
        pop ax

        ret





char: 
        
        push ax
        push bx
        push cx 
        push dx
        push si
        push di
        push es

        mov ax, 0xb800
        mov es, ax
        mov di, 3834  ;3682

        mov bh, 0x07

        mov bl, "@"


        mov word[es:di], bx

        




        mov ah, 0 ; service 0 – get keystroke
        int 0x16 ; call BIOS keyboard service
        
        cmp al, 98 ; is the Esc key pressed
        je  movright ; if no, check for next key
        
        cmp al , 97
        je movleft


        cmp al , 99
        je fire


        movright:
                mov word[es:di], 0x0720

                add di, 6

                mov word[es:di], bx

                mov ah, 0 ; service 0 – get keystroke
                int 0x16 ; call BIOS keyboard service
        
                cmp al, 98 ; is the Esc key pressed
                je  movright ; if no, check for next key
        
                cmp al , 97
                je movleft


                cmp al ,99
                je fire

                


        movleft:
                mov word[es:di], 0x0720

                sub di, 6

                mov word[es:di], bx


                mov ah, 0 ; service 0 – get keystroke
                int 0x16 ; call BIOS keyboard service
        
                cmp al, 98 ; is the Esc key pressed
                je  movright ; if no, check for next key
        
                cmp al , 97
                je movleft


                cmp al, 99
                je fire

        fire:


            mov si, di

            mov ch, 0x01
            mov cl, "i"

            mov word[es:si], cx

            




        exit:


                pop es
                pop di
                pop si
                pop dx
                pop cx
                pop bx
                pop ax

                ret 




start:

    call clrscr
    call char


    


    mov ax, 0x4c00
    int 0x21
