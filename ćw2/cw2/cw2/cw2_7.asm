; wczytywanie i wy�wietlanie tekstu wielkimi literami
; (inne znaki si� nie zmieniaj�)
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC ; (dwa znaki podkre�lenia)
extern __read : PROC ; (dwa znaki podkre�lenia)
public _main
.data
tytul_okna dw 'P','o','d','a','n','y',' ','t','e','k','s','t',':',0
tekst_pocz db 'Prosz',0A9h,' napisa',86h,' jaki',98h,' tekst i nacisnac Enter', 10
koniec_t db ?
magazyn db 80 dup (?) ;tablica 80 bajt�w, ka�dy zainicjalizowany warto�ci� '?'
wynik dw 80 dup (?)
nowa_linia db 10
liczba_znakow dd ?
male_latin2 db 0A5h,86h,0A9h,88h,0E4h,0A2h,98h,0ABh,0BEh ;�,�
duze_utf_16 dw 0104h, 0106h,0118h,0141H,0143H,00D3H,015AH,0179H,017BH ;�,�
.code
_main:
	mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)	; liczba bajt�w tekstu informacyjnego
	push ecx
	push OFFSET tekst_pocz ; adres tekstu
	push 1 ; nr urz�dzenia (tu: ekran - nr 1)
	call __write ; wy�wietlenie tekstu pocz�tkowego

	;czytanie wiersza z klawiatury
	push 80 ; maksymalna liczba znak�w
	push OFFSET magazyn
	push 0 ; nr urz�dzenia (tu: klawiatura - nr 0)
	call __read ; czytanie znak�w z klawiatury
	; kody ASCII napisanego tekstu zosta�y wprowadzone
	; do obszaru 'magazyn'
	; funkcja read wpisuje do rejestru EAX liczb� wprowadzonych znak�w
	mov liczba_znakow, eax ;rejestr ECX pe�ni rol� licznika obieg�w p�tli
    mov ecx, eax
	mov ebx, 0 ; indeks pocz�tkowy
	mov edx, 0;

ptl: 
	xor dx, dx
	mov dl, magazyn[ebx] ; pobranie kolejnego znaku
	cmp dl, 'a'
	jae t1
	jmp t3
t1: 
	cmp dl, 'z'
	jbe t2
	jmp t3
t2:
	sub dx, 20H ; zamiana na wielkie litery
	jmp zapis
t3:
	jmp zamiana_latin2 	;mo�e to polski znak
zapis:
	mov wynik[ebx*2], dx ; odes�anie znaku do pami�ci

dalej:
	inc ebx ; inkrementacja indeksu
	loop ptl ; sterowanie p�tl�

	; wy�wietlenie przekszta�conego tekstu
	push 0 ; sta�a MB_OK
	push OFFSET tytul_okna
	push OFFSET wynik
	push 0 ;NULL
	call _MessageBoxW@16 ; wy�wietlenie przekszta�conego tekstu
	push 0
	call _ExitProcess@4 ; zako�czenie programu

zamiana_latin2:
	;latin2 zamiana ma�ych polskich znak�w na du�e
	push eax
	push ebx
	mov eax , 0 ;licznik petli
	mov ebx , 9 ;ilo�� polskich znak�w w alfabecie

sprawdzanie:
	cmp dl,  [male_latin2+eax]
	jz znaleziono
	
	inc eax
	cmp eax , ebx
	jz przywroc_ze_stosu

	jmp sprawdzanie

znaleziono:
	mov dx , [duze_utf_16+eax*2]
	pop ebx
	pop eax
	jmp zapis

przywroc_ze_stosu:
	pop ebx
	pop eax
	MOV wynik[ebx*2], dx
	jmp dalej
END