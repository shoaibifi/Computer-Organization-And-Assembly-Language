SECTION.DATA:
	
	hello:    db "Hello from Assemblly language!!!", 10
	hellolen: equ $-hello


SECTION.TEXT:
GLOBAL say_hi


say_hi:
	
	mov rax, rdi

	push rax

	mov eax, 4
	mov ebx, 1
	mov ecx, hello
	mov edx, hellolen


	int 80h

	pop rax
	inc rax


	ret 
