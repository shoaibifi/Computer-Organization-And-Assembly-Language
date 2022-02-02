[org 0x0100]
jmp start

	
	GCD:

		push bp
		mov bp, sp

		push ax
		push bx


		mov ax, [bp+6] ; On the first call "X = 20" will be moved to ax the first parameter and on the recursion call it can change.

		mov bx, [bp+4] ; "Y = 15" will be moved to the cx the second parameter. 

		cmp bx, 0 ; if y==0 
		je if


		cmp bx, ax   ; if x < y and here i'm doing this y>x which is same as x<y
		ja elif



		

		;return (X-Y, Y)

		else:            
			sub ax, bx 
			push ax
			push bx
			
			call GCD


			pop bx
			pop ax
			pop bp

			ret 4

	


	; return GCD (Y, X)

		elif:
			push bx 
			push ax


			call GCD


			pop bx
			pop ax
			pop bp
			ret 4
quit

		;return X

		if:
			mov dx, ax ;  The returning value 



	exit:


		pop bx
		pop ax
		pop bp

		ret 4






start:
	
	mov ax, 20
	mov bx, 15

	push ax
	push bx


	call GCD


	mov ax, 0x4c00
	int 0x21 