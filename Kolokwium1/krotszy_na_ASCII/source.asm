.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
public _main

.data	      
 tekst db 01100001b, 10111101b, 10101101b, 11001010b , 10100100b, 10111011b, 10101100b , 01001001b, 01100101b, 00000000b
 wynik db 20 dup (?)

.code

;-----------ZAD 2------------;
pobierz5bitow PROC
	push ebp
	push ecx
	push edx
	push edi
	
	;ecx przesuniêcie od prawej
	;esi adres bajtu z danymi
	mov ebp, 5 ;iloœæ bitów do pobrania
	movzx ecx , cl ;wyzerowanie ecx, oprócz cl
	mov edx , 0FFFFFFFFh ;indeks kolejnego bajtu do pobrania
	xor eax, eax ;5 bitowy wynik

kolejny_bajt:
	inc edx
	mov edi , 8
	xor ebx, ebx ;przetwarzany bajt
	mov bl, [esi+edx]
	shr bl , cl
	sub edi, ecx
	xor ecx, ecx ;wyzerowanie przesuniêcia

ptl:
	shr bl, 1
	rcr al, 1
	dec ebp
	cmp ebp, 0
	jz koniec

	dec edi
	cmp edi, 0
	jz kolejny_bajt
	jmp ptl

koniec:
	shr al , 3
	pop edi
	pop edx
	pop ecx
	pop ebp
	ret
pobierz5bitow ENDP

;-----------ZAD 2 END------------;


_main:
;-----------ZAD 1------------;
	xor ecx, ecx ;przesuniêcie  w bajcie
	mov esi, offset tekst ;adres pocz¹tku przetwarzanego tekstu
	mov edi, offset wynik ;adres pocz¹tku teksu wynikowego

	push edi ;zapamiêtanie adresu pocz¹tku tekstu

nastepne_5_bitow:
	call pobierz5bitow

	cmp al, 0
	jz dalej

	cmp al, 27
	jnz nie_spacja
	mov al, 20h
	jmp dalej

nie_spacja:
	add al , 60h

dalej:
	mov [edi] , al
	inc edi
	cmp al, 0
	jz koniec_tekstu
	
	add ecx, 5
	cmp ecx, 7
	jna nastepne_5_bitow
	inc esi ;nastepny bajt tekstu Ÿród³owego
	sub ecx, 8; ustawiamy przesuniêcie w nowym bajcie Ÿród³owym

	jmp nastepne_5_bitow

koniec_tekstu:
	mov [edi] , byte PTR 0
	pop edi
;-----------ZAD 1 END------------;

	push dword PTR 20
	push offset wynik
	push dword PTR 1

	call __write
	add esp , 12

	push 0
	call _ExitProcess@4

END