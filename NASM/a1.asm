[org 0x0100]


jmp start

n : dw 2

Factorial:
	push bp

	mov bp, sp

	push ax
	push cx

	mov ax, [bp+4]
	mov cx, ax

	cmp cx , 1
	je directFactorial

	findFactorial:
		sub cx, 1

		mul cx
		
		cmp cx, 1

		jne findFactorial

	directFactorial:


	mov di, ax ; Moving the calculated factorial in the "di register" its kind of global variable.  



	pop cx
	pop ax
	pop bp

	ret 2 ; By doing this sp will be on the same location where it was before calling the factorial function




summation:
	push bp
	mov bp, sp
	sub sp, 6

	; [numerator = bp -2 ] , [denominator =  bp-4], [seriessum = bp-6] [n = bp + 4]

	push ax
	push bx
	push cx
	push dx
	push si
	push di

	mov dx, [bp+4] ; dx = 2 which is "n" the parameter.

	add dx, 1
	mov si, 0 ; This is basically "K" which starts from 0 and will end upto "n"


	Series:

		Numerator:
			mov ax, si
			mov cx, 2
			div cl

			cmp ah, 0
			jne odd

		even:
			mov word[bp-2], 1 
	
		;If k is even it means that the nnumerator will be "1" because "-1" even power it will be "1" and "-1" odd power it will-"1" 
			
			jmp Denominator




		odd:
			mov word[bp-2], -1


		Denominator:

			mov ax, si
			mul cl

			add ax, 1

			push ax  ; Passing a paramerter to the "factorial subroutine" which we want to calculate the factorial....

			call Factorial

			pop ax

		mov [bp-4], di ; Moving the denominator in local variable



		mov ax, [bp-2]
		mov cx, [bp-4]

		div cl

		add [bp-6], ax ; Moving the sum of series in the local variable


		add si, 1

		cmp dx, si

		jne Series





	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax

	add sp, 6

	pop bp

	ret 2






start:
	push word[n]
	call summation


	mov ax, 0x4c00
	int 0x21



