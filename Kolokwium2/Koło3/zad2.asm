.686
.model flat

public _funkcja

.code

_funkcja PROC
	push ebp
	mov ebp,esp
	push ebx
	push esi

	mov esi,[ebp+8];adres tablicy
	mov ecx,[ebp+12];ilosc elementow

	mov ebx,1 ;licznik petli
	inc ecx ;bo ebx 1 a nie 0
	
	finit
	fldz
licz_sume:
	fldl2e ;lg2e
	push ebx
	fild dword PTR [esp] ;i
	fmul ;st(0) = i*lg2e
	fld st(0)
	frndint ;zaokraglene st(0)
	fsub st(1), st(0) ;obliczenie czesci ulamkowej
	fxch ;zamiana miejscami st(1) i st(0)
	; po zamianie: ST(0) - czêœæ u³amkowa, ST(1) - czêœæ ca³kowita 

	f2xm1 ;2^x-1 st(0) = 2^(i*lg2e) - 1
	fld1
	fadd ;st(0) = 2^(i*lg2e)

	; mno¿enie przez 2^(czêœæ ca³kowita)
	fscale
	fxch
	fstp st(0)
	fld qword PTR [esi+ebx*8-8] ;ladujemy x[i]
	fild dword PTR [esp] ;ladujemy i
	add esp,4 ;usuniecie i ze stosu
	fsub ;st(0) = x[i] - i , st(1) = e^i
	fdiv
	fadd
	
	inc ebx
	cmp ebx,ecx
	jnz licz_sume 

koniec:
	pop esi
	pop ebx
	pop ebp
	ret
_funkcja ENDP

END