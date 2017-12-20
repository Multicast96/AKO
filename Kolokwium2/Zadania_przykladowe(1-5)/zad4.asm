.686
.model flat
public _szukaj_elem_min

.code
	_szukaj_elem_min PROC
		push ebp
		mov ebp,esp
		push esi
		push ebx
		push ebp
		push edi

		mov esi , [ebp+8] ;adres tablicy liczb
		mov ecx, [ebp+12] ;rozmiar tablicy [elem]

		xor edx, edx ;adres najmniejszego elementu
		xor ebp, ebp ;najmniejszy element
		xor ebx,ebx ;licznik tablicy elementow
		
		mov ebp, [esi+ebx*4]
		lea edx, [esi+ebx*4]

nastepny_element:
		inc ebx
		cmp ebx,ecx
		jz koniec

		mov edi, [esi+ebx*4]
		cmp edi, ebp
		jge nastepny_element
		mov ebp, [esi+ebx*4]
		lea edx, [esi+ebx*4]
		jmp nastepny_element

koniec:
		mov eax, edx
		pop edi
		pop ebp
		pop ebx
		pop esi
		pop ebp
		ret
	_szukaj_elem_min ENDP
END