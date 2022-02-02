[org 0x0100]

jmp start

num : dw 53

start:
	
	mov ax, 0 
	mov bx, 0
	
	mov al, [num] ; Moving the number in al register

	mov cx, 8

; Shifting the al register ri8 coz the L.S.B will be in carry and by doing rcl in bl register the carry will be saved one by one in bl register until the loop ends  

	reverse: 
		shr	al , 1 
		rcl bl , 1

		sub cx, 1

		cmp cx, 0

		jnz reverse




mov ax, 0x4c00

int 0x21