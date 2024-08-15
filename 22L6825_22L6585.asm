[org 0x100]

jmp start


oldisr: dd 0
timisr: dd 0
setter: dw 0
score: dw 0
music: dw 0
message: db 'Score = '
resolutionRow : dw 43
resolutionColumn : dw 132
reservedStartRow:	dw 27
sunStartColumn: dw 124
sunStartRow: dw 0
sunEndRow:	dw 6
mountainStartRow: dw 12
greeneryStartRow: dw 11
skyEndRow:	dw 12
surfaceStartRow: dw 14
BodyRow: dw 19
currentRow:	dw 37
currentColumn: dw 82
tile1Column: dw 90
tile2Column: dw 90
moveTileRow: dw 34
tileMoved: dw 0
shiftDownRow: dw 41
scrollDownRow: dw 31
Shiftmode: dw 0
moveTileRow2: dw 38
tile1Color: dw 0
tile2Color: dw 1
tickcount: dw 0
keypressed: dw 0
broken: dw 0
timebomb: dw 0
extraCounter: dw 0
escape: dw 0
message2: db "Do you want to exit?"
message3: db "Press Y to confirm"
message4: db "Press N to continue"
yes: dw 0
no: dw 0
message5: db "                    "
message6: db "Paused"
buffer: times 5676 dw 0
message_1: db "Enter Your Name   :  $"
nameBuffer: times 81 db 0
nextbuffer_1: db ", Welcome to Jumping Rabbit ",0
next_buffer_2: db "About the Game: ",0
next_buffer_3: db "Firstly, There Are Three Tiles ",0
next_buffer4: db "1-Red   ",0
next_buffer_4: db "1-Red  : Rapidly Moving Tile ",0
next_buffer_5: db "2-White : Moving Tile ",0
next_buffer5: db "2-White ",0
next_buffer_6: db "3-Blue  : Still Tile which breaks after every 5 seconds ",0
next_buffer6: db "3- Blue :",0
next_buffer_7: db "4- A coin is placed at random locations, collecting it adds 10 points to your current score ",0
next_buffer_8: db "Press Any Key To Start ",0
next_buffer_9: db "22L-6585  SAMEER KHAWAR",0
next_buffer_10: db "22L-6825 ABDUL RAFAY TAHIR" , 0
message7: db "Game Over$"
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------
StoreBuffer:	push es
				push ds
				push ax
				push cx
				push di
				push si

				mov di , buffer
				push cs
				pop es
				mov ax , 0xb800
				mov ds , ax
				mov si , 0
				mov cx , 5676
				cld
				rep movsw

				pop si
				pop di
				pop cx
				pop ax
				pop ds
				pop es
				ret
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------
strlen: push bp
		mov bp,sp
		push es
		push cx
		push di
		les di, [bp+4] ; point es:di to string
		mov cx, 0xffff ; load maximum number in cx
		xor al, al ; load a zero in al
		repne scasb ; find zero in the string
		mov ax, 0xffff ; load maximum number in ax
		sub ax, cx ; find change in cx
		dec ax ; exclude null from length
		pop di
		pop cx
		pop es
		pop bp
		ret 4
;----------------------------------------------------------------------------------------------------------------------------------------------------------
PrintFrontScreen:	pusha
                    push es
                    mov ax , 0xb800
                    mov es , ax
                    mov ax , [resolutionRow]
                    mov cx , [resolutionColumn]
                    mul cx
                    mov cx , ax
                    mov di , 0
                    mov ah , 0x30
                    mov al , ' '
                    rep stosw

		            mov dx , message_1
		            mov ah,9
		            int 0x21
                    mov ax , [resolutionColumn]
                    mov cx , 0x0b
                    mul cx
                    add ax , 0x10
                    shl ax , 1
                    mov di , ax
                    mov bx , 20
                    mov si , ax

                    mov si , nameBuffer
nextchar:
                    mov ah , 1
                    int 0x21
                    cmp al, 13
                    je .exit
                    mov [si], al
                    inc si
                    loop nextchar
.exit:              mov byte [si], 0
                    mov ax , 0x7020
