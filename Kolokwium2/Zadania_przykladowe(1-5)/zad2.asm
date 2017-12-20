.686
.model flat
public _kopia_tablicy
extern _malloc : PROC

.data
.code
	_kopia_tablicy PROC
		push ebp
		mov ebp, esp
		push esi
		push ebx
		push edi

		mov esi, [ebp+8] ;adres tablicy
		mov ebx, [ebp+12] ;rozmiar tablicy
		lea ecx, [ebx*4] ;rozmiar tablicy w bajtach

		push ecx ;1 parametr malloc rozmiar rezerwowanego obszaru w bajtach
		call _malloc ;w eax adres zarezerwowanego obszaru
		cmp eax, 0
		jz blad_alokacji_pamieci
		mov edi,eax ;adres nowej tablicy
		add esp, 4 ;zdjêcie ze stosu parametru funkcji malloc

		xor ecx,ecx ;iterator tablicy

kolejny_element:
		mov eax, [esi+ecx*4] ;pobranie kolejnego elementu tablicy
		bt ax,0 ;skopiowanie najm³odszego bitu pobranej liczby do CF
		jnc liczba_parzysta
		xor eax,eax ;nieparzysta
liczba_parzysta:
		mov [edi+ecx*4], eax
		inc ecx
		cmp ecx,ebx
		jnz kolejny_element

		mov eax,edi ;w eax adres nowej tablicy, zwaracmy do maina

blad_alokacji_pamieci:
		pop edi
		pop ebx
		pop esi
		pop ebp
		ret
	_kopia_tablicy ENDP
END