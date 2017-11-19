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

	;ESI - adres tekstu �r�d�owego - tekst jest zako�czony zerem
	;EDI - adres tekstu docelowego - musi by� zako�czony 5 bitami zerowymi
	;cl o kt�rego bitu w bajcie rozpocz�� zapis

	xor ebx, ebx
	and al, 1Fh ;wyczyszczenie wszystkiego opr�cz 5 bit�w do zapisu
	mov bx, [edi]
	ror ebx, cl
	and bl, 0E0h ;wyczyszczenie miejsca w kt�rym wpisane b�dzie 5 bit�w z AL
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

	push 20;liczba znak�w do wy�wietlenia
	push offset wynik
	push 1 ;uchwyt do ekranu
	call __write

	add esp, 12
	push 0
	call _ExitProcess@4
END