.l3:
                    mov cx , 100
                    rep stosw
                    add di , 64
                    dec bx
                    jnz .l3
	            	push ds
                    push nameBuffer
                    call strlen
                    cmp ax , 0
                    je .Exit
                    mov bl , 0x7f
                    mov  bh , 0
                    push ds
                    pop es
                    mov cx , ax

                    mov ah , 13h
                    mov al , 1
                    mov bp , nameBuffer
                    mov dh , 0x0C
					mov dl , 0x17
                    int 0x10
					add dl , cl
                    push ds
                    push nextbuffer_1
                    call strlen
                    cmp ax , 0
                    je .Exit
                    mov bl , 0x7f
                    mov bh , 0
                    push ds
                    pop es
                    mov cx,ax

                    mov ah , 13h
                    mov al , 1
                    mov bp , nextbuffer_1
                    int 0x10
                    push ds
                    push next_buffer_2
                    call strlen
                    cmp ax , 0
                    je .Exit
                    mov bl , 0x7f
                    mov bh , 0
                    push ds
                    pop es
                    mov cx , ax

                    mov ah , 13h
                    mov al , 1
                    mov bp , next_buffer_2
                    mov dx , 0x0D17
                    int 0x10
                    push ds
                    push next_buffer_3
                    call strlen
                    cmp ax , 0
                    je .Exit
                    mov bl , 0x7f
                    mov bh ,0
                    push ds
                    pop es
                    mov cx , ax

                    mov ah , 13h
                    mov al , 1
                    mov bp , next_buffer_3
                    mov dx , 0x0e17
                    int 0x10

                   push ds
                   push next_buffer_4
                   call strlen
                   cmp ax , 0
                   je .Exit
                   mov bl , 0x7f
                   mov bh , 0
                   push ds
                   pop es
                   mov cx , ax

                   mov ah , 13h
                   mov al , 1
                   mov bp , next_buffer_4
                   mov dx , 0x1017
                   int 0x10

                   push ds
                   push next_buffer4
                   call strlen
                   cmp ax , 0
                   je .Exit
                   mov bl , 0x74
                   mov bh , 0
                   push ds
                   pop es
                   mov cx , ax

                   mov ah , 13h
                   mov al , 1
                   mov bp , next_buffer4
                   mov dx , 0x1017
                   int 0x10
                   push ds
                   push next_buffer_5
                   call strlen
                   cmp ax , 0
                   je .Exit
                   mov bl , 0x7f
                   mov bh , 0
                   push ds
                   pop es
                   mov cx , ax

                   mov ah , 13h
                   mov al , 1
                   mov bp , next_buffer_5
                   mov dx , 0x1417
                   int 0x10
                   push ds
                   push next_buffer5
                   call strlen
                   cmp ax , 0
                   je .Exit
                   mov bl , 0x7f
                   mov bh , 0
                   push ds
                   pop es
                   mov cx , ax

                   mov ah , 13h
                   mov al , 1
                   mov bp , next_buffer5
                   mov dx , 0x1417
                   int 0x10
                   push ds
                   push next_buffer_6
                   call strlen
                   cmp ax , 0
                   je .Exit
                   mov bl , 0x7f
                   mov bh , 0
                   push ds
                   pop es
                   mov cx , ax

                   mov ah , 13h
                   mov al , 1
                   mov bp , next_buffer_6
                   mov dx , 0x1817
                   int 0x10
                   push ds
                   push next_buffer6
                   call strlen
                   cmp ax , 0
                   je .Exit
                   mov bl , 0x71
                   mov bh , 0
                   push ds
                   pop es
                   mov cx , ax

                    mov ah,13h
                    mov al,1
                    mov bp,next_buffer6
                    mov dx,0x1817
                    int 0x10
                    push ds
                    push next_buffer_7
                    call strlen
                    cmp ax,0
                    je .Exit
                    mov bl,0x7f
                    mov  bh,0
                    push ds
                    pop es
                    mov cx,ax

                    mov ah,13h
                    mov al,1
                    mov bp,next_buffer_7
                    mov dx,0x1c17
                    int 0x10
                    push ds
                    push next_buffer_8
                    call strlen
                    cmp ax,0
                    je .Exit
                    mov bl,0xBf
                    mov  bh,0
                    push ds
                    pop es
                    mov cx,ax

                    mov ah,13h
                    mov al,1
                    mov bp,next_buffer_8
                    mov dx,0x2117
                    int 0x10
                    push ds
                    push next_buffer_9
                    call strlen
                    cmp ax,0
                    je .Exit
                    mov bl,0x3f
                    mov  bh,0
                    push ds
                    pop es
                    mov cx,ax

                    mov ah,13h
                    mov al,1
                    mov bp,next_buffer_9
                    mov dx,0x0165
                    int 0x10
                    push ds
                    push next_buffer_10
                    call strlen
                    cmp ax,0
                    je .Exit
                    mov bl,0x3f
                    mov  bh,0
                    push ds
                    pop es
                    mov cx,ax

                    mov ah,13h
                    mov al,1
                    mov bp,next_buffer_10
                    mov dx,0x0265
                    int 0x10

.Exit:              mov ah, 1
                    int 0x21
                    pop es
                    popa
                    ret
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------
PrintPauseScreen:		push es
						push ax
						push cx
						push di

						mov ax , 0xb800
						mov es , ax
						mov di , 0
						mov ax , [resolutionColumn]
						mov cx , [resolutionRow]
						mul cx
						shl ax , 1
						mov cx , ax
						mov ah , 0x30
						mov al , ' '

						rep stosw

						pop cx
						pop di
						pop ax
						pop es
						ret
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------
RestoreBuffer:	push es
				push ds
				push ax
				push cx
				push di
				push si

				mov si , buffer
				push cs
				pop ds
				mov ax , 0xb800
				mov es , ax
				mov di , 0
				mov cx , 5676
				cld
				rep movsw

				pop si
				pop di
				pop cx
				pop ax
				pop ds
				pop es
				ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------
PauseScreen:		push ax
					push bx
					push cx
					push dx
					push bp
					push es

					call StoreBuffer
					call PrintPauseScreen

					mov al, 0
					mov bh, 0
					mov bl , 0x3F
					mov cx , 20
					mov dl , 50
					mov dh , 6
					mov bp , message2
					push cs
					pop es
					mov ah , 0x13
					int 0x10

					mov cx , 18
					mov dl , 30
					mov dh , 9
					mov bp , message3
					int 0x10

					mov cx , 19
					mov dl , 70
					mov bp , message4
					int 0x10

					mov cx , 6
					mov dh , 1
					mov dl , 55
					mov bp , message6
					int 0x10

userInput:			cmp word[yes] , 1
					je e10

					cmp word [no] , 1
					jne userInput
					mov cx , 20
					mov dl , 50
					mov dh , 1
					mov bp , message5
					int 0x10

					mov cx , 20
					mov dl , 30
					mov dh , 3
					mov bp , message5
					int 0x10

					mov cx , 20
					mov dl , 70
					mov dh , 3
					mov bp , message5
					int 0x10

					mov word [no] , 0
					mov word [escape] , 0
					call RestoreBuffer

					pop es
					pop bp
					pop dx
					pop cx
					pop bx
					pop ax
					ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------
Delay:      push cx
			mov cx, 0xFFFF
loop2:		loop loop2
			mov cx, 0xFFFF
loop3:		loop loop3
			pop cx
			ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------
PrintEndScreen:
                    pusha
                    push bp
                    push es

                    ;call PrintPauseScreen

						mov ax , 0xb800
						mov es , ax
						mov di , 0
						mov ax , [resolutionColumn]
						mov cx , [resolutionRow]
						mul cx
						;shl ax , 1
						mov cx , ax
						mov ah , 0x30
						mov al , ' '

						cld
						rep stosw
					mov al , 0
					mov bh , 0
					mov bl , 0xB0
					mov cx , 9
					mov dl , 66
					mov dh , 20
					mov bp , message7
					push cs
					pop es
					mov ah , 0x13
					int 0x10

					mov bl , 0x30
					mov cx , 8
					mov dh , 18
					mov bp , message
					int 0x10

					push word 18
					push word [score]
					push word 74
					call PrintNumber
					pop es
                    pop bp
                    popa
					ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------
