.686
.model flat

public _miesz2float

.code
_miesz2float PROC
	push ebp
	mov ebp,esp
	push ebx

	mov eax,[ebp+8]
	
	xor ecx,ecx ;pozycja najstarszej jedynki
	mov ecx,32
szukaj:
	dec ecx
	bt eax,ecx
	jnc szukaj
	;musimy teraz przesunac liczbe w prawo/lewo zeby najstarsza jedynka znajdowala sie na pozycji 23
	;czyli miejscu niejawnej jedynki mantysy
	push ecx
	sub ecx,23

	cmp ecx,0
	jl przesuwamy_w_lewo
	;przesuwamy w prawo
	shr eax,cl
	jmp obliczamy_wykladnik

przesuwamy_w_lewo:
	neg ecx
	shl eax,cl

obliczamy_wykladnik:
	pop ecx
	sub ecx,8 ;odleg³oœæ pierwszej jedynki od pozycji 2^0 w formacie mieszanym(pozycja 8) czyli nasz wyk³adnik
	add ecx,127
	and eax, 7FFFFFh ;usuniecie niejawnej jedynki
	shl ecx, 23
	or eax,ecx

	push eax
	fld dword PTR [esp]
	add esp,4

	pop ebx
	pop ebp
	ret
_miesz2float ENDP

END