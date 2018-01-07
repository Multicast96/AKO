public funkcja

.data
jeden dd 1.0
dwa dq 2.0
.code

funkcja PROC
	push rbp
	mov rbp,rsp
	push rbx

	finit

	cmp rcx,1
	jz return_jeden
	cmp rcx,2
	jz return_dwa

	;n>2
	mov rbx,rcx ;n
	sub rcx,1 ;n-1
	sub rsp,40 ;shadow space + 8 bajtow wyrownania
	call funkcja ;w xmmo0 wynik funkcja(n-1)
	add rsp,40 ;wyrownanie stosu

	mov rax, 3F99999Ah;1.2
	push rax ;8 bajtow stos
	fld dword PTR [rsp]

	sub rsp,8 ;16 bajtow stos
	movss dword PTR [rsp],xmm0
	fld dword PTR [rsp] ;funkcja(n-1)
	fsub ;st(0) = 1.2 - funkcja(n-1)

	mov [rsp], rbx
	fild qword PTR [rsp] ;n
	fdiv ;st(0) = (1.2 - funkcja(n-1))/n
	
	mov rax,0
	mov [rsp],rax
	mov [rsp+8], rax
	fstp dword PTR [rsp]

	movss xmm0, dword PTR [rsp]
	add rsp,16
	jmp koniec

return_jeden:
	movss xmm0, jeden
	jmp koniec

return_dwa:
	movq xmm0, dwa

koniec:


	pop rbx
	pop rbp
	ret
funkcja ENDP

END