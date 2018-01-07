extern qsort : PROC
public sort_int

.code

cmp2 PROC
	mov rcx, [rcx] ;parametr a
	mov rdx, [rdx] ;parametr b

	mov rax,1
	cmp rcx,rdx
	ja koniec
	mov rax,0
koniec:
	ret
cmp2 ENDP

sort_int PROC
	;rcx adres tablicy
	;rdx liczba elem
	mov r8,8
	mov r9,cmp2

	sub rsp,40 ;shadow space(32 bajty) + 8 bajtow wyrownania stosu
	call qsort
	add rsp,40
	ret
sort_int ENDP

END
