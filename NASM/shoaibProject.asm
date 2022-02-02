[org 0x0100]
jmp start


string: dw "#"


welcome: dw "WELCOME TO ROYAL TAJ HOTEL PESHAWAR"
welcomelength: dw 35


menu1: dw "Press 1 for Fast Food Menu "
lengthmenu1: dw 28

menu2: dw "Press 2 for Desi Food Menu "
lengthmenu2: dw 28

menu3: dw "Press 3 for Dessert Menu "
lengthmenu3: dw 25

exitt: dw "Press 4 for exit"
exitlength: dw 16





anything: dw "Press 1 for Go to Food Menu"
anythinglength: dw 27


anythingexit: dw "Press 2 to exit"
anythingexitlength: dw 16



;-------------------------FAST-FOOD-------------------------------------------------------------------------------------------

;burgers

zinger: dw "Press 1 for Zinger Burger---------RS:200"
zingerlength : dw 40


doubleZinger: dw "Press 2 for Double Zinger Burger---------RS:200"
doubleZingerlength : dw 48


tower: dw "Press 3 for Tower Burger-----------RS:400"
towerlength: dw 41

chicken: dw "Press 4 for Chicken Burger---------RS:200"
chickenlength : dw 41


;Pizzas


pizzaSmall : dw "Press 5 for Special Pizza Small Rs:400"
pizzaSmalllength: dw 38


pizzaMedium : dw "Press 6 for Special Pizza Medium Rs: 600"
pizzaMediumlength: dw 40


pizzaLarge: dw "Press 7 for special pizza large Rs: 1000"
lengthpizzaLarge: dw 40


;Chicken Wings 

wings5: dw "Press 8 for chicken Wings 5 pieces Rs:150"
wings5length: dw 41


exitf: dw "Press 9 for exit"
exitflength: dw 16

;---------------------------------------------DESIFOOD------------------------------------------------------------------------------

haleem: dw "Press 1 for Haleem------Rs: 250"
haleemlength: dw 31

karahi: dw "Press 2 for Chicken Karahi---------Rs 700"
karahilength: dw 42

mutton: dw "Press 3 for Mutton Karahi 1kg 1500"
muttonlength: dw 34

dampukht: dw "Press 4 for Dampukht  Rs: 5000"
dampukhtlength: dw 30



;------------------------------------------------Desserts----------------------------------------------------------------------------

rassian : dw "Press 1 for Russian Salad Rs: 150"
rassianlength: dw 33

iceCream: dw "Press 2 for Ice Cream cone Rs: 80"
iceCreamlength : dw 33

cup: dw "Press 3 Ice Cream Cup Rs: 70"
cuplength: dw 28

raffles: dw "Press 4 for Raffles Rs: 300"
raffleslength: dw 27



bill : dw 0

total : dw "TOTAL BILL: "
totallength: dw 12 




thank: dw "THANKS FOR CHOOSING ROYAL TAJ PESHAWAR"
thanklength: dw 38



clrscr:

	push dx
	push es
	push di


	mov dx, 0xb800
	mov es, dx
	mov di, 0


	s1:
		mov word [es:di], 0x0120
		add di, 2

		cmp di, 4000
		jne s1


	pop di
	pop es
	pop dx

	ret



screen:

	
	push bp
	mov bp, sp
	sub sp, 2
	
	push ax
	push bx
	push cx
	push dx
	push si
	push di


	mov ax, 0xb800
	mov es, ax
	mov di, 0


	mov si, [bp+4]
	mov al, [si]
	mov ah, 0x04


	


	;Code for upper screen 
	
	l2:
		mov word[es:di], ax
		add di, 2

		cmp di,158
		jne l2


	


	
	;code for lower screen

	mov di, 3840

	l3:
		mov word[es:di], ax
		add di, 2

		cmp di,3998
		jne l3


	;code for left screen


	


	

	mov bx, 2
	mov cx, 1

	l4:
		
		mov ax, 80
		mul bx
		mul cx

		mov dh, 0x04
		mov dl, [si]


		mov di, ax

		mov word[es:di],dx

		add cx, 1

		cmp cx, 28

		jne l4



	; code for ri8 screen



	mov bx, 2
	mov cx, 0
	mov word [bp-2],158

	l5:
		
		mov ax, 80
		mul cx

		add ax, word[bp-2]

		mul bx

		mov dh, 0x04
		mov dl, [si]


		mov di, ax

		mov word[es:di],dx

		add cx, 1

		cmp cx, 28

		jne l5







	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	add sp, 2
	pop bp



	ret 2





