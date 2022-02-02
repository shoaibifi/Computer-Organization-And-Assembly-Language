[org 0x0100]

jmp start



welcome : dw "--------------------------WELCOME TO MOHEMAN CAR WAS----------------------------",0
welcomelength: dw 0


vehicle: dw "Please select your vehicle category",0
vehiclelength: dw 0

car: dw "Press 1 for car wash ", 0
carlength: dw 0

jeep: dw "Press 2 for jeep wash",0
jeeplength: dw 0


bike : dw "Press 3 for bike wash", 0
bikelength: dw 0


carFullwash: dw "Press 1 for full wash with polish RS--------$1000"
carFullwashlength: dw 0

carBodywash: dw "Press 2 for body wash with polish RS--------$800"
carBodywashlength: dw 0


jeepFullwash: dw "Press 1 for full wash with polish RS--------$900"
jeepFullwashlength: dw 0

jeepBodywash: dw "Press 2 for body wash with polish RS--------$500"
jeepBodywashlength: dw 0

bikeFullwash: dw "Press 1 for full wash with polish RS--------$300"
bikeFullwashlength: dw 0

bikeBodywash: dw "Press 2 for body wash with polish RS--------$100"
bikeBodywashlength: dw 0



total: dw "Your total Bill including tax is"
totallength: dw 32


thank: dw "THANK YOU FOR USING MOHEMAN CAR WASH"
thanklength: dw 36


price: dw 0




start:
		call clrscr


		push ds
		push welcome

		call calculateLengthwelcome


		push ds
		push vehicle

		call calculatelengthvehicle


		push ds
		push car

		call calculatelengthcar


		push ds
		push jeep

		call calculatelengthjeep


		push ds
		push bike

		call calculatelengthbike








		;push word[carlength]

		;call printnum


         push welcome
         push word[welcomelength]

         push vehicle
         push word[vehiclelength]


         push car
         push word[carlength]

         push jeep
         push word[jeeplength]

         push bike
         push word[bikelength]

         


		call main






		
		mov ah, 0x1
		int 0x21



		mov ax, 0x4c00
		int 0x21





















clrscr:
	push es
	push ax
	push cx
	push di



	mov ax, 0xb800
	mov es, ax
	xor di, di


	mov ax, 0x0720
	mov cx, 2000


	cld

	rep stosw


	pop di
	pop cx
	pop ax
	pop es
	

	ret


calculateLengthwelcome:
	push bp
	mov bp, sp

	push ax
	push es
	push cx
	push di

	les di, [bp+4]

	mov cx, 0xffff

	xor al, al

	repne scasb


	mov ax, 0xffff
	sub ax, cx

	dec ax


	mov [welcomelength],ax 


	pop di
	pop cx
	pop es
	pop ax
	pop bp

	ret 4


calculatelengthvehicle:
	push bp
	mov bp, sp

	push ax
	push es
	push cx
	push di

	les di, [bp+4]

	mov cx, 0xffff

	xor al, al

	repne scasb


	mov ax, 0xffff
	sub ax, cx

	dec ax


	mov [vehiclelength],ax 


	pop di
	pop cx
	pop es
	pop ax
	pop bp

	ret 4



calculatelengthcar:
	push bp
	mov bp, sp

	push ax
	push es
	push cx
	push di

	les di, [bp+4]

	mov cx, 0xffff

	xor al, al

	repne scasb


	mov ax, 0xffff
	sub ax, cx

	dec ax


	mov [carlength],ax 


	pop di
	pop cx
	pop es
	pop ax
	pop bp

	ret 4


calculatelengthjeep:
	push bp
	mov bp, sp

	push ax
	push es
	push cx
	push di

	les di, [bp+4]

	mov cx, 0xffff

	xor al, al

	repne scasb


	mov ax, 0xffff
	sub ax, cx

	dec ax


	mov word[jeeplength],ax 


	pop di
	pop cx
	pop es
	pop ax
	pop bp

	ret 4


calculatelengthbike:
	push bp
	mov bp, sp

	push ax
	push es
	push cx
	push di

	les di, [bp+4]

	mov cx, 0xffff

	xor al, al

	repne scasb


	mov ax, 0xffff
	sub ax, cx

	dec ax


	mov word[bikelength],ax 


	pop di
	pop cx
	pop es
	pop ax
	pop bp

	ret 4




calculatecarFullwash:

	push bp
	mov bp, sp

	push ax
	push es
	push cx
	push di

	les di, [bp+4]

	mov cx, 0xffff

	xor al, al

	repne scasb


	mov ax, 0xffff
	sub ax, cx

	dec ax


	mov word[carFullwashlength],ax 


	pop di
	pop cx
	pop es
	pop ax
	pop bp

	ret 4

