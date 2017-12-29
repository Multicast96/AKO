.686
.model flat

public _zad9

.code

_zad9 PROC
	;mov edx, 0C0h ;1,5
	mov edx, 0FFFFFFC0h ;-1,5

	sar edx,7
	jnc zaokraglenie_w_dol

	bt edx,24
	jc odejmij
	inc edx ;edx >= 0 -> edx++
	jmp zaokraglenie_w_dol
odejmij:
	dec edx
zaokraglenie_w_dol:
	shl edx,7
	ret
_zad9 ENDP

END