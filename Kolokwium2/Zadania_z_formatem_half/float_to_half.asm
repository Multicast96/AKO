.686
.model flat

public _float_to_half

.code

_float_to_half PROC
	push ebp
	mov ebp,esp

	mov eax, [ebp+8] ;float a
	mov edx,eax
	shr eax,13
	pushf
	and eax, 3FFh ;zerowanie wszystkiego oprocz mantysy
	popf
	adc eax,0 ;zaokr¹glenie

	shr edx,15 ;edx=[15zer|znak|8 bitow wykladnika|8 bitow mantysy]
	shr dx,8
	sub dl,127-15;edx=[15zer|znak|11 zer|5 bitow wykladnika]

	;zaokr¹glenie
	bt eax,10
	jnc dalej
	shr eax,1
	add dl,1

dalej:
	shl dx,11;edx=[15zer|znak|5 bitow wykladnika|11 zer]
	shr edx,1;edx=[16zer|znak|5 bitow wykladnika|10 zer]
	or eax,edx;edx=[16zer|znak|5 bitow wykladnika|10 bitow mantysy]

	pop ebp
	ret
_float_to_half ENDP

END