.model	tiny 
	org		0100h		
.data 
	
	 COLUMN_NUM EQU 80
	
	;========piano==========
	delaynote dw ?
	
	MIDI_CONTROL_PORT dw 0331h
    MIDI_DATA_PORT dw 0330h
    MIDI_UART_MODE db 3Fh
    MIDI_PIANO_INSTRUMENT db 93h
	
	;========startpage===========
	 
	_str1 db "      ***       ***    ****   ******** ********   ****  **     **           $",0
	_str2 db "      *****  ******   **  **  ******** *********  ****   **   **            $",0
	_str3 db "      ** ******  **  **    **    **    **     **   **     ** **             $",0
	_str4 db "      **   **    **  ********    **    *********   **      ***              $",0
	_str5 db "      **         **  **    **    **    ********    **      ***              $",0
	_str6 db "      **         **  **    **    **    **   **     **     ** **             $",0
	_str7 db "      **         **  **    **    **    **    **   ****   **   **            $",0
	_str8 db "      **         **  **    **    **    **     **  ****  **     **           $",0
	
	mode	db		9,9,9,9,'   EASY  ',10,10,13
			db		9,9,9,9,'   NORMAL',10,10,13
			db		9,9,9,9,'   HARD  ',10,10,13
			db		9,9,9,9,'   Exit$'
			
	;===================
	menuSel db 1
	positionX db COLUMN_NUM DUP(?)
	positmp db 0
	checkFall DB COLUMN_NUM DUP(?)
	countcol db 0
	numberfall db 0
	Nfall db 0
	delayfall dw 0
	delaytime dw 0
	countdownfall dw 0
	gunpos db 40
	gunposdi dw 40
	
	nlife db 9
	life db 'LIFE :$'
	over db 'GAME OVER$' 
	;===================
	seed dw  0
	positionRAND dw 0
	ranchar db 0
	delayrain dw 0

.code
org     0100h
			
		
main:	
		
		call startpage ;call menu page
		
;===========================Piano Sound=====================================

PauseIt proc near uses ax cx es
        mov  cx, delaynote
        mov  ax,0040h
        mov  es,ax

        ; wait for it to change the first time
        mov  al,es:[006Ch]
@a:     cmp  al,es:[006Ch]
        je   short @a

        ; wait for it to change again
loop_it:mov  al,es:[006Ch]
@b:     cmp  al,es:[006Ch]
 		
        je   short @b

        sub  cx,55
        jns  short loop_it
        ret
PauseIt endp
	
play_note:
    add al, ch;             apply the octave
    out dx, al;             DX will already contain MIDI_DATA_PORT from the setup_midi function
    mov al, 7Fh;            note duration
    out dx, al
    ret
	
setup_midi:
    push ax

    mov dx, MIDI_CONTROL_PORT
    mov al, MIDI_UART_MODE; play notes as soon as they are recieved
    out dx, al

    mov dx, MIDI_DATA_PORT
    mov al, MIDI_PIANO_INSTRUMENT
    out dx, al

    pop ax
    ret	

;octave 4 = 0*12 + 60 = 60
;octave 5 = 1*12 + 60 = 72
;octave 6 = 2*12 + 60 = 84
;octave 7 = 3*12 + 60 = 96


;=======================================================================================================================

C0: call setup_midi
    mov ch, 0;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

C1: call setup_midi
    mov ch, 24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D1: call setup_midi
    mov ch, 24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret

E1: call setup_midi
    mov ch, 24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret

F1: call setup_midi
    mov ch, 24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret

G1: call setup_midi
    mov ch,24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret

A1: call setup_midi
    mov ch, 24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B1: call setup_midi
    mov ch, 24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C1s: call setup_midi
     mov ch, 24;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D1s: call setup_midi
     mov ch, 24;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E1s: jmp F1
     ret

F1s: call setup_midi
     mov ch, 24;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves 
     mov al, 6
     call play_note
     call PauseIt
     ret

G1s: call setup_midi
     mov ch, 24;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A1s: call setup_midi
     mov ch, 24;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B1s: jmp B1
     ret
     ;====1

C2: call setup_midi
    mov ch, 36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D2: call setup_midi
    mov ch, 36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret

E2: call setup_midi
    mov ch, 36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret

F2: call setup_midi
    mov ch, 36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret

G2: call setup_midi
    mov ch,36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret

A2: call setup_midi
    mov ch, 36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B2: call setup_midi
    mov ch, 36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C2s: call setup_midi
     mov ch, 36;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D2s: call setup_midi
     mov ch, 36;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E2s: jmp F2
     ret

