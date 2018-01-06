.686
.model flat

extern _malloc : PROC
public _XYZ2R

.code

_XYZ2R PROC
	push ebp
	mov ebp,esp
	push esi
	push edi
	push ebx

	mov esi,[ebp+8];tablica
	mov ebx,[ebp+12];n

	lea ebx,[ebx*4];rozmiar tablicy wynikowej w bajtach
	push ebx

	call _malloc
	add esp,4

	cmp eax,0 ;sprawdzenie czy malloc przydzielil pamiec
	jz koniec

	mov edi,eax ;adres obszaru na wyniki
	finit
	mov ebx,[ebp+12]
	xor ecx,ecx ;licznik petli

	sub esp,4
obliczanie:
	lea edx , [ecx*2+ecx];ecx*3
	mov [esp], dword PTR 40440831h
	fld dword PTR [esp]
	fld dword PTR [esi+edx*4]
	fmul

	mov [esp] , dword PTR 3FB24DD3h
	fld dword PTR [esp]
	fld dword PTR [esi+edx*4+4]
	fmul
	fsub

	mov [esp] , dword PTR 3EF3B646h
	fld dword PTR [esp]
	fld dword PTR [esi+edx*4+8]
	fmul
	fsub

	fstp dword PTR [edi+ecx*4]
	inc ecx
	cmp ecx,ebx
	jnz obliczanie

	add esp,4

	mov eax,edi
koniec:

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_XYZ2R ENDP

END