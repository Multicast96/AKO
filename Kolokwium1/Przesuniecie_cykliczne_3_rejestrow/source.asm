.686
.model flat

extern _ExitProcess@4 : PROC
public _main

;Napisaæ program przesuniecia cyklicznego w lewo o 1 liczby 96-bitowej znajduj¹cej siê
;w rejestrach EAX:EBX:ECX

;Wykorzystaniem rozkazy RCL, BT i SHL


;Dane do przyk³adu
;mov EAX, 0AFFFFFFFh
;mov EBX, 0BFFFFFFFh
;mov ECX, 0CFFFFFFFh

;wynik
;EAX: FFFFFFFBh;
;EBX: FFFFFFFCh;
;ECX: FFFFFFFAh;
.data

.code
_main:
	mov EAX, 07FFFFFFDh
	mov EBX, 07FFFFFFDh
	mov ECX, 0FFFFFFFEh

	bt eax, 31
	rcl ecx , 1
	rcl ebx , 1
	rcl eax , 1
	nop


push 0
call _ExitProcess@4

END