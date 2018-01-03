.686
.model flat

extern _GetSystemInfo@4 : PROC
public _liczba_procesorow

.code

_liczba_procesorow PROC
	sub esp,36
	push esp
	call _GetSystemInfo@4

	mov eax, [esp+20]
	add esp,36
	nop
	ret
_liczba_procesorow ENDP

END