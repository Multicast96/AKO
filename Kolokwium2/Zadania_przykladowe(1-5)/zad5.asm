.686
.model flat

public _szyfruj

.code

_szyfruj PROC
	push ebp
	mov ebp,esp

	push ebx
	push esi

	mov esi,[ebp+8]
	mov ebx, 52525252h

nastepny_bajt:
	mov al,[esi]
	cmp al,0 ;jesli bajt zero to koniec tekstu
	jz koniec

	xor al,bl ;szyfrowanie bajtu
	mov [esi], al ;zapis do pamieci zaszyfrowanego bajtu
	inc esi

	mov edx,ebx
	shl edx, 1 ;bit 30 przestawiamy na miejsce 31
 	xor edx,ebx ;interesuje nas ebx[30] xor ebx[31]
	bt edx,31 ;zapisujemy do CF wynik ebx[30] xor ebx[31]
	rcl ebx, 1 ;CF trafia do ebx[0], a ca³a liczba jest przesuniêta bitowo o 1 w lewo
	jmp nastepny_bajt

koniec:
	pop esi
	pop ebx
	pop ebp
	ret
_szyfruj ENDP

END