mainmenu:
	push bx
	push cx
	push dx
	push si
	push di
	push es


	
	mov dx, 0xb800
	mov es, dx


	mov si, welcome
	mov di, 680
	mov cx, [welcomelength]

	m0:
		mov bh, 0x02
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop m0








	mov si, menu1
	mov di, 1168
	mov cx, [lengthmenu1]

	m1:
		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop m1





		mov si, menu2
		mov di, 1488
		mov cx, [lengthmenu2]

	m2:
		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop m2




		mov si, menu3
		mov di, 1808
		mov cx, [lengthmenu3]

	


	m3:
		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop m3



		mov si, exitt
		mov di, 2128
		mov cx, [exitlength]
	m4:
		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop m4


		mov ah, 0 ; service 0 – get keystroke
        int 0x16 ; call BIOS keyboard service
        
        cmp al, 49 ; is the Esc key pressed
        je function1


        cmp al, 50
        je function2

       
        cmp al, 51
        je function3


        cmp al, 52
        je function4

        jmp exit



        function1:
       	call fastFoodMenu
       	jmp exit


       function2:
       call desiFoodMenu
       jmp exit


       function3
       call dessertFoodMenu
       jmp exit


       function4:
       call clrscr




    exit:



	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx

	ret


fastFoodMenu:	
	
	call clrscr
	push string
	call screen
	
	push bx
	push cx
	push dx
	push si
	push di
	push es


	mov si, zinger

	mov dx, 0xb800
	mov es, dx
	mov di, 678

	mov cx, [zingerlength]

	f1:
		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop f1



	mov si, doubleZinger
	mov di, 998
	mov cx, [doubleZingerlength]


	f2:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop f2





	mov si, tower
	mov di, 1318
	mov cx, [towerlength]


	f3:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop f3


	mov si, chicken
	mov di, 1638
	mov cx, [chickenlength]


	f4:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop f4




	


	mov si, pizzaSmall
	mov di, 1958
	mov cx, [pizzaSmalllength]


	f5:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop f5



	mov si, pizzaMedium
	mov di, 2278
	mov cx, [pizzaMediumlength]


	f6:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop f6


	mov si, pizzaLarge
	mov di, 2598
	mov cx, [lengthpizzaLarge]


	f7:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop f7


	mov si, wings5
	mov di, 2918
	mov cx, [wings5length]


	f8:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop f8



	mov si, exitf
	mov di, 3238
	mov cx, [exitflength]


	f9:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop f9









		mov ah, 0 ; service 0 – get keystroke
        int 0x16 ; call BIOS keyboard service
        
        cmp al, 49 ; is the Esc key pressed
        je ff1


        cmp al, 50
        je ff2

       
        cmp al, 51
        je ff3


        cmp al,  52 ; is the Esc key pressed
        je ff4


        cmp al,  53
        je ff5

       
        cmp al,  54
        je ff6

        cmp al, 55 ; is the Esc key pressed
        je ff7


        cmp al, 56
        je ff8

       
        cmp al, 57
        je ff9



        ff1:
 	      	add word[bill], 200


 	      	call anythingelse



        	jmp exitfast



        ff2:
 	      	add word[bill], 200


 	      	call anythingelse



        	jmp exitfast

        
        ff3:
 	      	add word[bill], 400


 	      	call anythingelse



        	jmp exitfast



        ff4:
 	      	add word[bill], 200


 	      	call anythingelse



        	jmp exitfast

        ff5:
 	      	add word[bill], 400


 	      	call anythingelse



        	jmp exitfast


        ff6:
 	      	add word[bill], 600


 	      	call anythingelse



        	jmp exitfast



        ff7:
 	      	add word[bill], 1000


 	      	call anythingelse



        	jmp exitfast



        ff8:
 	      	add word[bill], 150


 	      	call anythingelse



        	jmp exitfast


        ff9:
        	call clrscr





	exitfast

	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx


	ret




