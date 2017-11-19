.686
.model flat

	extern _ExitProcess@4 : PROC
	extern __write : PROC
	public _main

.data

	liczba dd 0FEDCBA98h ,76543210h,0FEDCBA98h
	wynik db 30 dup(' '),10,0
.code

_main:
	mov esi, offset liczba
	mov edi, offset wynik

	mov ecx, 29 ;max indeks znaku w tekscie
	mov ebx, 10 ;dzielnik

ptl:
	xor edx,edx
	mov eax, [esi+8]
	div ebx
	mov [esi+8], eax

	mov eax, [esi+4]
	div ebx
	mov [esi+4], eax

	mov eax, [esi]
	div ebx
	mov [esi], eax

	add dl , '0'
	mov [edi+ecx], dl
	dec ecx

	cmp eax, 0
	jnz ptl

	push 32
	push edi
	push 1
	call __write

	push 0
	call _ExitProcess@4
END