.686
.model flat

public _liczba_przeciwna

 .code
 _liczba_przeciwna PROC
	push ebp
	mov ebp, esp

	mov eax, [esp + 8] ;w eax adres liczby
	neg dword ptr [eax]

	pop ebp
	ret
 _liczba_przeciwna ENDP

 END