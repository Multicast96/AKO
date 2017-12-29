.686
.model flat

public _float_to_double

.code
_float_to_double PROC
	push ebp
	mov ebp,esp
	push esi
	push edi
	push ebx

	lea esi, [ebp+8] ;adres liczby do przeksztalcenia
	sub esp, 8 ;rezerwacja miejca na liczbe wynikowa
	mov edi,esp ;adres wynikowej liczby

;do przeksztalcenia [1bit|8bitow|23bity]
;wynik bedzie postaci [1bit|11bitow|52bity] = [1bit|11bitow w tym (8bitow + (1023-127))|23bity + 29 zer] = [1bit|11bitow|20bitow][3bity+29bitow(zera)]
	mov eax,[esi] ;eax = [1bit|8bitow|23bity] = [b|bbbbbbbb|bbbbbbbbbbbbbbbbbbbbbbb]
	mov ebx,eax
	shl ebx,29 ;[3bity(b)|29bitow(zera)]

	mov [edi],ebx
	shr eax,3 ;[3zera|1bit|8bitow|20bitow]
	mov ebx,eax

	shr ebx, 20
	shl ebx,8 ;[15zer|1bit|8bitow|8zer]
	shr bx, 8 ;[15zer|1bit|8zer|8bitow]
	add bx, 1023-127
	shl bx,5 ;[15zer|1bit|11bitow|5zer]
	shl ebx, 15 ;[1bit|11bitow|20zer]
	
	and eax, 0FFFFFh
	or eax, ebx ;[1bit|11bitow|bitow]

	mov [edi+4],eax

	fld qword PTR [edi]

	add esp,8

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_float_to_double ENDP

END