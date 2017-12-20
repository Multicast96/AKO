.686
.model flat
public _BubbleSortLow

.code

_BubbleSortLow PROC
	push ebp
	mov ebp, esp

	mov esi, [ebp + 8] ;pocz¹tek tablicy
	mov edx, [ebp + 12] ;rozmiar tablicy

	xor eax, eax ;int i = 0
ptl1:
	cmp eax, edx
	jz ptl1_end
	
	xor ebx, ebx ;int j = 0;
ptl2:
	dec edx ; n - 1
	cmp ebx, edx
	jz ptl2_end
	inc edx

	mov ecx, [esi + ebx*4]
	cmp ecx , [esi + ebx*4 + 4]
	jle dalej

	xchg ecx, [esi + ebx*4 + 4]
	xchg [esi + ebx*4], ecx
dalej:
	inc ebx
	jmp ptl2
ptl2_end:
	inc edx
	inc eax
	jmp ptl1

ptl1_end:

	pop ebp
	ret
_BubbleSortLow ENDP

END