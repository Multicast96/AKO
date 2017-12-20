.686
.model flat

 public _szukaj4_max

 .code

 _szukaj4_max PROC
 	push ebp
	mov ebp, esp

	mov ecx, 3 ;licznik
	mov edi, 2 ;indeks
	mov eax, [ebp + edi * 4]

dalej:
	inc edi
	mov ebx, [ebp + edi * 4]
	cmp eax, ebx
	jg lop
	xchg eax,ebx
lop:
	loop dalej
	
	pop ebp
	ret
 _szukaj4_max ENDP

 END