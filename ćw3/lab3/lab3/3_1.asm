.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
public _main 

.data

znaki db 11 dup(?) ;tablica z przetworzonymi znakami

.code

wyswietl_EAX PROC
	pusha
	mov ebx , 10 ;dzielnik

	xor ecx, ecx ;liczba znak�w

konwersja:

	xor edx, edx ;reszta z dzielenia
	div ebx ;dzielenie edx:eax przez ebx
	add dl , '0'
	mov znaki[ecx] , dl
	inc ecx;

	cmp eax , 0
	jnz konwersja

	mov znaki[ecx] , 0Ah
	inc ecx
	push ecx ;zapamietanie ilo�ci znak�w

	xor eax,eax ;indeks pierwszego znaku
	sub ecx, 2 ;indeks ostatniego znaku
obrot: ;znaki ASCII cyfr w pami�ci s� w odwrotnej kolejno�ci tutaj b�dzie obracanie
	mov bl, znaki[eax]
	xchg bl , znaki[ecx]
	mov znaki[eax], bl

	inc eax
	dec ecx

	cmp ecx, eax
	jnc obrot


	push offset znaki
	push 1
	call __write

	add esp, 12
	popa
	ret
wyswietl_EAX ENDP

_main:

ptl:
	mov eax ,  0 ;liczba do wy�wietlenia
	mov ebx ,  1 ;r�nica
	mov ecx ,  0 ;numer liczby w ci�gu

	add eax , ebx
	inc ebx
	inc ecx
	call wyswietl_EAX
	
	cmp ecx ,50
	jnz ptl

	push 0
	call _ExitProcess@4

END