[org 0x0100]

mov ah, [num1]

mov bh ,[num1+1]

add ah ,bl ; we can add ah with bl   

mov bl, ah  ; we can move the value of ah into bl as well

add ah ,bh

mov [num1+3], ah

mov ax, 0x4c00

int 0x21

num1: db 5,10,15,0




