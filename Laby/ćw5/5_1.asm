.686
.model flat

	public _srednia_harmoniczna
.data
	jeden dword 1
.code
	_srednia_harmoniczna PROC
		push ebp
		mov ebp , esp

		push ebx
		push esi
		push edi

		xor ecx,ecx ;indeks tablicy
		mov eax, [ebp+12] ;zmienna n - rozmiar tablicy
		mov esi, [ebp+8];adres tablicy
		
		fldz ;za³adowanie zera
next:
		fild jeden 
		fld dword PTR [esi+ecx*4]
		;stos st(0)=tab[0] st(1)=1
		fdivp ;st(0)=st(1)/st(0)
		faddp
		inc ecx
		cmp ecx,eax
		jb next

		fild dword PTR [ebp+12] ;zmienna n
		fxch
		fdivp

		pop edi
		pop esi
		pop ebx
		pop ebp
	ret
	_srednia_harmoniczna ENDP
END