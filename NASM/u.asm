base:           equ 0xfc80          ; Memory base

shots:          equ base+0x00       ; Allocating 2 bytes per shot
                                    ; and some extra space for ignored bullets
                                
old_time:       equ base+0x0c       ; Previous time
level:          equ base+0x10       ; Counter for current level
lives:          equ base+0x11       ; Counter for number of lives remaining 
sprites:        equ base+0x12       ; Allocating space for the sprites table

ship_pos:       equ 0x5c    ;offset     ; The row where the spaceship stays 
video_width:    equ 0x0140          ; Width of the playbox
offset:         equ video_width*2   ; 2 pixels of space between each row
sprite_width:   equ 4               ; Size of each sprite in bytes

        ;
        ; To keep track of all elements I have kept the colour of everything different
        ;

SPACESHIP_COLOR:            equ 0x1c    ; Must be below 0x20
BARRIER_COLOR:              equ 0x0b
SHIP_EXPLOSION_COLOR:       equ 0x0a
INVADER_EXPLOSION_COLOR:    equ 0x0e
BULLET_COLOR:               equ 0x0c
START_COLOR:                equ ((sprites+sprite_width-(shots+2))/sprite_width+0x20)        

        org 0x0100

        mov ax,0x0013   ; Set mode 0x13 (320x200x256 Playbox)
        int 0x10        ; Call BIOS
        cld

        mov ax,0xa000   ; Move ax to where the video memory starts
        mov ds,ax       
        mov es,ax       
        mov ah,0x04
        mov [level],ax  ; Level = 0, Lives = 4

restart_game:
        xor ax,ax
        mov cx,level/2  ; Clears everything on screen

        xor di,di
        rep
        stosw           ; ch is zero from here

        ;
        ; This code controls the descending of the invaders
        ;

        mov ax,[di]     ; ah will contain lives and al will contain level
        inc ax          ; Increasing the level by 2 since invaders go down by 2 pixels
        inc ax
        stosw           
        mov ah,al
        xchg ax,dx   

        ;
        ; This code controls the ship's starting position and color
        ;
        mov ax,SPACESHIP_COLOR*0x0100+0x00
        stosw
        mov ax,ship_pos+0x4c*2
        stosw

        ;
        ; The code controls the invader's starting position and color
        ;
        mov ax,0x08*offset+0x28
        mov bx,START_COLOR*0x0100+0x10
        
set_invaders:      
        mov cl,0x0b             ; There are 11 invaders per row

invader_proto:    
        stosw                   ; Set position of invader
        add ax,0x0b*2           ; Move to the next column
        xchg ax,bx
        stosw                   ; Set color and shape of invader
        inc ah                  ; Move to the next color
        xchg ax,bx
        loop invader_proto                      ; Loop and also make sure ch is zero
        add ax,0x09*offset-0x000b*0x000b*2      ; Move to next row
        cmp bh,START_COLOR+55                   ; All invaders completed?
        jne set_invaders                        ; No, jump

        ;
        ; This will make the barriers
        ;

        mov di,0x55*0x280+0x10*2
        mov cl,5

barrier_create:
        mov ax,BARRIER_COLOR*0x0100+0x04
        call draw_sprite
        add di,0x1e*2
        loop barrier_create

        ; CH is zero

move_invaders:
        mov si,sprites+sprite_width

        ;
        ; Game loop
        ;

        ; Globals:
        ; SI = The next invader to be animated
        ; DL = Current state of the invaders, i.e moving left, right or down (0=left, 1=right, >=2 down)
        ; DH = next state of the invaders
        ; CH = Number of dead invaders
        ; BP = Frame counter
        ;

check_num_invaders:
        cmp byte [si+2],0x20    ; Is the current invader exploding into dust?
        jc move_frame           ; No, jump
        inc ch                  ; Increase count of dead invaders
        cmp ch,55               ; Are all invaders defeated?
        je restart_game         ; Yes, jump

        ;
        ; Yes, invaders speed up
        ;

sprite_drawing:
        lodsw                   ; Load position of sprite into AX
        xchg ax,di              ; Transfer to DI
        lodsw                   ; Get type of sprite(barrier, ship, invader, bullet)
        cmp al,0x28             ; Is it Destroyed?
        je destroy_inv          ; Yes, jump

        cmp al,0x20             ; Is it dust?
        jne draw_inv            ; No, jump
        mov byte [si-2],0x28    ; Else, Don't draw this sprite again

draw_inv:   
        call draw_sprite        ; Draw invader on screen

