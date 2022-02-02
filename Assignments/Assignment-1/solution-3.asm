[org 0x0100]

jmp start

data : dw 1,3,9,2,4,8,7,1,6,5
data2: dw 11,8,4,9,3

start:

; Code to find the sum of first half

mov si , 0

mov bx, [data+si]

sumFirstHalf:
	
	add si,2

	add bx, [data+si]

	cmp si , 8

	jne sumFirstHalf


	; Code to find the sum of second half


	mov si, 10
	mov dx, [data+si]

	sumSecondHalf:

		add si, 2

		add dx, [data+si]

		cmp si, 18

		jne sumSecondHalf


	; code to find minimum

	mov si, 0

	mov cx, [data2+si]

	mini:
		add si, 2

		cmp [data2+si], cx

		ja noswap

		mov cx, [data2+si]

		noswap:

			cmp si, 8
			jne mini


		cmp  bx, dx

		ja l1

		xor ax, ax

		mov ax, dx
		div cl

		jmp exit






		l1:
			xor ax, ax
			mov ax, bx
			div cx

			




	exit:

	mov ax, 0x4c00

	int 0x21 ;