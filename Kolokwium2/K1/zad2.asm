public ob_stozka_sc

.data
	trzy dd 3.0
.code

ob_stozka_sc PROC
;xmm0 = r , xmm1 = R , xmm3 = h
	sub rsp,16 ;rezerwacja miejsca na r
	movups [rsp], xmm0

	fld dword PTR [rsp] ;st(0)= r
	fld st(0) ;st(0)= r st(1)= r
	fmul st(1), st(0) ;st(0)= r st(1)= r^2
	
	sub rsp,16; rezerwacja miejsca na R
	movups [rsp], xmm1
	fld dword PTR [rsp]  ;st(0) = R st(1)= r st(2)= r^2
	fld st(0)  ;st(0) = R st(0) = R st(1)= r st(2)= r^2
	fmul st(1),st(0) ;st(0) = R st(1) = R^2 st(2)= r st(3)= r^2
	
	fmulp st(2),st(0);st(0) = R^2 st(1)= R*r st(2)= r^2
	fadd
	fadd ;st(0) = R^2 + R*r + r^2

	fldpi ;st(0) = pi
	
	sub rsp,16 ;rezerwacja miejsca na h
	movups [rsp], xmm2 
	fld dword PTR [rsp]
	fmul
	fmul
	fld dword PTR trzy
	fdiv

	fstp dword PTR [rsp]
	movups xmm0, [rsp]
	add rsp,48
	ret
ob_stozka_sc ENDP

END