PrintMessage:		push bp
					mov bp , sp
					push ax
					push es
					push cx
					push di
					push si
					push bx

					mov ax , 0xb800
					mov es , ax
					mov bx , [bp + 6]
					mov ax , 2
					mov cx , [resolutionColumn]
					mul cx
					shl ax , 1
					mov di , ax
					mov si , 0
					mov cx , [bp + 4]

					mov ah , 0x30

loop12:				mov al , [bx + si]
					mov [es:di] , ax
					add di , 2
					add si , 1
					loop loop12

					pop bx
					pop si
					pop di
					pop cx
					pop es
					pop ax
					pop bp
					ret 4
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------
PrintNumber:		push bp
					mov bp, sp
					push es
					push ax
					push bx
					push cx
					push dx
					push di

					mov ax, 0xb800
					mov es, ax
					mov ax , [bp + 8]
					mov cx , [resolutionColumn]
					mul cx
					add ax , [bp + 4]
					shl ax , 1
					mov di , ax

					mov ax, [bp + 6]
					mov bx, 10
					mov cx, 0

nextdigit: 			mov dx, 0
					div bx
					add dl, 0x30
					push dx
					inc cx
					cmp ax, 0
					jnz nextdigit

nextpos: 			pop dx
					mov dh, 0x30
					mov [es:di], dx
					add di, 2
					loop nextpos

					pop di
					pop dx
					pop cx
					pop bx
					pop ax
					pop es
					pop bp
					ret 6
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
Shift:				push bp
					mov bp , sp
					push es
					push ds
					push ax
					push si
					push di
					push cx
					push bx

					mov bx , [resolutionColumn]
					shl bx , 1

					mov ax , [bp + 4]
					mov cx , [resolutionColumn]
					mul cx
					shl ax , 1
					mov di , ax
					mov si , di
					add si , 2
					sub cx , 1

					mov ax , 0xb800
					mov es , ax
					mov ds , ax

					cmp word [bp + 6] , 0
					jne rightshift

					push word [es:di]

					cld
					rep movsw
					pop ax
					mov [es:di] , ax
					jmp exit3

rightshift:			add di , bx
					sub di , 2
					mov si , di
					sub si , 2

					push word [es:di]

					std
					rep movsw
					pop ax
					mov [es:di] , ax

exit3:				pop bx
					pop cx
					pop di
					pop si
					pop ax
					pop ds
					pop es
					pop bp
					ret 4
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
ShiftDown:			push es
					push ds
					push ax
					push si
					push di
					push cx
					push dx
					push bx

                    mov cx,[resolutionColumn]
                    mov ax,[resolutionColumn]
                    mov bx,[shiftDownRow]
                    mul bx
                    shl ax,1

                    mov di,ax
                    mov si,di
                    mov bx,[resolutionColumn]
                    shl bx,1
                    sub si,bx


                    mov dx,[shiftDownRow]
                    sub dx,[scrollDownRow]
                    sub dx,1
                    mov cx,[resolutionColumn]
                    push cx
                    mov ax,0xb800
                    mov es,ax
looop:              pop cx
                    push cx
                    mov bx,[resolutionColumn]
                    shl bx,2
                    sub si,bx
                    sub di,bx
nawaloop:
                    mov ax,[es:si]
                    mov [es:di],ax
                    add di,2
                    add si,2
                    dec cx
                    jnz nawaloop
                    dec dx
                    jnz looop

                    pop cx
                  	pop bx
                    pop dx
                    pop cx
                    pop di
                    pop si
                    pop ax
                    pop ds
					add word [currentRow] , 1
					push ax
					mov ax , [tile1Color]
					mov [tile2Color] , ax
					pop ax
					pop es
ret
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
PrintPlants:		push bp
					mov bp , sp
					push es
					push ax
					push di
					push cx

					mov ax , 0xb800
					mov es , ax
					mov ax , [resolutionRow]
					sub ax , 1
					mov cx , [resolutionColumn]
					mul cx
					add ax , [bp + 4]
					shl ax , 1
					mov di , ax
					shl cx , 1

					mov ah , 0x12
					mov al , '|'
					mov [es:di] , ax
					mov al , '\'
					sub di , 2
					mov [es:di] , ax
					mov al , '/'
					add di , 4
					mov [es:di] , ax
					mov al , '|'
					sub di , 2
					sub di , cx
					mov [es:di] , ax
					mov al , '\'
					sub di , 2
					mov [es:di] , ax
					mov al , '/'
					add di , 4
					mov [es:di] , ax

					pop cx
					pop di
					pop ax
					pop es
					pop bp
					ret 2
;-----------------------------------------------------------------------------------------------------------------------------
PrintReservedSpace:		call PrintWater
						push word 10
						call PrintPlants
						push word 20
						call PrintPlants
						push word 35
						call PrintPlants
						push word 60
						call PrintPlants
						push word 85
						call PrintPlants
						push word 110
						call PrintPlants
						ret
;-----------------------------------------------------------------------------------------------------------------------------
PrintWater:				push es
						push ax
						push di
						push cx
						push bx

						mov ax , 0xb800
						mov es , ax
						mov ax , [reservedStartRow]
						mov cx , [resolutionColumn]
						mul cx
						shl ax , 1
						mov di , ax
						mov ax , [resolutionRow]
						mul cx
						shl ax , 1
						mov bx , ax
						mov ax , 0x1120

						cld

l1:						stosw
						cmp di , bx
						jne l1

						pop bx
						pop cx
						pop di
						pop ax
						pop es
						ret