calculatecarBodywash:


	push bp
	mov bp, sp

	push ax
	push es
	push cx
	push di

	les di, [bp+4]

	mov cx, 0xffff

	xor al, al

	repne scasb


	mov ax, 0xffff
	sub ax, cx

	dec ax


	mov word[carBodywashlength],ax 


	pop di
	pop cx
	pop es
	pop ax
	pop bp

	ret 4


calculatejeepFullwash:

	push bp
	mov bp, sp

	push ax
	push es
	push cx
	push di

	les di, [bp+4]

	mov cx, 0xffff

	xor al, al

	repne scasb


	mov ax, 0xffff
	sub ax, cx

	dec ax


	mov word[jeepFullwashlength],ax 


	pop di
	pop cx
	pop es
	pop ax
	pop bp

	ret 4


calculatejeepBodywash:
	push bp
	mov bp, sp

	push ax
	push es
	push cx
	push di

	les di, [bp+4]

	mov cx, 0xffff

	xor al, al

	repne scasb


	mov ax, 0xffff
	sub ax, cx

	dec ax


	mov word[jeepBodywashlength],ax 


	pop di
	pop cx
	pop es
	pop ax
	pop bp

	ret 4



calculatebikeFullwash:

	push bp
	mov bp, sp

	push ax
	push es
	push cx
	push di

	les di, [bp+4]

	mov cx, 0xffff

	xor al, al

	repne scasb


	mov ax, 0xffff
	sub ax, cx

	dec ax


	mov word[bikeFullwashlength],ax 


	pop di
	pop cx
	pop es
	pop ax
	pop bp

	ret 4




calculatebikeBodywash:
	push bp
	mov bp, sp

	push ax
	push es
	push cx
	push di

	les di, [bp+4]

	mov cx, 0xffff

	xor al, al

	repne scasb


	mov ax, 0xffff
	sub ax, cx

	dec ax


	mov word[bikeBodywashlength],ax 


	pop di
	pop cx
	pop es
	pop ax
	pop bp

	ret 4











printnum:
		push bp
		mov bp, sp

		push ax
		push bx
		push cx
		push dx
		push si
		push di
		push es

		mov ax, [bp+4]

		mov bx, 10

		mov cx, 0


		nextdigit:
			mov dx, 0

			div bx

			add dl, 0x30

			push dx

			inc cx

			cmp ax, 0

			jnz nextdigit



		mov ax, 0xb800

		mov es, ax


		mov di, 0

		nextpos:

			pop dx

			mov dh, 0x07

			mov word[es:di], dx

			add di, 2

			loop nextpos



			pop es
			pop si
			pop di
			pop dx
			pop cx
			pop bx
			pop ax
			pop bp

			ret 2




