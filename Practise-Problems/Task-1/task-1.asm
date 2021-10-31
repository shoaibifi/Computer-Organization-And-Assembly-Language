[org 0x0100]
    
    jmp start

    num : dw 1,4,7,9,2,6,4,1,7,4,3

    output: dw 0

    start:



       ; code to find minimum
        
        mov ax, [num]

        mov bx, 2

        maximum:

            cmp [num + bx], ax

            jbe notMaximum
            mov ax, [num + bx]

            notMaximum:
                add bx, 2
                cmp bx, 10
                jnz maximum

        
        ; Code to find minimum
       
        mov cx,[num +12]
       
        mov bx,14


        minimum:

       
        cmp [num+bx], cx
        ja  notMinimum

        mov cx, [num+bx]

        notMinimum:

            add bx, 2
            cmp bx, 22
            jnz minimum


        add ax, cx

        mov [output], ax


            
        mov ax, 0x4c00
        
        int 0x21
