.686
.model flat

public _find

.code

_find PROC
	push ebp
	mov ebp,esp
	push esi
	push edi
	push ebx

	mov esi,[ebp+8];adres tablicy
	lea edi,[ebp+12];adres szukanego x
	mov edx,[ebp+20];min
	mov ebx,[ebp+24];max

	cmp edx,ebx ;czy min>max ?
	jg return_minus_jeden

	mov ecx,edx ;mid = min
	add ecx,ebx ;mid = min+max
	shr ecx,1 ;mid = (min+max)/2

	finit
	fld qword PTR [esi+ecx*8];³adujemy tab[mid]
	fld qword PTR [edi] ;³adujemy x
	fcomi st(0), st(1) ;porównanie x ? tab[mid]

	je return_mid
	jb return_else
	;x > tab[mid]
	push ebx ;max
	add ecx,1
	push ecx ;mid+1
	jmp call_find

return_else:
	;x < tab[mid]
	sub ecx,1
	push ecx ;mid-1
	push edx ;min

call_find:
	sub esp,8
	fstp qword PTR [esp] ;x
	fstp st(0) ;usuniecie parametrów ze stosu koprocesora
	fstp st(0) ;usuniecie parametrów ze stosu koprocesora
	push esi ;adres tablicy

	call _find
	add esp,20
	jmp koniec

return_mid:
	mov eax,ecx
	jmp koniec

return_minus_jeden:
	mov eax,-1

koniec:
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_find ENDP

END