destroy_inv:   
        cmp si,sprites+56*sprite_width       ; Is the whole board traversed?
        jne check_num_invaders               ; No, jump
        mov al,dh
        sub al,2                ; Is the invader moving down?
        jc move_invaders        ; No, then continue the left/right direction
        xor al,1                ; Else, switch direction
        mov dl,al
        mov dh,al
        jmp move_invaders

move_frame:
        xor byte [si+2],8       ; To animate the invaders(hands up or down)
        inc bp
        and bp,7                ; Each invader

        push dx
        push si
        push bp

        jne handle_bullets

move_frame2:
        mov ah,0x00           
        int 0x1a                ; BIOS command to read the clock
        cmp dx,[old_time]       ; And then wait for change
        je move_frame2
        mov [old_time],dx       ; Save the current time and move to next

handle_bullets:
        ;
        ; This controls the bullets fired by the ship
        ;
        mov si,shots                    ; SI will point to the table with the location of shots
        mov cx,4                        ; There may only be 4 shots at one point
        lodsw                           ; Loads the current position of the ship
        cmp ax,video_width              ; Is the bullet on the top boundary of screen?
        xchg ax,di
        jc delete_bullet_ship           ; If yes, then delete bullet from screen
                                        
        call zero                       ; Remove bullet from shots table
        sub di,video_width+2
        mov al,[di]                     ; Else, read the pixel of the bullet
        sub al,0x20                     ; Is the bullet hitting an invader?
        jc draw_bullet                  ; No, jump

        push si
        push di

        mov ah,sprite_width             ; Else, the invader is hit 
        mul ah                          
        add si,ax
        lodsw
        xchg ax,di
        mov byte [si],0x20                              ; Erase invader next but...
        mov ax,INVADER_EXPLOSION_COLOR*0x0100+0x08      ; ...show explosion first
        call draw_sprite                                ; Draw the explosion/space dust

        pop di
        pop si

        jmp delete_bullet_ship

        ;
        ; This controls the bullet fired by the invader
        ;

inv_bullet:
        lodsw                           ; Read current location of the bullet
        or ax,ax                        ; Is it falling?
        je inv_bullet_cont              ; No, jump
        cmp ax,0x60*offset              ; Is the bullet lower than the spaceship?
        xchg ax,di
        jnc delete_bullet_ship          ; Yes, then remove the bullet
        call zero                       ; Removes bullet from shots table 
        add di,video_width-2            ; Else, bullet continues moving down

        ;
        ; This code draws the bullet
        ;
draw_bullet:
        mov ax,BULLET_COLOR*0x0100+BULLET_COLOR
        mov [si-2],di                               ; The bullet moves down 2 pixels
        cmp byte [di+video_width],BARRIER_COLOR     ; Is there a barrier in its path?
        jne bullet_barrier                          ; If yes, then delete the bullet and that column of barrier

        ; Remove bullet

delete_bullet_ship:    
        xor ax,ax                       ; AX contains zero (DI unaffected)
        mov [si-2],ax                   ; Remove bullet from the shots table

bullet_barrier:    
        cmp byte [di],SPACESHIP_COLOR                       ; Has the bullet collided with the ship?
        jne call_big_pixel                                  ; If no, then jump
        mov word [sprites],SHIP_EXPLOSION_COLOR*0x0100+0x38 ; Else player is killed

call_big_pixel:
        call big_pixel                  ; To draw or erase the bullet

inv_bullet_cont:   
    loop inv_bullet

        ;
        ; This code controls the movement of the ship
        ;
        mov si,sprites                  ; Move si to the current location of the ship
        lodsw                           ; Loads the ship's sprite and colour
        or al,al                        ; Has the ship exploded?
        je destroy_ship                 ; No, jump
        add al,0x08                     ; Keep explosion going on
        jne destroy_ship                ; Is explosion finished? No, jump
        mov ah,SPACESHIP_COLOR          ; Redo color (sprite already)
        dec byte [lives]                ; Decrease life by 1
        js exit                         ; End game if all of the lives are depleted

destroy_ship:   
        mov [si-2],ax                   ; Save the new frame / color
        mov di,[si]                     ; Load position of ship
        call draw_sprite                ; Draw spaceship
        jne move_inv_down               ; Jump if still explosion

        mov ah,0x02                     ; Get Keyboard Flags from BIOS
        int 0x16
  
        test al,0x10                    ; Test for Scroll Lock and exit
        jnz exit

        test al,0x04                    ; Is the Ctrl key pressed?
        jz move_right                   ; No, jump
        dec di                          ; Else, the ship moves 2 pixels to the left
        dec di