;--------------------------------------------------------------------------------------------------------------------------------------------
PrintBirds:				push bp
						mov bp , sp
						push es
						push ax
						push di
						push cx

						mov ax , 0xb800
						mov es , ax
						mov ax , [bp + 6]
						mov cx , [resolutionColumn]
						mul cx
						mov cx , [bp + 4]
						add ax , cx
						shl ax , 1
						mov di , ax

						mov ah , 0xB0
						mov al , '\'

						mov [es:di] , ax
						add di , 2
						mov al , '/'
						mov [es:di] , ax

exit2:					pop cx
						pop di
						pop ax
						pop es
						pop bp
						ret 4
;-------------------------------------------------------------------------------------------------------------------------------------------------
PrintSun:				push es
						push ax
						push di
						push cx
						push bx
						push si

						mov ax , 0xb800
						mov es , ax
						mov ax , [sunStartRow]
						mov cx , [resolutionColumn]
						mul cx
						add ax , [sunStartColumn]
						shl ax , 1
						mov di , ax
						mov bx , [resolutionColumn]
						shl bx , 1

						mov si , di
						mov cx , 4

						mov ax , 0x3E5F
						cld
						rep stosw

						mov cx , 4
						mov di , si
						std

						rep stosw
						
						add di , bx
						mov word[es:di] , 0x3E2F

						mov cx , 8
						add di , 2

						cld
						mov ax , 0x6020

						rep stosw

						sub di , 2
						mov word[es:di] , 0x3E5C

						add di , bx
						add di , 2
						mov word[es:di] , 0x3E7C

						std
						mov cx , 9
						sub di , 2

						rep stosw

						mov word[es:di] , 0x3E7C
						add di , bx
						add di , 2
						mov word[es:di] , 0x3E5C
						add di , 2

						mov cx , 7
						cld
						mov ax , 0x3020

						rep stosw

						mov word[es:di] , 0x3E2F
						mov cx , 7
						sub di , 2

						std
						mov ax , 0x6E5F

						rep stosw

						pop si
						pop bx
						pop cx
						pop di
						pop ax
						pop es
						ret
;--------------------------------------------------------------------------------------------------------------------------------------------------
PrintSky:				push es
						push ax
						push di
						push cx

						mov ax , 0xb800
						mov es , ax
						mov ax , [skyEndRow]
						mov cx , [resolutionColumn]
						mul cx
						shl ax , 1
						mov cx , ax
						mov di , 0
						mov ax , 0x3020
						cld

sky:					stosw
						cmp di , cx
						jne sky

						pop cx
						pop di
						pop ax
						pop es
						ret
;--------------------------------------------------------------------------------------------------------------------------------------------------
PrintBackground:		call PrintSky
					    push word message
					    push word 8
						call PrintMessage
						push word 2
						push word [score]
						push word 10
						call PrintNumber
						push word 6
						push word 50
						call PrintBirds
						push word 6
						push word 60
						call PrintBirds
						push word 7
						push word 55
						call PrintBirds
						push word 8
						push word 2
						call PrintBirds
						push word 9
						push word 100
						call PrintBirds
						push word 7
						push word 32
						call PrintBirds
						push word 7
						push word 20
						call PrintBirds
						push word 9
						push word 80
						call PrintBirds
						push word 7
						push word 120
						call PrintBirds
						push word 6
						push word 90
						call PrintBirds
						push word 9
						push word 85
						call PrintBirds
						call PrintSun
						call PrintGreenery
						push word 0x4
						push word 13
						call PrintMountain
						push word 0x5
						push word 24
						call PrintMountain
						push word 0x5
						push word 37
						call PrintMountain
						push word 0x4
						push word 50
						call PrintMountain
						push word 0x4
						push word 2
						call PrintMountain
						push word 0x6
						push word 62
						call PrintMountain
						push word 0x3
						push word 78
						call PrintMountain
						push word 0x5
						push word 88
						call PrintMountain
						push word 0x7
						push word 102
						call PrintMountain
						push word 0x5
						push word 120
						call PrintMountain
						ret
;-----------------------------------------------------------------------------------------------------------------------------------------------------
PrintGreenery:			push ax
						push es
						push cx
						push di

						mov ax , 0xb800
						mov es , ax
						mov ax , [greeneryStartRow]
						mov cx , [resolutionColumn]
						mul cx
						shl ax , 1
						mov di , ax
						shl cx  , 2
						mov ax , [resolutionColumn]
						shl ax , 1
						mov cx , di
						add cx , ax
						add cx , ax
						add cx , ax
						add cx , ax
						mov ax , 0x2220
						cld

l3:						stosw
						cmp di , cx
						jne l3

						pop di
						pop cx
						pop es
						pop ax
						ret
;----------------------------------------------------------------------------------------------------------------------------------------------
PrintMountain:			mov ax , [mountainStartRow]
						push ax
						push bp
						mov bp, sp
						push es
						push ax
						push cx
						push si
						push di
						push dx

						mov ax ,0xb800
						mov es,ax
						mov ax, [resolutionColumn]
						mul word [bp+2]
						add ax,[bp+6]
						shl ax,1
						mov di,ax
						mov cx,[bp+8]
						mov ah,0x66
						mov dx , [resolutionColumn]
						shl dx , 1


part1:					mov al,' '
						mov [es:di],ax

						mov bx,cx
						shl bx,1
						mov si,di
						add si,2
ghoom:
						mov al,20
						mov [es:si],ax
						add si,2
						dec bx
						cmp bx,0
						jnz ghoom
						sub di,dx
						add di,2
						mov al,95

						mov [es:di],ax
						dec cx
						jnz part1
						sub di,2
						mov [es:di],ax
						add di,2
						mov [es:di],ax

						mov cx,[bp+8]
						add di,dx
						mov bx,0
						push bx

part2:					mov al,' '
						mov [es:di],ax
 						pop bx
 						add bx,2
 						push bx
 						mov si,di
 						sub si,2
