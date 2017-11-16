.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC
public _main 

.data

znaki db 11 dup(?) ;tablica z przetworzonymi znakami
obszar db 11 dup(?) ;znaki wczytane z klawiatury

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

wczytaj_do_EAX PROC
	push ecx
	push ebx
	push edx

	push 11 ;maksymalna liczba znaków
	push offset obszar ;adres obszaru pamiêci do zapisu
	push 0 ;numer urz¹dzenia 0 - klawiatura
	call __read
	add esp, 12
	
	xor eax, eax ;przetworzna liczba
	xor esi,esi ;licznik znakow
	mov ebx, 10 ;mno¿nik

ptl:

	xor ecx, ecx ;przetwarzany znak
	mov cl, obszar[esi]
	inc esi
	cmp cl , 0Ah
	jz gotowe

	sub cl, '0'
	mul ebx ;eax = eax * ebx
	add eax, ecx

	jmp ptl

gotowe:
	pop edx
	pop ebx
	pop ecx
	ret
wczytaj_do_EAX ENDP

_main:

ptl:
	call wczytaj_do_EAX
	mul eax
	call wyswietl_EAX

	push 0
	call _ExitProcess@4

END