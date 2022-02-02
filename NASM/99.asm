[org 0x0100]

jmp start

multiplicand: db 13

multiplier: db 5

result : dw 0


start:
	mov cx,4
	mov al, [multiplier]

	mov dl, [multiplicand]

	lup:

		

		shr al,1

		jnc skip

			add [result], dl

		skip:
			

			shl dl, 1

			sub cx, 1

			jnz lup

		mov dx, 0

		mov dx, [result]

		mov ax, 0x4c00
		int 0x21



	
