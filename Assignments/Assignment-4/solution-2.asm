
[org 0x0100]

SECTION.text:
	
GLOBAL_start


		_start:	


			mov eax , 0x4
			mov ebx ,1
			mov ecx, messsage
			mov edx, message_length
			int 0x80



			mov eax, 0x1
			mov ebx, 0
			int 0x80




SECTION.data:
	
message : db "20P-0147", 0XA, 0x0

message_length : equ $ - message 