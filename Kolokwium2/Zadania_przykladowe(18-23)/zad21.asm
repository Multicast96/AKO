.686
.model flat

;extern _GetSystemInfo@36 : PROC
;extren _MessageBoxA@16 : PROC
public _float_razy_float

.code

_float_razy_float PROC
	push ebp
	mov ebp,esp
	push ebx

	mov eax,[ebp+8] ;float a
	mov ebx,[ebp+12];float b

	mov edx,eax ;wykladnik a
	mov ecx,ebx ;wykladnik b

	shr edx,23
	shr ecx,23
	sub edx,127
	sub ecx,127

	add ecx,edx ;wykladnik wyniku

	xor edx,edx ;tu bedzie wyzsza czesc wyniku mnozenia EDX:EAX
	bts eax, 23;dopisanie niejawnej jedynki
	bts ebx, 23

	and eax, 0FFFFFFh ;wyzerowanie wszystkiego oprocz mantysy
	and ebx, 0FFFFFFh

	mul ebx ;mnozymy mantysy przez siebie

	shr eax,23
	pushf
	shl edx,9
	or eax,edx
	popf
	adc eax,0

jeszcze_raz:
	bt eax,24
	jnc dalej 
	;wartosc ilocznynu jest wieksza od 2
	inc ecx
	shr eax,1
	adc eax,0
	jmp jeszcze_raz

dalej:
	and eax, 7FFFFFh
	;btc eax,23 ;usuwamy niejawna jedynke
	add ecx,127
	shl ecx,23
	or eax,ecx

	push eax
	fld dword PTR [esp]
	add esp,4

	pop ebx
	pop ebp
	ret
_float_razy_float ENDP

END