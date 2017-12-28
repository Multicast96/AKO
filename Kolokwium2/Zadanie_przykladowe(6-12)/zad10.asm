.686
.model flat

public _zad10

;esi > edi CF=1
;else CF=0
.code
	_sprawdz PROC
	push ebx

	xor ecx,ecx ;licznik bitow
	bt edi, 31 ;sprawdzamy najstarszy bit bardziej pojemnego typu
	jc edi_wieksze_CF0 ;jesli 1 to ta liczba (edi) jest wieksza
	rol edi, 1 ;teraz najstarsze bity obu liczb wskazuja te sama pozycje

dalej:
	inc ecx
	rol esi,1
	rol edi,1

	mov ax,si
	mov bx,di

	and ax,1h ;pobieramy po jednym bicie z kazdej liczby
	and bx,1h

	cmp ax,bx
	ja esi_wieksze_CF1
	jc edi_wieksze_CF0
	cmp ecx,31 ;sprawdzilismy wszyskie bity edi ?
	jnz dalej

;sprawdzamy ostatni bit esi
	rol esi,1
	bt esi,0
	jc esi_wieksze_CF1

edi_wieksze_CF0:
	clc
	jmp koniec
esi_wieksze_CF1:
	stc

koniec:
	pushf
	ror esi,32
	ror edi,32
	popf
	pop ebx
	ret
	_sprawdz ENDP

	_zad10 PROC
	push esi
	push edi

	mov esi , 100h ;1 w formacie1
	mov edi , 80h ;1 w formacie2
	call _sprawdz
	nop
	mov esi , 101h ;1 i 1/8 w formacie1
	mov edi , 80h ;1 w formacie2
	call _sprawdz
	nop
	mov esi , 101h ;1 i 1/8 w formacie1
	mov edi , 180h ;3 w formacie2
	call _sprawdz

	mov esi , 0FFFFFFFFh ;w formacie1
	mov edi , 0FFFFFFFFh ;w formacie2
	call _sprawdz
	nop

	pop esi
	pop edi
	ret
	_zad10 ENDP

END