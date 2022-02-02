[org 0x0100]

jmp start

data : dw 7, 5, 4 , 2

counter: dw 2

start:
	
	mov si, 0

	outerloop:

		mov bx , [counter]

		mov cx , [data + si]


		sort:

			cmp [data+bx], cx

			ja noswap

			mov cx, [data+bx]

			mov di, bx

		noswap:

			add bx, 2
			cmp bx, 8

			jne sort


		mov bx, [data+si]

		mov [data+si], cx

		mov [data+di], bx


		add si, 2

		add word[counter], 2

		cmp si, 6

		jne outerloop


		mov ax, 0x4c00

		int 0x21
