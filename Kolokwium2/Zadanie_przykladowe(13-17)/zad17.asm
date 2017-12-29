.686
.model flat

public _avg_wd

.code
_avg_wd PROC
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi

	mov ebx, [ebp+8] ;rozmiar n
	mov esi, [ebp+12] ;adres tablicy zmiennych
	mov edi, [ebp+16] ;adres tablicy wag

	fldz ;suma iloczonow st(1)
	fldz ;suma wag st(0)
	xor ecx,ecx ;licznik petli
dalej:
	cmp ecx,ebx
	jz koniec

	fld dword PTR [esi+ecx*4] ;x liczba do sredniej
	fld dword PTR [edi+ecx*4] ;y-waga 
	;st(0) = y, st(1) = x, st(2) = suma_wag, st(3) = suma_iloczynow

	fadd st(2),st(0)
	;st(0) = y, st(1) = x, st(2) = suma_wag+y, st(3) = suma_iloczynow
	fmul
	;st(0) = y*x, st(1) = suma_wag+y, st(2) = suma_iloczynow
	faddp st(2) , st(0)
	;st(0) = suma_wag+y, st(1) = suma_iloczynow +y*x
	inc ecx
	jmp dalej


koniec:
	fdiv
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_avg_wd ENDP

END
