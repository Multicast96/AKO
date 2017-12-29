.686
.model flat

public _zad8

.data
liczba dd 1.2
liczba1 dd 120

.code
_zad8 PROC
	push ebx

	;mov ebx, 0A4h
	mov ebx, 24h
	mov eax,ebx
	shr eax,7
	
	cmp eax,0
	jz CF_0
	stc
	jmp koniec

CF_0:
	clc
koniec:
	pop ebx
	ret
_zad8 ENDP

END