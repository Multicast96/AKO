.686
.model flat

public _ciag

.data
trzy dq 3.0
piec dq 5.0
szesc dq 6.0

.code
_ciag PROC
	push ebp
	mov ebp,esp
	push ebx

	mov ebx,[ebp+8] ;adres x
	mov ebx,[ebx] ;x
	
	finit
	cmp ebx,1
	jz return_piec

	cmp ebx,2
	jz return_szesc

	;x>2
	sub ebx,1
	push ebx
	push esp
	call _ciag
	add esp,8

	fld qword PTR trzy
	fsub st(0), st(1)
	fstp st(1)

	add ebx,1
	push ebx
	fild dword PTR [esp]
	add esp,4
	fdiv
	jmp koniec

return_piec:
	fld qword PTR piec
	jmp koniec

return_szesc:
	fld qword PTR szesc

koniec:
	pop ebx
	pop ebp
	ret
_ciag ENDP

END