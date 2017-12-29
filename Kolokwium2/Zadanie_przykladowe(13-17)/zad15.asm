.686
.model flat

public _pole_kola

.code
_pole_kola PROC
	push ebp
	mov ebp,esp

	mov eax, [ebp+8]

	fld dword PTR [eax] ;st(0)=r
	fld st(0) ;st(0) = r st(1) = 4
	
	fmulp ;st(0) = r^2
	fldpi ;st(0) = pi st(1) = r^2
	fmulp ;st(0) = pole

	pop ebp
	ret
_pole_kola ENDP

END