F2s: call setup_midi
     mov ch, 36;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves 
     mov al, 6
     call play_note
     call PauseIt
     ret

G2s: call setup_midi
     mov ch, 36;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A2s: call setup_midi
     mov ch, 36;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B2s: jmp B2
     ret
     ;====2

	
C3: call setup_midi
    mov ch, 48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D3: call setup_midi
    mov ch, 48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret

E3: call setup_midi
    mov ch, 48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret

F3: call setup_midi
    mov ch, 48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret

G3: call setup_midi
    mov ch,48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret

A3: call setup_midi
    mov ch, 48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B3: call setup_midi
    mov ch, 48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C3s: call setup_midi
     mov ch, 48;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D3s: call setup_midi
     mov ch, 48;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E3s: jmp F3
     ret

F3s: call setup_midi
     mov ch, 48;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves 
     mov al, 6
     call play_note
     call PauseIt
     ret

G3s: call setup_midi
     mov ch, 48;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A3s: call setup_midi
     mov ch, 48;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B3s: jmp B3
     ret
	 


;=======================================================================================================================
C4: call setup_midi
    mov ch, 60;            
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D4: call setup_midi
    mov ch, 60;             
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret

E4: call setup_midi
    mov ch, 60;           
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret

F4: call setup_midi
    mov ch, 60;             
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret

G4: call setup_midi
    mov ch, 60;             
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret

A4: call setup_midi
    mov ch, 60;       
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B4: call setup_midi
    mov ch, 60;             
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C4s: call setup_midi
     mov ch, 60;             
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D4s: call setup_midi
     mov ch, 60;             
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E4s: jmp F4
     ret

F4s: call setup_midi
     mov ch, 60;             
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves 
     mov al, 6
     call play_note
     call PauseIt
     ret

G4s: call setup_midi
     mov ch, 60;             
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A4s: call setup_midi
     mov ch, 60;            
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B4s: jmp B4
     ret
	 

	
;=============================================================================================================
C5: call setup_midi
    mov ch, 72;             
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D5: call setup_midi
    mov ch, 72;            
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret
E5: call setup_midi
    mov ch, 72;             
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret
F5: call setup_midi
    mov ch, 72;             default octave(1)
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret
G5: call setup_midi
    mov ch, 72;             default octave(1)
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret
A5: call setup_midi
    mov ch, 72;             default octave(1)
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B5: call setup_midi
    mov ch, 72;             default octave(1)
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C5s: call setup_midi
     mov ch, 72;             default octave(1)
     mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D5s: call setup_midi
     mov ch, 72;             
     mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E5s: jmp F5
     ret

F5s: call setup_midi
     mov ch, 72;             
     mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves 
     mov al, 6
     call play_note
     call PauseIt
     ret
G5s: call setup_midi
     mov ch, 72;             
     mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A5s: call setup_midi
     mov ch, 72;             
     mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B5s: jmp B5
     ret


	
;=====================================================================================================================
C6: call setup_midi
    mov ch, 84;             
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D6: call setup_midi
    mov ch, 84;            
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret
E6: call setup_midi
    mov ch, 84;             
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret
F6: call setup_midi
    mov ch, 84;            
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret
G6: call setup_midi
    mov ch, 84;             
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret
A6: call setup_midi
    mov ch, 84;             
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B6: call setup_midi
    mov ch, 84;            
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C6s: call setup_midi
     mov ch, 84;            
     mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D6s: call setup_midi
     mov ch, 84;             
     mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E6s: jmp F6
     ret

F6s: call setup_midi
     mov ch, 84;             
     mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves 
     mov al, 6
     call play_note
     call PauseIt
     ret
G6s: call setup_midi
     mov ch, 84;            
     mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A6s: call setup_midi
     mov ch, 84;             
     mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B6s: jmp B6
     ret


;=====================================================================

C7: call setup_midi
    mov ch, 96;             
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D7: call setup_midi
    mov ch, 96;           
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret
E7: call setup_midi
    mov ch, 96;            
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret
F7: call setup_midi
    mov ch, 96;             
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret
G7: call setup_midi
    mov ch, 96;             
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret
A7: call setup_midi
    mov ch, 96;             
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B7: call setup_midi
    mov ch, 96;            
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C7s: call setup_midi
     mov ch, 96;             
     mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D7s: call setup_midi
     mov ch, 96;            
     mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E7s: jmp F7
     ret

