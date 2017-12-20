.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern __write : PROC
public _main

.data
	daty dd 21h, 0B3h
	wynik db 20 dup (' ') ,0
	dzielnik db 10
.code

_main:
	mov ecx, 2
	mov ebx, offset daty
	mov edi, offset wynik

	dec ecx
	mov ebx, [ebx+ 4*ecx]

	mov ecx, 19
	mov edx, 0
dalej:
	cmp ebx, 0
	jz koniec

	shr ebx, 1
	inc edx
	jnc dalej

	mov eax, edx
	div byte PTR dzielnik
	add ah, '0'
	add al, '0'
	mov [edi+ecx], ah
	dec ecx
	mov [edi+ecx], al
	sub ecx, 2
	jmp dalej

koniec:
	push 21
	push offset wynik
	push 1
	call __write

	add esp, 12
	nop
	push 0
	call _ExitProcess@4

END