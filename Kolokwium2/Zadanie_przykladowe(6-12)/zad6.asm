.686
.model flat

public _kwadrat
;a^2= (a – 2)^2 + 4*a – 4 dla a > 1
;a^2 = 1 dla a = 1
;a^2 = 0 dla a = 0
.code

_kwadrat PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx,[ebp+8] ;zmienna a

	cmp ebx,1
	jz return_1
	cmp ebx,0
	jz return_0

	sub ebx,2 ;(a-2)
	push ebx
	call _kwadrat ;obliczenie (a-2)^2
	add esp,4 ;usuniecie parametru ze stosu
	add ebx,2 ;przywrocenie oryginalnej wartosci a
	add ebx,ebx ;a*2
	add ebx,ebx ;(a*2)*2=a*4
	sub ebx,4 ;a*4 - 4

	add eax,ebx ;(a-2)^2 + a*4-4
	jmp koniec

return_1:
	mov eax,1
	jmp koniec
return_0:
	mov eax,0
koniec:
	pop ebx
	pop ebp
	ret
_kwadrat ENDP

END