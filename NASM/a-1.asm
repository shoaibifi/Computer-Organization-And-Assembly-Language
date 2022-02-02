global _start
section .data
    parameter1 db 10 
    parameter2 db 15



section .text
_start:


push parameter1 
push parameter2 
call add

mov eax, 1 
mov ebx, 0 
int 0x80 

add:
push ebp 
mov ebp, esp 

mov eax, 4
mov ebx, 1
mov ecx, [esp+8] 
mov edx, [esp+4] 

add ecx , adx 


int 0x80 


mov esp, ebp
pop ebp 
ret 
