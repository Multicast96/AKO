.686
.model flat

public _plus_jeden

.code
_plus_jeden PROC
 push ebp
 mov ebp, esp
 push ebx
 push esi
 push edi
; odczytanie liczby
; w formacie double
 mov eax, [ebp+8]
 mov edx, [ebp+12]
; wpisanie 1 na pozycji o wadze 2^0
; mantysy do EDI:ESI
 mov esi, 0
 mov edi, 00100000H
; wyodrêbnienie pola
; wyk³adnika (11-bitowy)
; bit znaku liczby z za³o¿enia = 0
 mov ebx, edx
 shr ebx, 20
; obliczenie pierwotnego wyk³adnika
; potêgi
 sub ebx, 1023
; zerowanie wyk³adnika i bitu znaku
 and edx, 000FFFFFH
; dopisanie niejawnej jedynki
 or edx, 00100000H
; za³adowanie obliczonej wartoœci z
; EDX:EAX na wierzcho³ek stosu
; koprocesora
	mov esi,00100000h
	xor ecx,ecx
	mov cl,bl

	cmp cl,21
	jb maly_wykladnik
	sub cl,21
	mov esi,80000000h
	shr esi,cl
	add eax,esi
	adc edx, 0
	jmp sprawdz_czy_zwiekszyc_wykladnik

maly_wykladnik:
	shr esi,cl
	add edx,esi

sprawdz_czy_zwiekszyc_wykladnik:
	bt edx,21
	jnc dalej
	;zwiekszenie wykladnika
	inc ebx
	shr edx,1
	rcr eax,1
	;obsluga zaokraglenia

dalej:
	add ebx,1023
	and edx, 0FFFFFh
	shl ebx, 20
	or edx,ebx

 push edx
 push eax
 fld qword PTR [esp]
 add esp, 8
 pop edi
 pop esi
 pop ebx
 pop ebp
 ret
_plus_jeden ENDP

END