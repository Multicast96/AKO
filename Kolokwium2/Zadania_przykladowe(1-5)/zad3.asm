.686
.model flat

public _komunikat
extern _malloc : PROC

.data
	t1 db 'B',88h,0A5h,'d','.',0
	t2 db 0
.code
	_komunikat PROC
		push ebp
		mov ebp, esp
		push esi
		push ebx
		push edi

		mov esi, [ebp+8];adres tekstu zrodlowego
		mov ebx, OFFSET t2 - OFFSET t1 ;dlugosc dodatkowego komunikatu [B]
		
		xor ecx,ecx ;d³ugosc tekstu zrodlowego [B]

dlugosc_tekstu_zrodlowego:
		mov al, [esi+ecx]
		inc ecx
		cmp al, 0 ;sprawdzamy czy to nie koniec tekstu
		jnz dlugosc_tekstu_zrodlowego
		dec ecx ;odejmujemy od dlugosci tekstu bo nie liczymy zera konczacego

		add ebx,ecx ;ile znakow bedzie mial w sumie tekst wynikowy
		
		push ecx ;malloc mo¿e zmodyfikowaæ wszystkie rejestry oprócz ebx,ebp,esi,edi :(
		push ebx
		call _malloc ;rezerwujemy obszar o wielkosci ebx + ecx
		pop ebx
		pop ecx
		push eax ;adres obszaru docelowego - kopia
		mov edi,eax ;adres obszaru docelowego

		cld ;znacznik df = 0 operacje blokowe przesuwaja adresy +1
		rep movsb
		mov ecx, OFFSET t2 - OFFSET t1
		mov esi, OFFSET t1
		rep movsb

		pop eax ;adres poczatku obszaru docelowego

		pop edi
		pop ebx
		pop esi
		pop ebp
		ret
	_komunikat ENDP

END