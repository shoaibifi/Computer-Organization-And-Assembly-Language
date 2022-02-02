[org 0x0100]

jmp start


message : dw "shoaib akhtar"
length  : dw 13
	

clrscr:

	push ax
	push es
	push di


	mov ax, 0xb800
	mov es, ax
	mov di, 0


	l1:
		mov word [es:di], 0x0720
		add di, 2

		cmp di, 4000
		jne l1


	pop di
	pop es
	pop ax

	ret


printstr:
	
	
	push bp
	mov bp, sp

	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es



	mov ax, 0xb800
	mov es, ax
	mov di, 3840


	mov ah , 0x81 ;  0x87  for Blinking  and 0x01

	mov si,[bp+6] ; adress of first character in this case its "s"

	mov cx , [bp+4] ; lenghth


	l2:
		mov al, [si]

		mov word[es:di],ax

		add si, 1

		add di, 2

		dec cx

		cmp cx, 0

		jne l2


			
		pop es
		pop di
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp



		ret 4 


start:
	
	call clrscr


	push word message
	push word [length]

	call printstr


	mov ah, 0x1
	int 0x21


	mov ax, 0x4c00
	int 0x21	