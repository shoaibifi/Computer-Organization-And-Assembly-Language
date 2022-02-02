[org 0x100]

jmp start

multiplicand: dd 1300
multiplier: dw 500
result: dd 0



start:
	mov cl,16
	mov dx, [multiplier]



checkbit:
	shr dx, 1
	jnc skip


	mov ax, [multiplicand]
	add [result], ax 
	mov ax, [multiplicand+2]
	adc [result+2], ax



skip:
	
	shl word [multiplicand], 1
	rcl word [multiplicand+2],1
	dec cl
	jnz checkbit

mov ax, 0x4c00
int 0x21