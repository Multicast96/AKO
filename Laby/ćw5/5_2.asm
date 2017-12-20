.686
.model flat

	public _nowy_exp
.data
	nr_wyrazu dword 1
.code
	_nowy_exp PROC
	push ebp
	mov ebp, esp

	mov ecx, 20 ;liczba wyrazów do obliczenia

	fld1 ;suma st(4)
	dec ecx ;pierwszy wyraz 1

	fld1 ;silnia st(3)
	fldz ;nastepny wyraz silni st(2)
	fld dword PTR [ebp+8] ;zmienna - wartoœæ st(1)
	fld1 ;zmienna - potêgi st(0)

dalej:
	fmul st(0),st(1) ;obliczenie kolejnej potêgi x
	
	fld1
	fadd st(0),st(3) ;obliczanie nastêpnego wyrazu silni
	fmul st(4), st(0) ;obliczenie silni
	fxch st(3)
	fstp st(0)

	fld st(0) ;x^n
	fdiv st(0), st(4) ;x^n / n!

	fadd st(5) , st(0) ;suma += x^n/n!
	fstp st(0) ;??

	sub ecx,1
	jnz dalej
	
	fstp st(0)
	fstp st(0)
	fstp st(0)
	fstp st(0)

	pop ebp
	ret
	_nowy_exp ENDP

END