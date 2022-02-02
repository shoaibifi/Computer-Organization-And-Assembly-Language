[org 0x0100]

jump start:

multiplicand: db 13

multiplier: db 5

result : dw 0

start:
	mov cx,4

	loop:

		mov ax,[multiplier]
		mov dx,[multiplicand]

		shl ax,1

		jnc skip:

			add [result],ax

		skip:
			sub cx, 1

			shr dx, 1

			jnz loop


		mov ax, 0x4c00
		int 0x21



	
