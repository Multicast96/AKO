.686
.model flat

;extern _GetSystemInfo@36 : PROC
;extren _MessageBoxA@16 : PROC
public _liczba_procesorow

.code

_liczba_procesorow PROC
	mov eax,1
	ret
_liczba_procesorow ENDP

END