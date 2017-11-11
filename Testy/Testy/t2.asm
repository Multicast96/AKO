.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern __write : PROC

public _main

.data

tekst db 10 dup (10)

.code

pisz PROC

	

pisz ENDP

_main:
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx ;wsk tekst
		
	mov ax, 253
	mov bl, 10

ptl:
	div bl

	add ah, '0'
	mov tekst[ecx], ah
	inc ecx
	xor ah,ah

	cmp al, 0
	jnz ptl

	mov eax, 0
	dec ecx ;iloœæ znaków

ptl2:
	mov bl, tekst[eax]
	xchg bl, tekst[ecx]
	mov tekst[eax], bl

	inc eax
	dec ecx

	cmp eax, ecx
	jnz ptl2

	push 10
	push offset tekst
	push 1

	call __write
	
	push 0
	call _ExitProcess@4
END