ghoomja:
 						mov al,20
 						mov [es:si],ax
 						sub si,2
 						dec bx
 						cmp bx,0
 						jnz ghoomja
						add di,2
						mov al,95
						mov [es:di],ax
						add di,dx
						dec cx
						jnz part2
						sub di,dx
						sub di , 2
						mov ax,0x6620
						mov [es:di],ax

						pop bx
						pop dx
						pop bx
						pop di
						pop si
						pop cx
						pop es
						pop bp
						pop ax
						ret 4
;-----------------------------------------------------------------------------------------------------------------------------------------------
PrintBoats:				push bp
						mov bp , sp
						push es
						push ax
						push di
						push si
						push bx
						push cx
						push dx

						mov ax,0xb800
						mov es,ax
						mov ax,[resolutionColumn]
						mul word [bp+4]
						add ax , [bp+6]
						shl ax,1
						mov di,ax
						mov cx , [bp+8]
						mov ah, 0x33
						mov dx , [resolutionColumn]
						shl dx , 1
						add di , dx
side1:
						mov bx,cx
						mov si,di
Fill:
						mov al,' '
						mov [es:si],ax
						add si,2
						dec bx
						jnz Fill
						mov al,'|'
						mov [es:di],ax
						add di,dx
						add di , 2
						sub cx,1
						jnz side1
						mov cx,[bp+10]

base:					mov ah, 0x33
					    mov al,'@'
						mov [es:di],ax
						mov bx,[bp+8]
						mov si,di
						mov al,' '
						mov ah, 0x33
fill3:
						sub si,dx
						mov [es:si],ax
						dec bx
				   	    jnz fill3
						add di,2
						sub cx,1
						jnz base

						mov cx,[bp+8]
						sub di,dx
						mov ah,0x33
						mov bx,0

side2:
						add bx,1
						push bx

						mov si,di
Fill2:
					    mov al,' '
						mov [es:si],ax
						sub si,2
						dec bx
						jnz Fill2
						pop bx
						mov al,'#'
						mov [es:di],ax
						sub di,dx
						add di , 2
						sub cx,1
						jnz side2
						sub di,2
						mov cx,[bp+8]
						shl cx,1
						add cx,word [bp+10]
						mov ah,0x40
top:					mov al,'@'
						mov [es:di],ax
						sub di,2
						sub cx,1
						jnz top

						pop dx
						pop cx
						pop bx
						pop si
						pop di
						pop ax
						pop es
						pop bp
						ret 8
;-------------------------------------------------------------------------------------------------------------------------------------------------------
PrintForeground:		call PrintSurface
						push word 20
						call PrintHuman
						push word 50
						call PrintHuman
						push word 80
						call PrintHuman
						push word 110
						call PrintHuman
						push word 20
						push word 4
						push word 1
						push word 23
						call PrintBoats
						push word 30
						push word 3
						push word 45
						push word 24
						call PrintBoats
						push word 15
						push word 2
						push word 100
						push word 25
						call PrintBoats
						ret
;------------------------------------------------------------------------------------------------------------------------------------------------------
PrintHuman:		push bp
				mov bp , sp
				push es
				push ax
				push di
				push cx
				push bx

				mov bx , [resolutionColumn]
				shl bx , 1

                mov ax,0xb800
                mov es,ax
                mov ax,[resolutionColumn]
                mov cx,[BodyRow]
                mul cx
                add ax, [bp + 4]
                shl ax,1
                mov di,ax
                push di
                mov cx,3
                mov ah,0x60
                mov al,'|'
bodyline:
                mov [es:di],ax
                sub di, bx
                dec cx
                jnz bodyline

                mov ah,0x60
                mov al, 'o'
                mov [es:di],ax
                push di
                add di, bx
				add di , bx
                sub di,2
                mov ah,0x60

                mov al,'/'
                mov [es:di],ax
                add di,bx
				sub di , 2
                mov ah,0x60
                mov al,'/'
                mov [es:di],ax
                pop di

                add di, bx
				add di , bx
                add di,2
                mov ah,0x60
                mov al,'\'
                mov [es:di],ax

                add di,bx
				add di , 2
                mov ah,0x60
                mov al,'\'
                mov [es:di],ax
                pop di

                sub di,bx
                push di
                add di,bx
				add di , bx
                sub di,2

                mov ah,0x60
                mov al,'/'
                mov [es:di],ax
                add di, bx
				sub di , 2

                mov ah,0x60
                mov al,'/'
                mov [es:di],ax
                pop di
                add di,bx
				add di , bx

                add di,2
                mov ah,0x60
                mov al,'\'
                mov [es:di],ax
                add di,bx

				add di , 2
                mov ah,0x60
                mov al,'\'
                mov [es:di],ax

				pop bx
                pop cx
				pop di
				pop ax
				pop es
				pop bp
				ret 2
;------------------------------------------------------------------------------------------------------------------------------------------------------
PrintSurface:			push es
						push ax
						push di
						push cx
						push bx

						mov ax , 0xb800
						mov es , ax
						mov ax , [reservedStartRow]
						mov cx , [resolutionColumn]
						mul cx
						shl ax , 1
						mov bx , ax
						mov ax , [surfaceStartRow]
						mul cx
						shl ax , 1
						mov di , ax
						mov ah , 0x66
						mov al , ' '
						cld

l6:						stosw
						cmp di , bx
						jne l6

						pop bx
						pop cx
						pop di
						pop ax
						pop es
						ret
;--------------------------------------------------------------------------------------------------------------------------------------------------------
PrintMainScreen:			call PrintReservedSpace
					call PrintForeground
					call PrintBackground
					ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
PrintPlanks:		push bp
					mov bp , sp
					push es
					push ax
					push di
					push cx

					mov ax , 0xb800
					mov es , ax
					mov ax , [resolutionColumn]
					mov cx , [bp +  6]
					mul cx
					mov cx , [bp + 4]
					add ax , cx
					shl ax , 1
					mov di , ax

					mov cx , 15

					cmp word [bp + 8] , 0
					je SetWhite
					cmp word [bp + 8] , 2
					je SetBlue
					mov ah , 0x40
					jmp k

