.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
public _main

.data

;tekst db 00001010b, 11011111b, 10110101b, 00010110b, 01110100b, 11011001b, 01010111b, 00111010b, 01001000b, 00100000b
 tekst db 01000001b, 00001100b, 00000000b
wynik db 10 dup (?)

.code

; ZAD 2
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

_main:

	mov esi , offset tekst + 1
	mov ecx , 2
	call pobierz5bitow
	nop

call _ExitProcess@4

END