.686
.model flat

public _wyswietl64
	extern __write : PROC
.data

liczba db 24 dup(' '),10,0
dzielnik dd 10
.code
	_wyswietl64 PROC
		;prolog
		push ebp
		mov ebp, esp
		
		push edi
		push esi
		push ebx

		mov edi, esp ;pocz¹tek obszaru zarezerwowanego
		sub esp, 32 ;rezerwacja miejsca na dane programu

		mov [edi-1] , byte PTR 0 ;koniec obszaru zarezerwowanego | 0 koñcz¹ce tekst
		mov [edi-2] , byte PTR 10 ;enter
		lea ecx, [edi-3]; ostatni bajt obszaru na kody ASCII liczby do wyœwietlenia
		mov [edi - 32] , dword PTR 10 ;dzielnik


ptl:
		mov eax, [ebp + 12] ;starsza czêœæ liczby 64 bitowej
		mov ebx, [ebp + 8] ;m³odsza czêœæ libczy 64 bitowej
		
		cmp ebx, 0 ;je¿eli m³odsza czêœæ jest równa 0 to koniec dzielenia
		jz koniec
		xor edx, edx

		div dword PTR [edi-32] ;dzielnik
		mov [ebp + 12], eax

		mov eax, [ebp + 8]
		div dword PTR [edi-32] ;dzielnik
		mov [ebp + 8] , eax

		add dl, '0'
		mov [ecx], dl
		dec ecx
		jmp ptl

koniec:
		inc ecx
		sub edi, ecx ;liczba znaków tekstu wynikowego
		push edi
		push ecx
		push 1
		call __write
		add esp, 12

		add esp, 32
		pop ebx
		pop esi
		pop edi

		pop ebp

		ret
	_wyswietl64 ENDP
END