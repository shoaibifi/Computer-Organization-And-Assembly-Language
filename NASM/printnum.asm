


I have create a function which will take the parameters one is name second the location where we want to print and the third parameter will be the length of the string.....Basically the parameters that we push are actually pushed in stack and in the subroutine we use bp parameter in the subroutine to acess the parameters  









[org 0x0100]
jmp start



name : dw "Shoaib Akhtar"
nameLength: dw  13 
caste: dw "Babar"
casteLength: dw 5


	
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


printname:
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
	mov di, 0


	mov si, [bp+8] ; parameter of string
	mov di, [bp+6] ; location where we want to print
	mov cx, [bp+4]

	mov al, 0x02


	l10:

		mov dl, [si]

		mov word[es:di], dx

		add di, 2

		add si, 1

		loop l10



		pop es
		pop si
		pop di
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp

		ret 6




printname1:
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

	l3:

		mov dl, [si]

		mov word[es:di], dx

		add di, 2
		add si, 1
		

		loop l3



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

	mov ax,1234
	push ax

	; This function will print the numbers that we will pass as a parameter


	; pushing parameters name and di location and length of the string 


	push name
	push 0
	push word[nameLength]

	call printname




	push caste
	push 30  ; this is the value of di where i want to print 
	push word[casteLength]

	call printname
	




	;These are the parameters that we will push 





	mov ah, 0x01
	int 0x21

	mov ax, 0x4c00
	int 0x21
