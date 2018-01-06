.686
.model flat

public _szereg
.data

pol dd 0.5
.code
_szereg PROC
	push ebp
	mov ebp,esp
	push ebx

	finit
	mov ebx, [ebp+8] ;n

	cmp ebx,1
	je return_pol

	;n>1
	sub ebx,1;n-1
	push ebx
	call _szereg
	;na wiezcholku stosu koprocesora szereg(n-1)
	add esp,4

	fld1
	add ebx,2 ;(n-1)+2 = n+1
	push ebx
	fild dword PTR [esp]
	add esp,4
	fdiv ;1/(n+1)
	fadd
	jmp koniec

return_pol:
	fld dword PTR pol
koniec:
	pop ebx
	pop ebp
	ret
_szereg ENDP

END