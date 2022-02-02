[org 0x0100]


mov si , 0

mov bx, [num+si]

sumF:
	
	add si,2

	add bx, [num+si]

	cmp si , 8

	jne sumF



	mov si, 10
	mov dx, [num+si]

	sumS:

		add si, 2

		add dx, [num+si]

		cmp si, 18

		jne sumS


	; code to find minimum

	mov si, 0

	mov cx, [num2+si]

	mini:
		add si, 2

		cmp [num2+si], cx

		ja noswap

		mov cx, [num2+si]

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

num : dw 1,3,9,2,4,8,7,1,6,5
num2: dw 11,8,4,9,3