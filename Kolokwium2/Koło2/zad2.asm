.686
.model flat

extern _MessageBoxW@16 : PROC
extern _GetSystemTime@4 : PROC
public _ShowDate

.code

_ShowDate PROC
	push edi
	push esi
	push ebx

	sub esp, 16 ;miejsce na strukture do której bêdzie pisaæ GetSystemTime
	mov edi,esp ;adres struktury

	push edi
	call _GetSystemTime@4

	mov esi,edi
	sub esp,22 ;rezerwacja obszaru na tekst

	sub esi,2
	mov [esi], word PTR 0 ;zero konczace tekst
	mov ebx,esp ;adres konca obszaru na tekst

	mov ecx,10;dzielnik

	xor eax,eax

dzien:
	mov ax,[edi+6]
	mov ebx, miesiac
	jmp dziel

miesiac:
	mov ax,[edi+2]
	mov ebx,rok
	jmp dziel

rok:
	mov ax,[edi]
	mov ebx,koniec

dziel:
	xor edx,edx
	div cx
	add dx,'0' ;zamiana liczby na znak ASCII
	sub esi,2
	mov [esi],dx
	cmp eax,0
	jnz dziel

	sub esi,2
	mov [esi], byte PTR '.'
	mov [esi+1], byte PTR 0
	jmp ebx

koniec:
	mov ebx,esp ;adres poczatku tekstu
	push 0
	push ebx
	push ebx
	push 0

	call _MessageBoxW@16
	add esp,38

	pop ebx
	pop esi
	pop edi
	ret
_ShowDate ENDP

END
