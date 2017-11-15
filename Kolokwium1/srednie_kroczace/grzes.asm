.686
.model flat
	extern _ExitProcess@4 : PROC
	extern _MessageBoxA@16 : PROC
	public _main
.data	      
	dane dw 7, 21, 2, 10, 11, 1, 2, 2, 25, 7 
	pqr dw 65, 129, 257
.code
PROGRAM_1 PROC
	pusha
	;====DANE====
	mov ebx, 2	;wartosc k - offset podciagow
	mov ecx, 4	;wartosc n - dlugosc podsciagow
	mov edx, 10	;wartosc m - ilosc danych wejsciowych
	mov esi, OFFSET dane	;adres pierwszej danej
	mov ebp, 0	;ebp to jest całkowity offset 
	;====____====

	sub edx, ecx	;;;; upraszcza sprawdzanie, czy nie wychodzi poza zakres danych
	add edx, edx
start:
	cmp ebp, edx	;sprawdza, czy nie wychodzi poza zakres danych
	ja koniec

	xor eax, eax	;;;; nie zerowałem eax
	push ecx
ptl:
	add ax, word PTR [esi][2*ecx-2]
	loop ptl
	add esi, ebx
	add esi, ebx
	pop ecx
	
	push edx
	xor edx, edx	;;;; jeżeli coś zostanie po dzieleniu w EDX, DX czy tam AH, to bedzie INTIGER OVERFLOW 
	div ecx	;wynik w EAX, reszta w EDX
	pop edx

	;ŚREDNIA JEST TERAZ W EAX
	add ebp, ebx
	add ebp, ebx
	jmp start
koniec:
	popa
	ret
PROGRAM_1 ENDP

PROGRAM_2 PROC
	push ebx
	push edi
	push eax

	mov ebx, OFFSET pqr
	mov edi , 1
	mov eax, [edi][ebx]
	;eax = 01008100h
	pop eax
	pop edi
	pop ebx

	ret
PROGRAM_2 ENDP

PROGRAM_3 PROC
	mov eax, 12
	mov ebx, 32
	mov cl, 0

	not eax
start:
	shr eax, 1
	adc cl, 0
	dec ebx
	cmp ebx, 0
	jnz start

	ret
PROGRAM_3 ENDP

_main:
	call PROGRAM_3 

	push 0
	call _ExitProcess@4 
END
