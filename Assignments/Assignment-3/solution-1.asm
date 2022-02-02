[org 0x0100]

jmp start


fourByFour : dw 3,8,12,3,8,15,3,2,2,11,7,3,10,5,9,6
threeByThree : dw 1,2,3,4,5,6,7,8,9

lengthOf4By4 : dw 16
lengthOf3By3 : dw 9


calculateDiagonalSum:

	push bp
	mov bp, sp

	sub sp,4

	; local variables [Main diagonal Sum = bp-2] and [Total sum = bp-4]

	push ax
	push bx
	push cx
	push dx
	push si
	push di


	;Storing the adress of first element of an array which was passed through parameter in this case which is  address of "3"
	
	mov bx, [bp+6]


	;Storing the length of an array which was previously passed throug parameter and it's the logic of program.
	
	mov di,[bp+4]

	cmp word [di] , 9
	je sumOf3By3Array




	
	sumOf4By4Array:


			;Calculating the sum of main diagonal

			mov si, 0
			mov cx, 0
			mov ax, [bx+si]

			

			sumOfMainDiagonal:

			
				cmp si,0
				je mainDiagonalSum


				cmp si,10
				je mainDiagonalSum
				
				cmp si,20
				je mainDiagonalSum

				cmp si,30
				jne noAdd

				mainDiagonalSum:

					add cx, [bx+si]



				noAdd:
					add si, 2

					cmp si, 32
					jne sumOfMainDiagonal



			mov [bp-2], cx	 ;Storing the sum of main diagonal in the local variable

			



		;Calculating the sum of secondary  diagonal of Array 3 by 3

			mov si, 0
			mov cx, 0
			mov ax, [bx+si]


			sumOfSecondaryDiagonal:

				cmp si,6
				je secondaryDiagonalSum


				cmp si,12
				je secondaryDiagonalSum
				
				cmp si,18
				je secondaryDiagonalSum

				cmp si,24
				jne noAdd2

				secondaryDiagonalSum:

					add cx, [bx+si]



				noAdd2:
					add si, 2

					cmp si, 32
					jne sumOfSecondaryDiagonal






		add  cx,[bp-2]     ;storing the total sum of 4 by 4 2D-Array in cx register.... 


	jmp exit





	sumOf3By3Array:





		;Calculating the sum of main diagonal

			mov si, 0
			mov cx, 0
			mov ax, [bx+si]

			

			sumOfMainDiagonal2:

			
				cmp si,0
				je mainDiagonalSum2


				cmp si,8
				je mainDiagonalSum2
				
				cmp si,16
				jne noAdd3

				

				mainDiagonalSum2:

					add cx, [bx+si]



				noAdd3:
					add si, 2

					cmp si, 18
					jne sumOfMainDiagonal2



			mov [bp-2], cx	 ;Storing the sum of main diagonal in the local variable

			



		;Calculating the sum of scondary diagonal

			mov si, 0
			mov cx, 0
			mov ax, [bx+si]


			sumOfSecondaryDiagonal2:

				cmp si,4
				je secondaryDiagonalSum2


				cmp si,8
				je secondaryDiagonalSum2
				
				cmp si,12
				jne noAdd4

				secondaryDiagonalSum2:

					add cx, [bx+si]



				noAdd4:
					add si, 2

					cmp si, 18
					jne sumOfSecondaryDiagonal2




		add  cx,[bp-2] ;Adding the sum of main diagonal([bp-2]) and secondary diagonal(cx) in "cx".




		exit:

			pop di
			pop si
			pop dx
			pop cx
			pop bx
			pop ax
			add sp, 4
			pop bp



			ret 4



start:
	push word fourByFour
	push word lengthOf4By4

	;At the moment we are passing the 4by4(2D-Array) and i have made two functions if we pass 4 by 4 array and its length then it will work on 4by4 array but if we pass 3by3 array and its length then it will work on 3by3 array.

	call calculateDiagonalSum

	mov ax, 0x4c00
	int 0x21




