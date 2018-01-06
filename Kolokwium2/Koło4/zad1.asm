.686
.model flat

public _zamien_na_binarny

.data

dekoder dw '0','1','2','3','4','5','6','7','8','9',218Ah,21Bh
.code

_zamien_na_binarny PROC
	push ebp
	mov ebp,esp
	push esi
	push edi
	push ebx

	mov esi,[ebp+8];adres ciagu znakow
	mov edi,esi ;rejestr w ktorym bedzie adres konca ciagu znakow

	sub edi,2
	xor eax,eax
	xor edx,edx

szukaj_ostatni:
	add edi,2
	mov ax, word PTR [edi]
	cmp ax,0
	jnz szukaj_ostatni

	mov ebx,1 ;mnoznik pozycji liczby 12^0, 12^1, 12^2 ....
	sub edi,2

obliczaj:
	mov eax,-1
szukaj_dekoder: ;szukanie wystapienia znaku w dekoderze
	add eax,1
	mov cx, dekoder[eax*2]
	cmp cx, word PTR [edi]
	jnz szukaj_dekoder

	finit
	push eax
	fild dword PTR [esp]
	push ebx 
	fild dword PTR [esp]
	fmul
	fistp dword PTR [esp]
	mov eax, [esp]

	add edx,eax ;edx - liczba po konwersji
	add esp,8
	lea ebx,[ebx*2+ebx] ;ebx *3
	lea ebx,[ebx*4] ;(ebx *3) *4 = ebx*12
	sub edi,2
	cmp esi,edi
	jbe obliczaj

koniec:
	mov eax,edx

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_zamien_na_binarny ENDP

END