F7s: call setup_midi
     mov ch, 96;            
     mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves 
     mov al, 6
     call play_note
     call PauseIt
     ret
G7s: call setup_midi
     mov ch, 96;             
     mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A7s: call setup_midi
	 mov ch, 96;            
     mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B7s: jmp B7
     ret

;======================================================================================
music_intro:  ; intro music gen by F above
	
	mov delaynote,100
	call C6
	call D6
	call E6
	mov delaynote,10
	call G3
	call D4
	call E4
	call G5
	call E5
	mov delaynote,100
	call E6
	call G6
	call F6
	call E6
	call D6
	mov delaynote,10
	call B5
	call G5
	call G3
	call B3
	call D4
	mov delaynote,100
	call G5
	call B3
	call C4
	call D4
	call G4
	mov delaynote,100
	call B5
	call C6
	call D6
	call E6
	call F6
	mov delaynote,10
	call B3
	call G5s
	call E6
	mov delaynote,100
	call E6
	call D6
	mov delaynote,80
	call D6
	call C6
	call C6
	mov delaynote,100
	call G6
	mov delaynote,80
	call F6
	call E6
	call D6
	mov delaynote,100
	call C6
	call D6
	call G6
	mov delaynote,80
	call F6
	call E6
	mov delaynote,100
	call C6
	call D6
	mov delaynote,10
	call D6
	call D6
	call D6
	call D6
	
    ret	
	
music_over:  ; end music gen by F above
	mov delaynote,0
	call G1
	call B2
	call G3
	call G1
	call B2
	call G3
	call G1
	call B2
	call G3
	call G1
	call B2
	call G3
	mov delaynote,80
	call G1
	call B2
	call G3
	mov delaynote,90
	call F5
	mov delaynote,10
	call A2
	mov delaynote,0
	call B2
	call F5
	mov delaynote,80
	call F5
	mov delaynote,10
	mov delaynote,0
	call B2
	call F5
	mov delaynote,100
	call F5
	call E5
	call C5
	ret
;======================================================================================
	
startpage:

		mov ah, 00h     ; Set back to 80x25
		mov al, 03h
		int 10h 
	
		mov ah,02h     ; set curcor position
		mov bh,00h
		mov dh,4
		mov dl,3
		int 10h
		
		;print "MATRIX"
		mov ah, 09h													
		mov dx, offset _str1[0]
		int 21h

		mov ah,02h
		mov bh,00h
		mov dh,5
		mov dl,3
		int 10h
 
		mov ah, 09h
		mov dx, offset _str2[0]
		int 21h

		mov ah,02h
		mov bh,00h
		mov dh,6
		mov dl,3
		int 10h

		mov ah, 09h
		mov dx, offset _str3[0]
		int 21h

		 mov ah,02h
		mov bh,00h
		mov dh,7
		mov dl,3
		int 10h

		mov ah, 09h
		mov dx, offset _str4[0]
		int 21h

		 mov ah,02h
		mov bh,00h
		mov dh,8
		mov dl,3
		int 10h

		mov ah, 09h
		mov dx, offset _str5[0]
		int 21h

		 mov ah,02h
		mov bh,00h
		mov dh,9
		mov dl,3
		int 10h

		mov ah, 09h
		mov dx, offset _str6[0]
		int 21h

		mov ah,02h
		mov bh,00h
		mov dh,10
		mov dl,3
		int 10h

		mov ah, 09h
		mov dx, offset _str7[0]
		int 21h

		mov ah,02h
		mov bh,00h
		mov dh,11
		mov dl,3
		int 10h

		mov ah, 09h
		mov dx, offset _str8[0]
		int 21h
		
		mov ah,02h
		mov bh,00h
		mov dh,15
		mov dl,4
		int 10h
		
		
		call music_intro

;===========================================		
		
		mov		ah, 09h
		mov		dx, offset mode	    ;print
		int		21h
		
		mov ah, 02h		;Set cursor position
		mov bh, 00h	
		mov dh, 14
		add dh, menuSel	;set row			
		mov dl, 0
		add dl, 33	    ;set column			
		int 10h
		
		mov		ah, 09h
		mov		bh, 01
		mov		al, 0AFh
		mov		cx, 1
		mov		bl, 0Ch
		int		10h
		
waitselect:		
		mov		ah, 01h		; check key press
		int		16h
		jnz		checkselect ; if key was press->jmp
		jmp		waitselect  ; if not->loop
		