move_right:   
        test al,0x08                    ; Is the Alt key pressed?
        jz check_shift                  ; No, jump
        inc di                          ; Else, the ship moves 2 pixels to the right
        inc di

check_shift:
        test al,0x03                    ; Is the shift key pressed?
        jz ship_pos_checker             ; No, jump
        cmp word [shots],0              ; Are there less than 4 bullets on screen?
        jne ship_pos_checker            ; No, jump
        lea ax,[di+(0x04*2)]            ; Offset of bullet from spaceship
        mov [shots],ax                  ; Else, shoot bullet

ship_pos_checker:
        xchg ax,di
        cmp ax,ship_pos-2               ; Change the position of the ship if not touching border
        je move_inv_down
        cmp ax,ship_pos+0x0132
        je move_inv_down

ship_pos_update:   
        mov [si],ax                     ; Change position

move_inv_down:
        pop bp
        pop si
        pop dx

        mov ax,[si]             ; Get the position of the current invader
        cmp dl,1                ; Are the invaders going down (state = 2)?
        jbe inv_mov_checker     ; No, jump
        add ax,0x0280           ; Else, move down by 2 pixels
        cmp ax,0x55*0x280       ; Have the invaders reached the bottom?
        jc bullet_path          ; No, jump

exit:
        mov ax,0x0003           ; Restore original window resolution
        int 0x10
        
        int 0x20                ; Exit to DOS

inv_mov_checker:    
        dec ax                  ; Moving to left
        dec ax
        jc border_check_inv
        add ax,4                ; Moving to right

border_check_inv:   
        push ax
        shr ax,1                ; Divide position by 2...
        mov cl,0xa0             ; ...means we can get column dividing by 0xa0
        div cl                  ; ...instead of 0x0140 (longer code)
        dec ah                  ; Convert 0x00 to 0xff
        cmp ah,0x94             ; Are the invaders touching the border? (>= 0x94)
        pop ax
        jb bullet_path          ; No, jump
        or dh,22                ; Else, goes down by 11 pixels (11 * 2) must be odd

bullet_path:    
        mov [si],ax
        add ax,0x06*0x280+0x03*2    ; Offset for bullet
        xchg ax,bx

        mov cx,3                    ; ch = 0 - invader alive
        in al,(0x40)                ; Input timer
        cmp al,0xfc                 ; Is there an event happening?
        jc sprite_drawing_handler   ; No, jump

        mov di,shots+2

search_slot:   
        cmp word [di],0             ; Search for a free slot for a bullet
        je inv_shots_handler        ; If its free, then jump!
        scasw                       ; Advance DI until 3 shots are searced
        loop search_slot            

inv_shots_handler:
        mov [di],bx                 ; Start invader shot or put in ignored slot

sprite_drawing_handler:
        jmp sprite_drawing

        ;
        ; Bitmaps for sprites
        ;

bitmaps:
        db 0x18,0x18,0x3c,0x24,0x3c,0x7e,0xFf,0x24      ; Spaceship
        db 0x00,0x80,0x42,0x18,0x10,0x48,0x82,0x01      ; Explosion
        db 0x00,0xbd,0xdb,0x7e,0x24,0x3c,0x66,0xc3      ; Alien (Hand up)
        db 0x00,0x3c,0x5a,0xff,0xa5,0x3c,0x66,0x66      ; Alien (Hands down)
        db 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00      ; Remove

        ;
        ; Draw pixel per Carry (use AX if Carry=1 or zero if Carry=0)
        ;

bit:    
        jc big_pixel

zero:   
        xor ax,ax
        
        ; Draw a big pixel (2x2 pixels)/used to add a flicker effect when ship is hit

big_pixel:
        mov [di+video_width],ax
        stosw
        ret

        ; ah = sprite color
        ; al = sprite (x8)
        ; di = Target address

draw_sprite:    
        push cx
        push di
        pushf

sprite_space_allocator:    
        push ax
        mov bx,bitmaps
        cs xlat                                 ; Extract one byte from bitmap
        xchg ax,bx                              ; bl contains byte, bh contains color
        mov cx,10                               ; Two extra zero pixels at left and right
        clc                                     ; Left pixel as zero (clean)

drawing:    
        mov al,bh                               ; Move the colour info to AX
        mov ah,bh
        call bit                                ; Draw pixel
        shl bl,1
        loop drawing
        add di,offset-20                        ; Go to the next line in video memory
        pop ax
        inc ax                                  ; Next bitmap byte
        test al,7                               ; Is the sprite complete?
        jne sprite_space_allocator              ; No, jump
    
        popf
        pop di
        pop cx

        ret

    