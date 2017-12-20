.686
.model flat
public _roznica

.data
.code

 _roznica PROC
	push ebp
	mov ebp, esp ;standardowy prolog
	push ebx
	
	mov eax, [ebp+8] ;adres odejmnej
	mov ebx, [ebp+12] ;adres adresu odejmnika

	mov eax, [eax]
	mov ebx, [ebx]
	mov ebx, [ebx]

	sub eax,ebx

	pop ebx
	pop ebp ;epilog
	ret
 _roznica ENDP

END