checkselect:
		;the key was up, down or spacebar
		mov		ah, 00h
		int		16h
		cmp		ah, 48h
		jz		upKey
		cmp		ah,	50h
		jz		downKey
		cmp		ah,	1Ch 
		jnz		waitselect ;if not spacebar back to waitselect
		
		;if select exit->goto exit
		cmp		menuSel, 7
		jz		exitSeltmp
		;if not goto setting
		jnz		setting	

upKey: ; ship above 2 space
		mov		al, menuSel
		cmp		al, 1
		je		waitselect
		
		sub		menuSel, 2
		jmp		moveSel

downKey: ; ship down 2 space
		mov		al, menuSel
		cmp		al, 7
		je		waitselect
		
		add		menuSel, 2
		jmp		moveSel
		
moveSel: ; move cursor position
		mov		ah, 09h
		mov		bh, 00h
		mov		al, 00h
		mov		cx, 1
		mov     bl, 06h
		int		10h         ;blank

		mov ah, 02h		;Set cursor position
		mov bh, 00h	
		mov dh, 14
		add dh, menuSel	;set row			
		mov dl, 0
		add dl, 33	;set column			
		int 10h
		
		mov		ah, 09h
		mov		bh, 01
		mov		al, 0AFh
		mov		cx, 1
		mov		bl, 0Ch
		int		10h
		
		jmp		waitselect
		
		ret
;===============================================================
exitSeltmp:
 jmp exitSel
;=======================begingame===============================

setting: ;set life to 0
		mov nlife, 9
		;set value of each mode
		cmp menuSel, 1
		je seteasy
		
		cmp menuSel, 3
		je setnormal
		
		cmp menuSel, 5
		je sethard
				
seteasy: 
		mov numberfall, 5   ; 5+1 matrixs can be release
		mov delayfall, 1000 ; delay 1000
		jmp setscreen

setnormal:
		mov numberfall, 7  ; 7+1 matrixs can be release
		mov delayfall, 700 ; delay 700
		jmp setscreen

sethard:
		mov numberfall, 10 ; 10+1 matrixs can be release
		mov delayfall, 500 ; delay 500
		jmp setscreen
;--------------------------------------------------------		
setscreen:
		mov     ah, 00h         ; Set to 80x25
        mov     al, 03h
        int     10h 
		
		mov dh, 21      ; set edge at bottom
		mov dl, 0
		
		MOV	CL, 80
		mov al, '='
		mov bl, 0Ch
		
		L1:             ; print edge
			call setCursor
			call printCHAR
			mov delaytime, 30000
			call DELAY_TIME
			inc dl
			DEC	CL
			JNZ	L1
		
		mov dh, 20      ;print gun
		mov dl, gunpos
		call setCursor
		mov al, 193
		mov bl, 0Ah
		call printCHAR
		
		mov		ah, 02h  ;print "LIFE"
		mov		bh, 00h
		mov		dl, 3
		mov		dh, 23
		int		10h
		
		mov		ah, 09h
		mov		dx, offset life
		int		21h
		
		call lifeshow   ;print life bar
		
		
		call rand_column           ; mark busy slot ready to fall
			xor  dh,dh
			mov  positionRAND,dx
			mov  bx,positionRAND
			mov checkFall[bx], -1
			mov positionX[bx], 0
		
		
;========================	
begingame:                  ;start game
		cmp nlife,0
		jle gameover
		
		mov		ah, 01h		; key press?
		int		16h
		jnz		checkKey1
		mov dh, 20          ;print gun
		mov dl, gunpos
		call setCursor
		mov al, 193
		mov bl, 0Ah
		call printCHAR
		
		delay:		
			mov 	ah, 86h		; delay
			mov 	cx, 00h
			mov		dx, 05h
			int 	15h
			
		delaynumfall:             ; default delay of fall
		    cmp countdownfall,300
			je check_Numfall
			inc countdownfall
			jmp check_rain
			
		check_Numfall:            ; check number of fallen matrixs
			mov countdownfall,0
			mov al, numberfall
			mov ah, Nfall
			cmp al,ah
			jle check_rain        ; if full dont release      
			
			inc Nfall
			call rand_column      ; mark busy slot ready fall
			xor  dh,dh
			mov  positionRAND,dx
			mov  bx,positionRAND
			mov checkFall[bx], -1
			
			
		check_rain:				 ; delay of fall depend on level
			mov ax, delayfall
			mov dx, delayrain
			cmp ax, dx
			ja tmpb
			
			mov delayrain, 0
			
			mov di, 0
			mov countcol, 0
			
			call rain	;move matrix
		tmpb: 
			inc delayrain
			
			jmp begingame
