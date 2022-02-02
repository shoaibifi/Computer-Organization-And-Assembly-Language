[org 0x0100]

jmp start

data : dw 7, 5, 4 , 2

counter: dw 2

start:
	
	mov ax, 0

	outerloop:

		mov cx , [counter]

		mov bx , [data + ax]


		sort:

			cmp [data+cx], bx

			ja noswap

			mov bx, [data+cx]

			mov dx, cx

		noswap:

			add cx, 2
			cmp cx, 8

			jne sort


		mov cx, [data+ax]

		mov [data+ax], bx

		mov [data+dx], cx


		add ax, 2

		add word[counter], 2

		cmp ax, 8

		jne outerloop

		mov ax, 0x4c00

		int 0x21