SetWhite:			mov ah , 0x70
					jmp k


SetBlue:			mov ah , 0x30
					cmp word[broken] , 1
					je SetBroken
                    cmp word[broken],2
                    je SetEnd
					mov word [broken] , 1
					jmp k
SetEnd:             mov ah,0x10
                    mov al,' '
                    std
                    rep stosw
                    jmp e4
SetBroken:			mov al , ' '
					std
					push di
					mov ah , 0x10
					rep stosw
					pop di
					sub di , 2
					mov ah , 0x30
					mov cx , 7

b:					stosw
					sub di , 2
					loop b

					jmp e4

k:					mov al , ' '

					std
					rep stosw

e4:					pop cx
					pop di
					pop ax
					pop es
					pop bp
					ret 6
;---------------------------------------------------------------------------------------------------------------------------------------------------------
PrintLevel:			push word [tile2Color]
					push word [moveTileRow2] ; Row
					push word [tile2Column] ; Column
					call PrintPlanks
					push word [tile1Color]
					push word [moveTileRow]
					push word [tile1Column]
					call PrintPlanks
					call PrintCoin
					ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
PrintBox:			push es
					push ax
					push cx
					push di
					push bx

					mov ax , 0xb800
					mov es , ax
					mov ax , [resolutionColumn]
					shl ax , 1
					mov bx , ax
					mov ax , [currentRow]
					mov cx , [resolutionColumn]
					mul cx
					add ax , [currentColumn]
					shl ax , 1
					mov di , ax

					mov ah , 0x1A
					mov al , '_'

					mov [es:di] , ax
					add di , 2
					mov [es:di] , ax
					add di , 2
					mov [es:di] , ax
					add di , 2
					mov al , '|'
					mov [es:di] , ax
					sub di , bx
					mov [es:di] , ax
					sub di , bx
					sub di , 2
					mov al , '_'
					mov [es:di] , ax
					sub di , 2
					mov [es:di] , ax
					sub di , 2
					mov [es:di] , ax
					add di , bx
					sub di , 2
					mov al , '|'
					mov [es:di] , ax
					add di , bx
					mov [es:di] , ax

					pop bx
					pop di
					pop cx
					pop ax
					pop es
					ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
ShiftTile:			push cx

					mov ax , [moveTileRow2]
					mov bx , [currentColumn]
					mov cx , 0

					cmp word [Shiftmode] , 0
					je left
					cmp word [Shiftmode] , 1
					je right
					jmp left2

left:				cmp word[tileMoved] , 15
					je update3

					cmp word [tile1Color] , 2
					je t

					cmp word [tile1Color] , 1
					jne o1

					push word [tile1Column]
					push word [moveTileRow]
					call MoveLeft
					mov cx , 1
					sub word [tile1Column] , 1

o1:					push word [tile1Column]
					push word [moveTileRow]
					call MoveLeft
					mov cx , 1
					sub word [tile1Column] , 1


t:					cmp word [tile2Color] , 2
					je e1

					cmp word [tile2Color] , 1
					jne o4

					push word [tile2Column]
					push word [moveTileRow2]
					call MoveLeft
					mov cx , 1
					sub word [tile2Column] , 1

					push word 37
					call MoveBoxLeft
					push word 36
					call MoveBoxLeft
					push word 35
					call MoveBoxLeft
					sub word [currentColumn] , 1

o4:					push word [tile2Column]
					push word [moveTileRow2]
					call MoveLeft
					mov cx , 1
					sub word [tile2Column] , 1

					push word 37
					call MoveBoxLeft
					push word 36
					call MoveBoxLeft
					push word 35
					call MoveBoxLeft
					sub word [currentColumn] , 1

e1:					cmp cx , 0
					je exit5
					add word [tileMoved] , 1

					jmp exit5

right:				cmp word[tileMoved] , 30
					je update3

					cmp word [tile1Color] , 2
					je q

					cmp word [tile1Color] , 1
					jne o2

					push word [tile1Column]
					push word [moveTileRow]
					call MoveRight
					mov cx , 1
					add word [tile1Column] , 1

o2:					push word [tile1Column]
					push word [moveTileRow]
					call MoveRight
					mov cx , 1
					add word [tile1Column] , 1

q:					cmp word [tile2Color] , 2
					je e2

					cmp word [tile2Color] , 1
					jne o5

					push word [tile2Column]
					push word [moveTileRow2]
					call MoveRight
					mov cx , 1
					add word [tile2Column] , 1

					push word 37
					call MoveBoxRight
					push word 36
					call MoveBoxRight
					push word 35
					call MoveBoxRight
					add word [currentColumn] , 1

o5:					push word [tile2Column]
					push word [moveTileRow2]
					call MoveRight
					mov cx , 1
					add word [tile2Column] , 1

					push word 37
					call MoveBoxRight
					push word 36
					call MoveBoxRight
					push word 35
					call MoveBoxRight
					add word [currentColumn] , 1

e2:					cmp cx , 0
					je exit5
					add word [tileMoved] , 1
					jmp exit5

left2:				cmp word[tileMoved] , 15
					je update3

					cmp word [tile1Color] , 2
					je w

					cmp word [tile1Color] , 1
					jne o3

					push word [tile1Column]
					push word [moveTileRow]
					call MoveLeft
					mov cx , 1
					sub word [tile1Column] , 1

o3:					push word [tile1Column]
					push word [moveTileRow]
					call MoveLeft
					mov cx , 1
					sub word [tile1Column] , 1

w:					cmp word [tile2Color] , 2
					je e3

					cmp word [tile2Color] , 1
					jne o6

					push word[tile2Column]
					push word [moveTileRow2]
					call MoveLeft
					mov cx , 1
					sub word [tile2Column] , 1

					push word 37
					call MoveBoxLeft
					push word 36
					call MoveBoxLeft
					push word 35
					call MoveBoxLeft
					sub word [currentColumn] , 1


