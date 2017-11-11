.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC
public _main 

.data

obszar db 11 dup(?) ;tablica z przetworzonymi znakami
dekoder db '0123456789ABCDEF'
flaga db 0 ;czy zera nieznacz¹ce ? 0 - tak | 1 - nie

.code

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

wyswietl_EAX_hex PROC
	pusha
	
	xor ebx,ebx
	mov ecx , 8 ;liczba obiegów pêtli konwersji
	xor esi, esi ;licznik znaków


	sub esp, 10 ;rezerwacja pamiêci na stosie na max 8 znaków HEX + ENTER
	mov edx , esp
	mov byte PTR [edx][9] , 0Ah ;na ostatnim miejscu w zarezerwowanej przestrzeni ENTER (0Ah)

konwersja:
	rol eax, 4
	mov bl, al
	and eax, 0FFFFFFF0h

	and bl, 0Fh
	mov bl, dekoder[ebx]

	;zamiana 0 nieznacz¹cych na spacje
	cmp flaga, 0
	jnz nie_spacja
	cmp bx , '0'
	setnz flaga

	cmp flaga,0
	jnz nie_spacja
	mov bx, ' '
nie_spacja:
	
	mov [edx][esi] , bl ;zapis w zarezerwowanym obszarze stosu
	inc esi

	loop konwersja

	push 10
	push edx
	push 1
	call __write
	add esp, 22

	popa
	ret
wyswietl_EAX_hex ENDP

_main:

ptl:
	call wczytaj_do_EAX
	call wyswietl_EAX_hex

	push 0
	call _ExitProcess@4

END