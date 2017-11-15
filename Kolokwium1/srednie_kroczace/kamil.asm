.686
.model flat

	extern _ExitProcess@4 : PROC
	extern __write : PROC
	public _main

.data
	dane dw 7, 21, 2, 10, 11, 1, 2, 2, 25, 7
	wynik_srednie dw 50 dup(0)
	wynik_tekst db 50 dup(' '),10,0
.code

;-------WYSWIETLANIE TABLICY LICZB----------;
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
;-------WYSWIETLANIE TABLICY LICZB END----------;


_main:
	mov ecx, 4 ;n
	mov ebx, 2 ;k
	mov edx, 10
	mov esi, offset dane
	mov edi, offset wynik_srednie

;-------ZAD 1----------;
	mov ebp, esi
	lea ebp, [ebp + edx + 2] ;adres ostatniego elementu ci¹gu

licz_srednie:
	xor eax,eax ;suma n-kolejnych liczb
	push ecx ;zachowanie wartoœci n na stosie
ptl:
	lea edx, [esi + ecx*2 - 2];adres nastêpnego wyrazu ci¹gu do zsumowania
	add ax , word PTR [edx]
	loop ptl

	pop ecx
	push edx ;edx zostanie nadpisany reszta z dzielenia - ochrona
	xor edx, edx
	div ecx ;obliczanie œredniej z n liczb
	pop edx

	mov word PTR [edi], ax
	add edi, 2
	lea esi, [esi + ebx*2] ;przesuwamy esi(wyraz pocz¹tkowy œredniej) o k
	cmp edx, ebp ;sprawszamy czy nie policzyliœmy ostatniej œredniej
	jnz licz_srednie
;-------ZAD 1 END----------;


	call wyswietl_tablica

	push 0
	call _ExitProcess@4
END