;==========================================
			
checkKey1:
jmp checkKey
			
gameover:           ; game over (life<=0)
	mov ah, 00h     ; Set back to 80x25
	mov al, 03h
	int 10h 
	
	mov		ah, 02h ; print "GAMEOVER"
	mov		bh, 00h
	mov		dl, 36
	mov		dh, 12
	int		10h
		
	mov		ah, 09h
	mov		dx, offset over
	int		21h	
	
    call music_over  ;call end music
	jmp exitSel2     ;exit
	ret	
	
;=====================================
begingame1:
jmp begingame
  
;=============ahoot=======================		
checkKey: ;check what the key was 
		mov		ah, 00h
		int		16h
		cmp		ah, 4bh
		jz		leftKey
		cmp		ah,	4dh
		jz		rightKey
		cmp		ah,	39h
		jz		spacebar
		cmp		al, 1Bh
		jz		exitSel3
	
leftKey: ;press left-> shift to left 2 space
		mov dh, 20      ;delete previous gun
		mov dl, gunpos
		call setCursor	
		mov al, 00h 	;Print null
		mov bl, 06h 	;black color
		call printCHAR
		
		cmp gunpos,0   ;if gunpos >0 shift to left
		je tmpl
		dec gunpos
		dec gunposdi
		
		tmpl:
		mov dh, 20      ;print gun
		mov dl, gunpos
		call setCursor
		mov al, 193
		mov bl, 0Ah
		call printCHAR
		
		jmp begingame

exitSel3:
jmp exitSel2
		
rightKey: ;press right-> shift to right 2 space
		mov dh, 20      ;delete previous gun
		mov dl, gunpos
		call setCursor
		mov al, 00h     ;Print null
		mov bl, 06h     ;black color
		call printCHAR
		
		cmp gunpos,79   ;if gunpos <80 shift to right
		je tmpr
		inc gunpos
		inc gunposdi
		
		tmpr:
		mov dh, 20      ;print gun
		mov dl, gunpos
		call setCursor
		mov al, 193
		mov bl, 0Ah
		call printCHAR
		
		jmp begingame
		
		
gameover1:
jmp gameover
		
spacebar: ;press spacebar -> shoot	

		mov	CL, 19

		mov dh, 19     ;set position at gunpos
		mov dl, gunpos
		
		call setCursor
		mov al, 254
		mov bl, 0Eh
		call printCHAR ;print bullet
		mov delaytime, 30000
		call DELAY_TIME
		
		mov di, gunposdi
		cmp checkFall[di],-1
		jne L2
		;shot the matrix
		mov checkFall[di], 0 ;reset value
		mov positionX[di], 0
		dec Nfall
		
		L2: ;loop bullet movement
			mov al, 00h ;Print null
			mov bl, 06h ;black color
			call printCHAR ;delete bullet
			
			dec dh
			
			call setCursor
			mov al, 254
			mov bl, 0Eh
			call printCHAR ;print bullet
			
			call DELAY_TIME
	
			DEC	CL
			JNZ	L2
			
		;blank the column	
		mov dh, 0
		call blankcol
		
		jmp begingame
		

rain:	;rain fall
		cmp positionX[di],20
		je reset ; if fall to bottom
		
		cmp checkFall[di], -1
		je falling ; still falling
		
		jmp ignore
		
		reset: ; matrix fallen
			;reset value
			mov positionX[di],0
			mov checkFall[di],0
			dec Nfall
			;life -1
			dec nlife
			;update life bar
			call lifeshow
			;blank the column
			mov dh, 0
			mov dl, countcol
			call blankcol
			jmp ignore
			
		falling: ;matrix is falling to positionX
			mov ah, positionX[di]
			mov positmp, ah
			call fall
			inc positionX[di]
			jmp ignore
		
		ignore:
		;back to rain
		inc di
		inc countcol
		cmp di, 80
		jl rain
		
		ret
		
exitSel2:
jmp exitSel	
	
;--------------------------------------------------------

blankcol: ; use to blank entry column
		;input dh : Y =0
		;input dl : X
		call setCursor
		mov al, 00h ;Print null
		mov bl, 06h ;black color
		call printCHAR 
		inc dh
		cmp dh,20
		jl blankcol
		
		ret

endfall1:
		jmp endfall
