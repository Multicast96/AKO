.686
.model flat

public _dziel16

.code
_dziel16 PROC
	push ebp
	mov ebp,esp
	push ebx

	mov ebx, [ebp+8]
	mov eax, ebx
	and eax,7FFFFFh;zera na wszystko oprocz mantysy

	shr eax,4
	shl eax,4

	shr ebx,23
	sub bl,4
	shl ebx,23
	or eax,ebx

	push eax
	fld dword PTR [esp]
	add esp,4

	pop ebx
	pop ebp
	ret
_dziel16 ENDP

END