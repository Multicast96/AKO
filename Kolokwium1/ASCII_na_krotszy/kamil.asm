.686
.model flat
	extern _ExitProcess@4 : PROC
	extern __write : PROC
	public _main

.data
	tekst db 'ako da sie lubic!',0
	wynik db 20 dup(?)
.code

zapisz5bitow PROC
	push ebx
	push eax

	;ESI - adres tekstu Ÿród³owego - tekst jest zakoñczony zerem
	;EDI - adres tekstu docelowego - musi byæ zakoñczony 5 bitami zerowymi
	;cl o którego bitu w bajcie rozpocz¹æ zapis

	xor ebx, ebx
	and al, 1Fh ;wyczyszczenie wszystkiego oprócz 5 bitów do zapisu
	mov bx, [edi]
	ror ebx, cl
	and bl, 0E0h ;wyczyszczenie miejsca w którym wpisane bêdzie 5 bitów z AL
	or bl, al
	rol ebx, cl
	mov word PTR [edi], bx

	pop eax
	pop ebx
	ret
zapisz5bitow ENDP
_main:
	mov esi, offset tekst
	mov edi, offset wynik

	xor ecx, ecx
	xor eax, eax

ptl:
	mov al, [esi]
	cmp al, 20h
	jnz dalej
	mov al , 27
dalej:
	inc esi

	cmp al, 0
	jz koniec

	sub al, 60h
	call zapisz5bitow

	add cl, 5
	cmp cl, 7

	jna ptl
	sub cl, 8
	inc edi
	jmp ptl

koniec:
	call zapisz5bitow

	push 20;liczba znaków do wyœwietlenia
	push offset wynik
	push 1 ;uchwyt do ekranu
	call __write

	add esp, 12
	push 0
	call _ExitProcess@4
END