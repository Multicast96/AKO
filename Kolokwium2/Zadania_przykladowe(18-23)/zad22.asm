.686
.model flat

public _sortowanie
extern _qsort : PROC

.code
_cmp PROC
 ;parametry a i b
 ;a > b return -1
 ;a < b return 1
 ;else return 0
 push ebp
 mov ebp,esp
 push edi
 push esi

 mov ecx, [ebp+8];adres parametru a
 mov edx, [ebp+12];adres parametru b


 mov esi, [ecx+4];starsza czesc parametru a
 mov edi, [edx+4];starsza czesc parametru b

 cmp esi,edi
 ja a_wieksze ;a > b
 jb b_wieksze ;a < b
	mov esi,[ecx];mlodsza czesc parametru a
	mov edi,[edx];mlodsza czesc parametru b

	cmp esi,edi
	ja a_wieksze ;a > b
	jb b_wieksze ;a < b
	mov eax,0 ;a == b
	jmp koniec

a_wieksze:
	mov eax,-1
	jmp koniec
b_wieksze:
	mov eax,1
koniec:
 pop esi
 pop edi
 pop ebp
ret
_cmp ENDP

_sortowanie PROC
	push ebp
	mov ebp,esp
	push esi
	push ebx

	mov esi, [ebp+8] ;adres tablicy liczb
	mov ebx, [ebp+12] ;n rozmiar tablicy
	
	push _cmp
	push 8
	push ebx
	push esi

	call _qsort
	add esp,16

	;EDX:EAX zwracana wartosc
	dec ebx
	mov eax,[esi+ebx*8]
	mov edx,[esi+ebx*8+4]

	pop ebx
	pop esi
	pop ebp
	ret
_sortowanie ENDP

END