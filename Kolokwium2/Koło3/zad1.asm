.686
.model flat

public _NWW

.code

_NWW PROC
	push ebp
	mov ebp,esp

	mov eax, [ebp+12]
	push eax ;b
	mov eax, [ebp+8]
	push eax ;a

	call _NWD
	add esp,8

	push eax ;NWD(a,b)

	finit
	fild dword PTR [ebp+8]
	fild dword PTR [ebp+12]
	fmul
	fild dword PTR [esp];st(0) = NWD(a,b) st(1) = a*b
	fdiv

	fistp qword PTR [ebp+8] ;zapisanie wyniku funkcji czyli NWW
	mov eax,[ebp+8]
	mov edx,[ebp+12]
	
	add esp,4 ;usuniecie NWD(a,b) ze stosu

	pop ebp
	ret
_NWW ENDP

_NWD PROC
	push ebp
	mov ebp,esp

	mov eax,[ebp+8];a
	mov edx,[ebp+12];b

	cmp eax,edx
	jz koniec
	ja a_wieksze_b

	;a < b
	sub edx,eax
	push edx
	push eax
	jmp call_NWD

a_wieksze_b:
	push edx
	sub eax,edx
	push eax

call_NWD:
	call _NWD
	add esp,8

koniec:
	pop ebp
	ret
_NWD ENDP

END