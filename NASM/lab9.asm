[org 0x0100]
jmp start

rollNo : dw "20P-0147"
length: dw 8
	

; Subroutine that will clear screen of the dosbox

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

; ; Subroutine that will Print the Roll no on the dosbox screen 


printRollNO:
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
	mov di, 1992

	mov dh, 0x01
	mov si, [bp+6]
	mov cx, [bp+4]

	l2:

		mov dl, [si]

		mov word[es:di], dx

		add di, 2
		add si, 1
		

		loop l2



		pop es
		pop si
		pop di
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp

		ret 4







	start:




	call clrscr

	; pushing parameters 

	mov ax, rollNo
	push ax
	push word[length]

	call printRollNO

	mov ah, 0x01
	int 0x21

	mov ax, 0x4c00
	int 0x21
