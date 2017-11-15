.686
.model flat
	extern _ExitProcess@4 : PROC
	extern __write : PROC
	public _main
.data
	wynik_srednie dw 100, 64, 50 dup(0)
	wynik_tekst db 50 dup(' '),10,0
.code

wyswietl_tablica PROC
	pusha
	mov ebx , 10 ;dzielnik
	mov ecx, 49 ;iloœæ miejsca na znaki
	xor edx, edx ;reszta z dzielenia

	mov ebp , offset wynik_tekst;adres o jeden bajt dalej od ostatniej œredniej 
ptl: ;wyznaczenie adresu ostatniej œredniej
	sub ebp, 2
	mov dx, word PTR [ebp]
	cmp dx, 0
	jz ptl

ptl2:
	mov ax , [ebp]
	movzx eax, ax 

konwersja:
	xor edx, edx ;reszta z dzielenia
	div ebx ;dzielenie edx:eax przez ebx
	add dl , '0'
	mov wynik_tekst[ecx] , dl
	dec ecx

	cmp eax , 0
	jnz konwersja

	mov wynik_tekst[ecx], 20h
	dec ecx
	sub ebp, 2
	cmp ebp , offset wynik_srednie
	jae ptl2

	push 52 ;iloœæ znaków wynikowego tekstu
	push offset wynik_tekst
	push 1
	call __write

	add esp, 12
	popa
	ret
wyswietl_tablica ENDP

_main:
	call wyswietl_tablica
	push 0
	call _ExitProcess@4

END
