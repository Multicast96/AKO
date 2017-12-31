.686
.model flat

extern _malloc : PROC

public _ASCII_na_UTF16 

.code
_ASCII_na_UTF16 PROC
	push ebp
	mov ebp,esp
	push esi
	push edi
	push ebx

	mov esi,[ebp+8] ;adres tablicy znakow
	mov ebx,[ebp+12] ;n - liczba elementow
	
	;n*4 - ilosc bajtow tablicy znakow
	;n*4*2 w nowej tablicy znakow kazdy znak ma dwa bajty
	lea ecx,[ebx*8]

	push ecx
	call _malloc ;rezerwacja bloku pamieci na dane
	add esp,4
	
	mov edi,eax ;adres nowego bloku pamieci
	
	xor ecx,ecx ;licznik petli znakow
kopiuj:
	cmp ecx,ebx
	jz koniec
	mov dl,[esi+ecx]
	mov [edi+ecx*2],dl
	mov [edi+ecx*2+1],byte PTR 0
	inc ecx
	jmp kopiuj

koniec: 
	mov eax,edi

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_ASCII_na_UTF16 ENDP

END
