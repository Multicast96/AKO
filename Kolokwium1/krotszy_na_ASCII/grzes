.686

.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
public _main

.data	      
 tekst db 01100001b, 10111101b, 10101101b, 11001010b , 10100100b, 10111011b, 10101100b , 01001001b, 01100101b, 00000000b
 wynik db 20 dup (?)

.code

pobierz5bitow PROC	;5 bitow w al, popierane z adresu [esi] oraz bitu numer cl
	mov ax, word PTR [esi]
	shr ax, cl
	and al, 00011111b

	ret
pobierz5bitow ENDP

krotszy_na_ASCII PROC
	push ebx
	push esi

	mov ebx, 0	;iterator po wyniku
start:
	movzx ax, cl

	push ebx	;potrzeba mi rejestru dla dzielnika
	mov bl, 8
	div bl	;w al wynik, w ah reszta
	mov cl, ah
	movzx ebx, al
	add esi, ebx
	pop ebx		

	call pobierz5bitow	;w al mamy 5 zadanych bitow
	add cl, 5
znaki:
	cmp al, 0
	jz koniec_ciagu
	cmp al, 27
	je spacja
	add al, 60h
	mov wynik[ebx], byte PTR al
	inc ebx
	jmp start

spacja:
	mov wynik[ebx], byte PTR 20h
	inc ebx
	jmp start
	
koniec_ciagu:
	mov wynik[ebx], 0
	pop esi
	pop ebx
	ret
krotszy_na_ASCII ENDP

_main:
	xor eax, eax
	mov esi, OFFSET tekst	;adres bufora
	mov edi, OFFSET wynik	;adres wyniku
	mov cl, 0	;numer bitu (0-7)

	call krotszy_na_ASCII

wypisz:	
	push 0
	push OFFSET wynik
	push OFFSET wynik
	push 0
	call _MessageBoxA@16
koniec:
	push 0
	call _ExitProcess@4 
END
