[org 0x0100]

jmp start



clrscr:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es

	mov ax, 0xb800
	mov es, ax

	mov ax, 0x0720
	mov di, 0
	mov cx, 2000

	cld 

	rep stosw



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

	mov ax, 0x4c00
	int 0x21