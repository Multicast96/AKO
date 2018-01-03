.686
.model flat

public _half_to_float

.code
_half_to_float PROC
	push ebp
	mov ebp,esp

	xor eax,eax
	mov ax, word PTR [ebp+8]

	mov edx,eax
	shl eax,13 ;mantysa na swoim miejscu
	
	shl edx,1 ;edx = [15 zer|znak|5 bitow|10 bitow mantysy | 1 zero]
	shr dx,11 ;edx = [15 zer|znak|11 zer|5 bitow]
	add dl,127-15;edx = [15 zer|znak|8 zer|8 bitow wykladnika]
	shl dx,8;edx = [15 zer|znak|8 bitow wykladnika|8 zer]
	shl edx,15;edx = [znak|8 bitow wykladnika|23 zera]

	and eax,7FFFFFh ;wyzerowanie wszystkiego oprócz mantysy 23 bity
	or eax,edx ;eax = [znak|8 bitow wykladnika|10 bitow mantysy|13 zer]
	
	push eax
	fld dword PTR [esp]
	add esp,4

	pop ebp
	ret
_half_to_float ENDP
END