main:
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es



	mov ax, 0xb800
	mov es, ax



	mov si, [bp+22]
	mov cx, [bp+20]
	mov di, 0


	

	loop1:
		
		mov ah, 0x01
		mov al, [si]

		mov word[es:di], ax

		add si, 1

		add di, 2

		loop loop1



	mov si, [bp+18]
	mov cx, [bp+16]
	mov di, 362


	

	loop2:
		
		mov ah, 0x01
		mov al, [si]

		mov word[es:di], ax

		add si, 1

		add di, 2

		loop loop2


	mov si, [bp+14]
	mov cx, [bp+12]
	mov di, 800


	

	loop3:
		
		mov ah, 0x04
		mov al, [si]

		mov word[es:di], ax

		add si, 1

		add di, 2

		loop loop3



	mov si, [bp+10]
	mov cx, [bp+8]
	mov di, 960


	

	loop4:
		
		mov ah, 0x04
		mov al, [si]

		mov word[es:di], ax

		add si, 1

		add di, 2

		loop loop4


	mov si, [bp+6]
	mov cx, [bp+4]
	mov di, 1120


	

	loop5:
		
		mov ah, 0x04
		mov al, [si]

		mov word[es:di], ax

		add si, 1

		add di, 2

		loop loop5





	    mov ah, 0
		int 0x16

		cmp al, 49
		je car1

		cmp al, 50
		je jeep1


		cmp al, 51
		je bike1


		car1:

			push ds
			push carFullwash
			call calculatecarFullwash


			push ds
			push carBodywash
			call calculatecarBodywash


			push carFullwash
			push word[carFullwashlength]

			push carBodywash
			push word[carBodywashlength]
			
			call carwash


			jmp exit1



			jeep1:


			push ds
			push jeepFullwash
			call calculatejeepFullwash


			push ds
			push jeepBodywash
			call calculatejeepBodywash


			push jeepFullwash
			push word[jeepFullwashlength]

			push jeepBodywash
			push word[jeepBodywashlength]

		
			call jeepwash
			jmp exit1

		bike1:
			
			
			push ds
			push bikeFullwash
			call calculatebikeFullwash


			push ds
			push bikeBodywash
			call calculatebikeBodywash


			push bikeFullwash
			push word[bikeFullwashlength]

			push bikeBodywash
			push word[bikeBodywashlength]


			call bikewash
			jmp exit1





	



	

			exit1
	
	    pop es
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp


        ret 16



 carwash:

 	call clrscr


	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es



	mov ax, 0xb800
	mov es, ax



	mov si, [bp+10]
	mov cx, [bp+8]
	mov di, 0


	

	w1:
		
		mov ah, 0x01
		mov al, [si]

		mov word[es:di], ax

		add si, 1

		add di, 2

		loop w1



	mov si, [bp+6]
	mov cx, [bp+4]
	mov di, 160


	

	w2:
		
		mov ah, 0x01
		mov al, [si]

		mov word[es:di], ax

		add si, 1

		add di, 2

		loop w2


	   mov ah, 0
	   int 0x16

		cmp al, 49
		je f1

		cmp al, 50
		je f2


		f1:
			add word[price],1000

			call bill  

			jmp exitw

		f2:
			add word[price],800


			call bill
















		exitw

		pop es
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp

        ret 8



 jeepwash:



 	call clrscr


	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es



	mov ax, 0xb800
	mov es, ax



	mov si, [bp+10]
	mov cx, [bp+8]
	mov di, 0


	

	j1:
		
		mov ah, 0x01
		mov al, [si]

		mov word[es:di], ax

		add si, 1

		add di, 2

		loop j1



	mov si, [bp+6]
	mov cx, [bp+4]
	mov di, 160


	

	j2:
		
		mov ah, 0x01
		mov al, [si]

		mov word[es:di], ax

		add si, 1

		add di, 2

		loop j2


	   mov ah, 0
	   int 0x16

		cmp al, 49
		je ff1

		cmp al, 50
		je ff2


		ff1:
			add word[price],900

			call bill  

			jmp exitj

		ff2:
			add word[price],500


			call bill
















		exitj

		pop es
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp

        ret 8


 bikewash:



 	call clrscr


	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es



	mov ax, 0xb800
	mov es, ax



	mov si, [bp+10]
	mov cx, [bp+8]
	mov di, 0


	

	jj1:
		
		mov ah, 0x01
		mov al, [si]

		mov word[es:di], ax

		add si, 1

		add di, 2

		loop jj1



	mov si, [bp+6]
	mov cx, [bp+4]
	mov di, 160


	

	jj2:
		
		mov ah, 0x01
		mov al, [si]

		mov word[es:di], ax

		add si, 1

		add di, 2

		loop jj2


	   mov ah, 0
	   int 0x16

		cmp al, 49
		je fff1

		cmp al, 50
		je fff2


		fff1:
			add word[price],300

			call bill  

			jmp exitb

		fff2:
			add word[price],100


			call bill


		exitb

		pop es
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp

        ret 8




bill:
	


	call clrscr


	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es

	mov ax ,0xb800
	mov es, ax
	mov di, 360

	mov si,total
	mov cx,[totallength]

	xor ax, ax

	mov ah, 0x04
	


	c1:
		mov al, [si]

		mov word[es:di],ax


		add si, 1
		add di, 2


		loop c1


	add word[price], 30

	mov ax, word[price]
	
	mov bx, 10
	mov cx, 0



	nextdigit1:

		mov dx, 0

		div bx

		add dl, 0x30

		push dx

		inc cx 

		cmp ax, 0

		jnz nextdigit1



	mov ax, 0xb800
	mov es, ax
	mov di, 420

	nextpos1:
		pop dx
		mov dh, 0x04

		mov word[es:di], dx

		add di, 2
		loop nextpos1



		









mov di, 1798

	mov si,thank
	mov cx,[thanklength]

	xor ax, ax

	mov ah, 0x09
	


	cc1:
		mov al, [si]

		mov word[es:di],ax


		add si, 1
		add di, 2


		loop cc1





		pop es
		pop di
		pop si
		pop dx
		pop cx
		pop bx
		pop ax

		ret 





 	



	

	




















