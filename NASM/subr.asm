[org 0x0100]


jmp start

data : dw 2, 3, 4, 5


findMaximum:
	
	cmp [data+si], ax

	jbe noswap

	
	mov ax, [data+si]



	noswap:
		add si, 2

		cmp si, 8

		jne findMaximum

		ret


start:    ; Its like the "main" of the assembly language

mov si, 2

mov ax, [data]

call findMaximum

mov ax, 0x4c00
int 0x21
