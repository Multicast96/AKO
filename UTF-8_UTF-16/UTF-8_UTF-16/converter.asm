.686

.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
public _main 

.data

tekstUTF8 db 50h,6fh,0c5h,82h,0c4h,85h,63h,7ah,65h,6eh,69h,65h,20h
		  db 7ah,6fh,73h,74h,61h,0c5h,82h,6fh,20h,6eh,61h,77h,69h
		  db 0c4h, 85h,7ah, 61h, 6eh,65h,2eh,0e2h,91h,0a4h
		  db 0ah, 0f0h, 9fh, 9ah, 82h, 20h, 2dh, 20h, 0f0h, 9fh, 9ah, 8ch
koniec_tekst db ?
tekstUTF16 dw 140 dup (?)

.code

_main:

xor ebp,ebp ;wskaŸnik na przetwarzany tekst
xor eax,eax ;wskaŸnik na tekst wynikowy
xor edx,edx ;iloœæ znaków tekstu

mov edx, OFFSET koniec_tekst - OFFSET tekstUTF8

nastepny:
	cmp edx, ebp ;czy przetworzyliœmy wszystkie znaki ?
	jz koniec

	xor ebx,ebx ;przetwawrzany bajt
	mov bl, tekstUTF8[ebp] ;pobranie kolejnego bajtu rozpoczynaj¹cego znak
	inc ebp
	xor ecx, ecx ;ilu bajtowy znak?

ile_bajtow:
	rol bl, 1
	inc ecx
	jnc wyznaczono_liczbe_bajtow
	jmp ile_bajtow

wyznaczono_liczbe_bajtow:
	ror bl, cl

	cmp ecx,1 ;znak 1-bajtowy
	jz zapis
	cmp ecx, 3 ;znak 2-bajtowy
	jz dwa_bajty
	cmp ecx, 4
	jz trzy_bajty
	jmp cztery_bajty

dwa_bajty:
	and bl, 00011111b
	shl bx, 6
	mov cx, bx
	xor bx,bx
	mov bl, tekstUTF8[ebp]
	inc ebp
	and bl, 00111111b
	or  bx,cx
	jmp zapis

trzy_bajty:
	and bl, 00001111b
	shl bx, 12
	mov cx , bx

	mov bl, tekstUTF8[ebp]
	inc ebp
	and bl, 00111111b
	shl bx, 6
	or cx, bx

	mov bl, tekstUTF8[ebp]
	inc ebp
	and bl, 00111111b
	or bx, cx
	jmp zapis

cztery_bajty:
	and bl, 00000111b
	shl ebx, 18
	mov ecx, ebx

	mov bl, tekstUTF8[ebp]
	inc ebp
	and bl, 00111111b
	shl ebx, 12
	or ecx, ebx

	xor ebx,ebx
	mov bl, tekstUTF8[ebp]
	inc ebp
	and bl, 00111111b
	shl ebx, 6
	or  ecx, ebx

	xor ebx,ebx
	mov bl, tekstUTF8[ebp]
	inc ebp
	and bl, 00111111b
	or  ebx, ecx

	sub ebx, 10000h

	mov ecx, ebx
	shr ebx, 10 ;1101 1000 0000 0000b trzeba dodaæ
	or bx, 0D800h

	and cx , 3FFh ;0000 00xx xxxx xxxx maska
	or cx, 0DC00h ;1101 1100 0000 0000b trzeba dodac

	;shl ebx, 6
	;mov cx, bx
	;shr cx, 6
	;or  cx, 1101110000000000b
;
	;shr ebx, 16
	;or  bx , 1101100000000000b

	mov tekstUTF16[eax], bx
	add eax,2
	mov tekstUTF16[eax], cx
	add eax,2
	jmp nastepny


zapis:
	mov tekstUTF16[eax], bx
	add eax, 2
	jmp nastepny

koniec:
	push 0
	push 0
	push offset tekstUTF16
	push 0
	call _MessageBoxW@16



push 0
call _ExitProcess@4

END