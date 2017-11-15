.686
.model flat

	extern _ExitProcess@4 : PROC
	extern __write : PROC
	public _main

.data

dane db 11101010b, 01001000b, 01101101b, 00000010b, 0011010b, 11101111b, 00000100b, 00010000b, 01000000b , 00000000b
wynik db 15 dup(?)

Sty dd 255,256
Lut dw 16,17,18,19
Mar db 8,9,10,11

.code
;-----------ZAD 3------------;
uuencode PROC
	pusha

	xor eax,eax ;miejsce na pobrane 3 bajty
	xor ebx,ebx

pobieraj_dane:
	mov ecx, 3
ptl: ;pobranie 3 bajtów danych
	mov al, [esi]
	cmp al, 0 ;jeœli 0 to bajt koñczy ci¹g danych
	jz koniec_tekstu
	inc esi
koniec_tekstu:
	shl eax,8
	loop ptl

	;shl eax, 8; przesuniêcie wcztanych bajtów maksymalnie do lewej strony
	mov ecx, 4; licznik pêtli tworz¹cej 4 znaki ASCII i 3 pobranych bitów
ptl2:
	rol eax, 6
	mov bl, al
	and bl, 3Fh
	add bl, 20h
	mov [edi], bl
	inc edi
	loop ptl2

	mov bl, [esi]
	cmp bl, 0
	jnz pobieraj_dane

	popa
	ret
uuencode ENDP
;-----------ZAD 3 END------------;


_main:
	mov esi , offset dane
	mov edi , offset wynik
	call uuencode

	push 11
	push edi
	push 1
	call __write
	add esp, 12

;-----------ZAD 1------------; ;Tu chyba by³ b³¹d. Zamiast "sub" da³em "mov".
	mov edi, Mar - byte PTR Lut ; Nie czajê co siê tu dzieje Mar - Lut i dlaczego wynik jest 8h :( 
	mov ebx, Sty[edi]
	add bl, Mar
;-----------ZAD 1 END------------;

;-----------ZAD 2------------;
	mov ebx, 165227h
	shl ebx, 0Ah
	add ebx, 40000000h
;-----------ZAD 2 END------------;

	push 0
	call _ExitProcess@4

END