.686
.model flat

public _iloraz
.data
x dd 40800000h
y dd 0C0000000h
.code
_iloraz PROC
	fld dword PTR x
	fld dword PTR y
	fdivp
	ret
_iloraz ENDP

END