.686
.model flat

public _odejmij_jeden

 .code
 _odejmij_jeden PROC
	push ebp
	mov ebp, esp

	mov eax, [esp + 8] ;w eax adres adresu liczby :)
	mov eax, [eax] ;w eax adres liczby
	dec dword ptr [eax]

	pop ebp
	ret
 _odejmij_jeden ENDP

 END