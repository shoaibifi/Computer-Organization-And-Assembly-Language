[org 0x0100]

jmp start

data : dw 7, 5, 4 , 2

counter: dw 2

start:
	;Making all registers 0 

	xor si, si
	xor di, di
	xor ax, ax
	xor bx, bx
	xor cx, cx

	
	mov si, 0  ;  

	outerloop:

		mov bx , [counter] ; Moving first number in bx with the help of counter label and this counter will be incremented below

		mov cx , [data + si] ; 


		sort:

			cmp [data+bx], cx

			ja noswap ; here we are comparing the 5 with 7 and if 5 will be greater then there will be no swap  other wise 5 will be stored in  cx register as a minimum for at the moment

			mov cx, [data+bx] 

			mov di, bx ; And in di we are moving the index of that  number which is  minimum because at the end we have to shift the minimum with first number

		noswap:

			add bx, 2
			cmp bx, 8

			jne sort


		; code for swapping the first number with minimun


		mov bx, [data+si]

		mov [data+si], cx

		mov [data+di], bx


		add si, 2

		add word[counter], 2

		cmp si, 6

		jne outerloop


		mov ax, 0x4c00

		int 0x21
