.686
.XMM ; zezwolenie na asemblacjê rozkazów grupy SSE
.model flat
	public _sumuj_tablice
.data
.code

	_sumuj_tablice PROC
		push ebp
		mov ebp,esp

		mov eax, [ebp+8]
		mov ebx, [ebp+12]
		mov ecx, [ebp+16]

		movups xmm5, [eax]
		movups xmm6, [ebx]

		paddsb xmm5 , xmm6

		movups [ecx], xmm5

		pop ebp
		ret
	_sumuj_tablice ENDP
END