desiFoodMenu:
	
	call clrscr
	push string
	call screen




	push bx
	push cx
	push dx
	push si
	push di
	push es


	mov si, haleem

	mov dx, 0xb800
	mov es, dx
	mov di, 1168

	mov cx, [haleemlength]

	d1:
		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop d1


	mov si, karahi
	mov di, 1488
	mov cx, [karahilength]


	d2:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop d2


	mov si, mutton
	mov di, 1808
	mov cx, [muttonlength]


	d3:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop d3


	mov si, dampukht
	mov di, 2128
	mov cx, [dampukhtlength]


	d4:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop d4



	mov ah, 0 ; service 0 – get keystroke
    int 0x16 ; call BIOS keyboard service
        
        cmp al, 49 ; is the Esc key pressed
        je dd1


        cmp al, 50
        je dd2

       
        cmp al, 51
        je dd3


        cmp al,  52 ; is the Esc key pressed
        je dd4






        dd1:
 	      	add word[bill], 250


 	      	call anythingelse



        	jmp exitdesi



        dd2:
 	      	add word[bill], 700


 	      	call anythingelse



        	jmp exitdesi

        
        dd3:
 	      	add word[bill], 1500


 	      	call anythingelse



        	jmp exitdesi



        dd4:
 	      	add word[bill], 5000


 	      	call anythingelse



        	jmp exitdesi






      exitdesi


	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx

	ret




dessertFoodMenu:
	call clrscr
	push string 
	call screen



	push bx
	push cx
	push dx
	push si
	push di
	push es



	mov si, rassian

	mov dx, 0xb800
	mov es, dx
	mov di, 1168

	mov cx, [rassianlength]

	de1:
		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop de1


	mov si, iceCream
	mov di, 1488
	mov cx, [iceCreamlength]


	de2:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop de2


	mov si, cup
	mov di, 1808
	mov cx, [cuplength]


	de3:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop de3


	mov si, raffles
	mov di, 2128
	mov cx, [raffleslength]


	de4:

		mov bh, 0x01
		mov bl, [si]

		mov word[es:di], bx

		add si,1

		add di, 2

		loop de4




	mov ah, 0 ; service 0 – get keystroke
    int 0x16 ; call BIOS keyboard service
        
        cmp al, 49 ; is the Esc key pressed
        je dee1


        cmp al, 50
        je dee2

       
        cmp al, 51
        je dee3


        cmp al,  52 ; is the Esc key pressed
        je dee4






     dee1:
 	      	add word[bill], 150


 	      	call anythingelse



        	jmp exitdesert



     dee2:
 	      	add word[bill], 80


 	      	call anythingelse



        	jmp exitdesert

        
     dee3:
 	      	add word[bill], 70


 	      	call anythingelse



        	jmp exitdesert



     dee4:
 	      	add word[bill], 300


 	      	call anythingelse



        	jmp exitdesert






     exitdesert:

	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx


	ret



anythingelse:
	
	call clrscr

	push string 
	call screen
	
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es


	mov bx, 0xb800
	mov es, bx
	mov di, 1328

	mov si, anything
	mov cx, [anythinglength]


	a1:
		mov dh, 0x01
		mov dl, [si]

		mov word [es:di], dx

		add si, 1

		add di, 2

		loop a1


	mov si, anythingexit
	mov cx, [anythingexitlength]
	mov di, 1648


	a2:
		mov dh, 0x01
		mov dl, [si]

		mov word [es:di], dx

		add si, 1

		add di, 2

		loop a2



		mov ah, 0
		int 0x16

		cmp al, 49
		je aa1

		cmp al, 50
		je aa2


		aa1:
			call clrscr
			push string 
			call screen
			call mainmenu


		aa2:

			call calculateBill




	exitanythingfunction:

	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax


	ret





calculateBill:
	
	

	call clrscr
	
	push string
	call screen


	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es

	mov ax ,0xb800
	mov es, ax
	mov di, 1014

	mov si,total
	mov cx,[totallength]

	xor ax, ax

	mov ah, 0x06
	


	c1:
		mov al, [si]

		mov word[es:di],ax


		add si, 1
		add di, 2


		loop c1


	mov ax, word[bill]
	
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
	mov di, 1038

	nextpos:
		pop dx
		mov dh, 0x06

		mov word[es:di], dx

		add di, 2
		loop nextpos





	mov di, 1796

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


start:

	
	mov ax, 0
	call clrscr
	push string
	call screen
	call mainmenu
	

	mov ah, 0x1
	int 0x21




	mov ax, 0x4c00
	int 0x21