o6:					push word[tile2Column]
					push word [moveTileRow2]
					call MoveLeft
					mov cx , 1
					sub word [tile2Column] , 1

					push word 37
					call MoveBoxLeft
					push word 36
					call MoveBoxLeft
					push word 35
					call MoveBoxLeft
					sub word [currentColumn] , 1

e3:					cmp cx , 0
					je exit5
					add word [tileMoved] , 1
					jmp exit5

update3:			mov word [tileMoved] , 0
					add word [Shiftmode] , 1
					cmp word[Shiftmode] , 3
					jne exit5
					mov word [Shiftmode] , 0

exit5:				pop cx
					ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
MoveLeft:			push bp
					mov bp , sp
					push es
					push ds
					push ax
					push di
					push si
					push cx

					mov ax , 0xb800
					mov es , ax

					mov ax , [bp + 4]
					mov cx , [resolutionColumn]
					mul cx
					add ax , [bp + 6]
					shl ax , 1
					mov si , ax
					mov di , si
					sub di , 2

					mov ax , 0xb800
					mov ds , ax
					mov cx , 15
					push si

					std
l10:				movsw
					loop l10

					pop si
					mov word [es:si] , 0x1120

					pop cx
					pop si
					pop di
					pop ax
					pop ds
					pop es
					pop bp
					ret 4
;----------------------------------------------------------------------------------------------------------------------------------------------------------
MoveRight:			push bp
					mov bp , sp
					push es
					push ds
					push ax
					push di
					push si
					push cx

					mov ax , 0xb800
					mov es , ax

					mov ax , [bp + 4]
					mov cx , [resolutionColumn]
					mul cx
					add ax , [bp + 6]
					shl ax , 1
					sub ax , 28
					mov si , ax
					mov di , si
					add di , 2

					mov ax , 0xb800
					mov ds , ax
					mov cx , 15
					push si

					cld

l11:				movsw
					loop l11

					pop si
					mov word [es:si] , 0x1120

					pop cx
					pop si
					pop di
					pop ax
					pop ds
					pop es
					pop bp
					ret 4
;----------------------------------------------------------------------------------------------------------------------------------------------------------
MoveUp:		push es
			push ds
			push ax
			push di
			push si
			push cx
			push bx

			mov bx , [resolutionColumn]
			shl bx , 1

			mov ax , 0xb800
			mov es , ax
			mov ax , [currentRow]
			mov cx , [resolutionColumn]
			mul cx
			add ax , [currentColumn]
			shl ax , 1
			mov si , ax
			mov di , si

			sub di , bx
			sub di , bx
			sub di , bx
			sub di , bx
			mov ax , 0xb800
			mov ds , ax
			mov cx , 4
			cld

l12:		movsw
			sub si , 2
			mov word [es:si] , 0X1120
			add si , 2
			loop l12

			sub si , 2
			sub di , 2
			sub si , bx
			sub di , bx
			movsw
			sub si , 2
			mov word [es:si] , 0X1120
			add si , 2

			sub si , 2
			sub di , 2
			sub si , bx
			sub di , bx
			movsw
			sub si , 2
			mov word [es:si] , 0X1120
			add si , 2

			sub si , 4
			sub di , 4

			std
			mov cx , 4

l13:		movsw
			add si , 2
			mov word [es:si] , 0X1120
			sub si , 2
			loop l13

			add si , 2
			add di , 2
			add si , bx
			add di , bx
			movsw
			add si , 2
			mov word [es:si] , 0X1120
			sub si , 2

			add si , 2
			add di , 2
			add si , bx
			add di , bx
			movsw
			add si , 2
			mov word [es:si] , 0X1120
			sub si , 2

			pop bx
			pop cx
			pop si
			pop di
			pop ax
			pop ds
			sub word [currentRow] , 4
			pop es
			ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
PrintCoin:			push es
					push ax
					push si
					push cx
					push dx
					push bx

					push word 0xCCCC
					push word 30
					call RandomNumberGenerator
					pop dx
					mov bx , dx
					add bx , 82

					mov ax , 0xb800
					mov es , ax
					mov ax , [moveTileRow]
					sub ax , 1
					mov cx, [resolutionColumn]
					mul cx
					add ax , bx
					shl ax , 1
					mov di , ax

					mov ah , 0x16
					mov al , 'O'

					stosw

					pop bx
					pop dx
					pop cx
					pop si
					pop ax
					pop es
					ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
PrintAnimation:		push ax
					push cx

					mov ax , [sunEndRow]
					sub ax , 1
					mov cx , [surfaceStartRow]
					sub cx , ax

l16:				push word 0
					push word ax
					call Shift
					inc ax
					loop l16

					mov ax , [surfaceStartRow]
					mov cx , [reservedStartRow]
					add cx , 3
					sub cx , ax

l17:				push word 1
					push word ax
					call Shift
					inc ax
					loop l17

					call ShiftTile

					pop cx
					pop ax
					ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
PrintLevel2:		push dx
                    mov word [timebomb],0
                    mov word [tickcount],0
					push word 0xCCCC
					push word 3
					call RandomNumberGenerator
					pop dx
					mov [tile1Color] , dx

					cmp word [tile2Color] , 2
					jne p2
					push word [tile2Color]
					push word [moveTileRow2]
					push word [tile2Column]
					call PrintPlanks
                    mov word [timebomb],1
					mov word [broken] , 0
p2:
                    push word [tile1Color]
					push word [moveTileRow]
					push word [tile1Column]
					call PrintPlanks
					call PrintCoin
					pop dx
					ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
RemoveCoin:			push es
					push ax
					push cx
					push di

					mov ax , 0xb800
					mov es , ax
					mov ax , [moveTileRow2]
					sub ax , 1
					mov cx , [resolutionColumn]
					mul cx
					shl ax , 1
					mov di , ax
					sub cx , 1
					mov ah , 0x16
					mov al , 'O'

					cld

					repne scasw
					cmp cx , 0
					je exit6

					sub di , 2
					mov word [es:di] , 0X1120

exit6:				pop di
					pop cx
					pop ax
					pop es
					ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