;--------------------------------------------------------	
fall:	;matrix fall down 1 space
		call rand_char ; generate character to char_array
		;char1 white
		mov dh, positmp     
		mov dl, countcol
		call setCursor
		
		mov al, ranchar
		mov bl, 0Fh
		call printCHAR 
		
		dec positmp
		cmp positmp,0 
		jl endfall1

		;char2 green
		mov dh, positmp  
		mov dl, countcol
		call setCursor
		
		mov al, ranchar
		mov bl, 0Ah
		call printCHAR 
		
		dec positmp
		cmp positmp,0 
		jl endfall
		
		;char3 green
		mov dh, positmp    
		mov dl, countcol
		call setCursor
		call printCHAR 
		
		dec positmp
		cmp positmp,0 
		jl endfall
		
		;char4 dark green
		mov dh, positmp  
		mov dl, countcol
		call setCursor
		
		mov al, ranchar
		mov bl, 02h
		call printCHAR 
		
		dec positmp
		cmp positmp,0 
		jl endfall
		
		;char5 grey
		mov dh, positmp  
		mov dl, countcol
		call setCursor
		
		mov al, ranchar
		mov bl, 08h
		call printCHAR 
		
		dec positmp
		cmp positmp,0 
		jl endfall
		
		;NULL
		mov dh, positmp  
		mov dl, countcol
		call setCursor
	
		mov al, 00h ;Print null
		mov bl, 06h ;black color
		call printCHAR 
		
		endfall:
		
		ret

;--------------------------------------------------------		
		
lifeshow: ;use to show life bar

		mov dh, 23 
		mov dl, 11
		call setCursor
		
		mov 	AH,09h
		mov		BH,00h
		mov		BL,02h
		mov		AL,' '
		mov 	CX,9
		mov 	DL,0
		mov		DH,24
		INT		10h
	   
		mov 	BL, 20h     ; 5-8 green 3-4 orange 1-2 red
		CMP  	nlife,4
		JA      prnt
		mov 	BL, 0E0h
		CMP 	nlife,2
		JA  	prnt 
		mov 	BL, 40h
			    ;BL color   ;20h green 40h red E0h orange
		prnt:
		mov		AL,' '
		mov     AH, 09h		;print green block
		mov     BH, 00h
		mov     CL, nlife   ;print green box follow nlife
		INT 	10h
	   
		RET

;--------------------------------------------------------
rand_column: ; random mode
		mov ax, [seed]
		mov bx, 997
		mul bx                  ; RAND = RAND*P1
		add ax, 65519            ; RAND += P2      
		and ax, 65535          ; RAND %= RAND_MAX
		mov [seed], ax

		xor dx, dx      
		mov bx, 60
		div bx  
							; dl now between 0 and 59
		ret
;--------------------------------------------------------
rand_char: ; random character
		push bx
        mov ax, [seed]
        mov bx, 997
        mul bx                  ; RAND = RAND*P1
        add ax, 65519            ; RAND += P2      
        and ax, 65535          ; RAND %= RAND_MAX
        mov [seed], ax

        xor dx, dx      
        mov bx, 75
        div bx                 ; dl now between 0 and 74
        add dx,48				 ; dl now between 48 and 122
        cmp dx,57
        jbe correct_char
        cmp dx,90
        jbe check_char1
        ja check_char2
check_char1:
		cmp dx,65
		jae correct_char
		pop bx
		jmp rand_char
check_char2:
		cmp dx,96
		ja correct_char
		pop bx
		jmp rand_char
correct_char: ; exit when character is not special character
		pop bx
		mov ranchar,dl
		ret		

;--------------------------------------------------------
DELAY_TIME:
	 ;delay to show movement
	 push cx
	 mov cx,delaytime
	 LOOP_DELAY2:

	 loop LOOP_DELAY2
	 pop cx
	 RET
;--------------------------------------------------------
setCursor: ; use to set cursor position
		   ; input dl,dh
	 push dx
	 push bx
	 push ax
	 mov ah, 02h 
	 mov bh, 00h
	 int 10h
	 ; Move cursor position
	 pop ax
	 pop bx
	 pop dx
	 RET
;--------------------------------------------------------
printCHAR: ; use to print a character
	 ; input: al = char
	 ;        bl = color
	 push cx
	 push ax

	 mov ah, 09h
	 mov bh, 00h
	 mov cx, 0001h
	 int 10h

	 pop ax
	 pop cx
	 RET
;--------------------------------------------------------
exitSel:
	mov ah, 00h     ; Set back to 80x25
	mov al, 03h
	int 10h 
	
	
ret
     end main 