.686
.model flat

public _NWD

.code

_NWD PROC
	push ebp
	mov ebp,esp
	push edi
	push esi

	mov edi, [ebp+8];parametr a
	mov esi, [ebp+12];parametr b

	cmp edi,esi
	
	;a==b
	jnz a_rozne_b
	mov eax, edi
	jmp return

a_rozne_b:
	;a > b
	jb a_mniejsze_b
	push esi ;parametr b do wywolania funkcji
	sub edi,esi ;a-b
	push edi ;parametr a-b do wywolania funkcji
	jmp rekurencja
a_mniejsze_b:
	;a < b
	sub esi,edi ;b-a
	push esi;parametr b-a wywo³ania funkcji
	push edi;parametr a do wywolania funkcji
rekurencja:
	call _NWD
	add esp,8
return:
	pop esi
	pop edi
	pop ebp
	ret
_NWD ENDP

END