CheckCoin:			push bp
					mov bp , sp
					push es
					push ax
					push di
					push cx

					mov ax , 0xb800
					mov es , ax
					mov ax , [moveTileRow]
					sub ax , 1
					mov cx, [resolutionColumn]
					mul cx
					add ax , [currentColumn]
					sub ax , 1
					shl ax , 1
					mov di , ax
					mov cx , 6

					mov ah , 0x16
					mov al , 'O'
					cld

					repne scasw
					cmp cx , 0
					jne set

					mov word [bp + 4] , 0
					jmp exit7

set:				mov word [bp + 4] , 1

exit7:				pop cx
					pop di
					pop ax
					pop es
					pop bp
					ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
UpdateScore:		push ax
					push bx

					push 0xCCCC
					call CheckCoin
					pop bx

					cmp bx , 1
					jne exit8
					add word [score] , 10
					push word 2
					push word [score]
					push word 10
					call PrintNumber

exit8:				pop bx
					pop ax
					ret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
MoveBoxLeft:		push bp
					mov bp , sp
					push es
					push ds
					push ax
					push di
					push si
					push cx

					mov ax , [bp + 4]
					mov cx , [resolutionColumn]
					mul cx
					add ax , [currentColumn]
					shl ax , 1
					mov si , ax
					sub si , 2
					mov di , si
					sub di , 2
					mov cx , 15
					mov ax , 0xb800
					mov es , ax
					mov ds , ax

					cld
					rep movsw
					mov word[es:di] , 0X1120
					pop cx
					pop si
					pop di
					pop ax
					pop ds
					pop es
					pop bp
					ret 2
;----------------------------------------------------------------------------------------------------------------------------------------------------------
MoveBoxRight:		push bp
					mov bp , sp
					push es
					push ds
					push ax
					push di
					push si
					push cx

					mov ax , [bp + 4]
					mov cx , [resolutionColumn]
					mul cx
					add ax , [currentColumn]
					shl ax , 1
					mov si , ax
					add si , 6
					push si
					mov di , si
					add di , 2
					mov cx , 15
					mov ax , 0xb800
					mov es , ax
					mov ds , ax

					std
					rep movsw
					pop si

					pop cx
					pop si
					pop di
					pop ax
					pop ds
					pop es
					pop bp
					ret 2
;----------------------------------------------------------------------------------------------------------------------------------------------------------
RandomNumberGenerator:		push bp
							mov bp , sp
							push dx
							push ax
							push cx

                            mov dx,word [extraCounter]
							mov  ax, dx
							xor  dx, dx
							mov  cx, [bp + 4]
							div  cx

							mov [bp + 6] , dx
							pop cx
							pop ax
								pop dx
							pop bp
							ret 2
;----------------------------------------------------------------------------------------------------------------------------------------------------------
timer:		pusha	
			cmp word [escape] , 1
			je skipit
			
            inc word [cs:extraCounter]
            cmp word [cs:timebomb],1
            jne skipit
            inc word [cs:tickcount]
            cmp word [cs:tickcount],90
            jne skipit
            mov word [cs:broken],2
            mov word [cs:setter],1
			
skipit:		mov al , 0x20
            out 0x20 , al

            popa
            iret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
kbisr:		push ax

			push es
			mov ax, 0xb800
			mov es, ax

			in al, 0x60
			
			cmp word [escape] , 1
			je next2
			
			cmp al, 0x39
			jne next
			mov word [keypressed] , 1
			jmp exit9

next:		cmp al , 0x01
			jne next2
			mov word [escape] , 1
			jmp exit9

next2:		cmp word [escape] , 1
			jne nomatch
			cmp al , 0x15
			jne next3
			mov word [yes] , 1
			jmp exit9

next3:		cmp word [escape] , 1
			jne nomatch
			cmp al , 0x31
			jne nomatch
			mov word [no] , 1
			jmp exit9

nomatch:	pop es
			pop ax
			jmp far [cs:oldisr]

exit9:		mov al, 0x20
			out 0x20, al
			pop es
			pop ax
			iret
;----------------------------------------------------------------------------------------------------------------------------------------------------------
start:		mov ah,0x00
			mov al, 0x54
			int 0x10
						
			xor ax, ax
			mov es, ax


			mov ax, [es:8*4]
			mov [timisr], ax

			mov ax, [es:8*4+2]
			mov [timisr+2], ax
			mov ax, [es:9*4]
			mov [oldisr], ax

			mov ax, [es:9*4+2]
			mov [oldisr+2], ax
			cli
			mov word [es:8*4], timer
			mov [es:8*4+2], cs
			

			call PrintFrontScreen
			mov word [es:9*4], kbisr
			mov [es:9*4+2], cs
			sti
			call PrintMainScreen
			call PrintLevel
			call PrintBox


loop1:      cmp word [setter],1
            je e10
            call Delay
			call PrintAnimation

			cmp word [escape] , 1
			jne check2
			call PauseScreen

check2:		cmp word [keypressed] , 1
			jne loop1
			mov ax , [currentColumn]
			add ax , 3
			cmp ax , [tile1Column]
			ja e10
			add ax , 10
			cmp ax , [tile1Column]
			jb e10
			call UpdateScore
			call MoveUp
			mov cx,4

WOL:		call ShiftDown
			call Delay
			call Delay
			call Delay
			loop WOL
			mov ax , [tile1Column]
			mov [tile2Column] , ax
			call RemoveCoin
			call PrintLevel2
			mov word [keypressed] , 0
			jmp loop1

e10:        cli			
			mov ax,[oldisr]
			mov  [es:9*4],ax
			mov ax,[oldisr+2]
			mov  [es:9*4+2],ax
			mov ax,[timisr]
			mov  [es:8*4],ax
			mov ax,[timisr+2]
			mov  [es:8*4+2],ax
			sti
							
			call PrintEndScreen			
			
			xor ax, ax
			int 0x16
			mov ah, 0
			mov al, 3
			int 0x10
			
			mov ax, 0x4c00
			int 0x21