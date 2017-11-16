.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC
public _main 

.data

znaki db 11 dup(?) ;tablica z przetworzonymi znakami
obszar db 11 dup(0) ;znaki wczytane z klawiatury

.code

wyswietl_EAX PROC
	pusha
	mov ebx , 10 ;dzielnik

	mov ecx, 1 ;
	mov znaki[0] , 0Ah

konwersja:

	xor edx, edx ;reszta z dzielenia
	div ebx ;dzielenie edx:eax przez ebx
	add dl , '0'
	mov znaki[ecx] , dl
	inc ecx;

	cmp eax , 0
	jnz konwersja

	push ecx ;zapamietanie iloœci znaków

	xor eax,eax ;indeks pierwszego znaku
	dec ecx ;indeks ostatniego znaku

obrot: ;znaki ASCII cyfr w pamiêci s¹ w odwrotnej kolejnoœci tutaj bêdzie obracanie
	mov bl, znaki[eax]
	xchg bl , znaki[ecx]
	mov znaki[eax], bl

	inc eax
	dec ecx

	cmp eax , ecx
	jc obrot


	push offset znaki
	push 1
	call __write

	add esp, 12
	popa
	ret
wyswietl_EAX ENDP

wczytaj_do_EAX_hex PROC
	push 11 ;maksymalna liczba znaków
	push offset obszar ;adres obszaru pamiêci do zapisu
	push 0 ;numer urz¹dzenia 0 - klawiatura
	call __read
	add esp, 12

	xor ecx, ecx ;przetwarzany znak
	mov ebx, eax ;iloœæ wczytanych znaków
	dec ebx
	xor eax, eax ;wynik
	xor esi , esi ;licznik znaków

nastepny_znak:
	mov cl , obszar[esi]
	inc esi

	cmp cl , 'a'
	jb duze_litery
	cmp cl , 'z'
	ja duze_litery

	sub cl , 'a' - 10
	jmp zapis

duze_litery:
	cmp cl , 'A'
	jb cyfry
	cmp cl , 'F'
	ja cyfry

	;znak of A do F
	sub cl , 'A' - 10
	jmp zapis

cyfry:
	cmp cl, '0'
	jb koniec
	cmp cl, '9'
	ja koniec

	;cyfra of 0 do 9
	sub cl , '0'
	jmp zapis

zapis:
	shl eax, 4
	or al, cl
	cmp ebx, esi
	jnz nastepny_znak

koniec:

	ret
wczytaj_do_EAX_hex ENDP

_main:

ptl:
	call wczytaj_do_EAX_hex
	call wyswietl_EAX

	push 0
	call _ExitProcess@4

END