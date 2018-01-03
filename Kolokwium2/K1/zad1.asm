public NWD
;tryb 64 bitowy
;wywolanie funkcji
;przekazywanie parametrow int'y RCX, RDX, R8, R9, float'y XMM0 – XMM3
;zwracanie wartosci int'y RAX, floaty XMM0
;rejestry które musza byc zapisane i odtwarzanie
;RBX, RSI, RDI, RBP tak ja w 32-bitowym
;R12 – R15,
;XMM6 – XMM15
.code
NWD PROC
	mov rax,rcx ;wyn = a
	cmp rcx,rdx ;a,b
	jz wynik_a ;a == b
	ja nwd_a_minus_b ;a > b -> NWD(a-b,b)
	;a < b -> NWD(a,b-a)
	sub rdx,rcx ;b-a
	jmp rekurencja

nwd_a_minus_b:
	sub rcx,rdx

rekurencja:
	call NWD

wynik_a:
	ret
NWD ENDP

END