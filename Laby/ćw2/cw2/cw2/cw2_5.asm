 ;wczytywanie i wyœwietlanie tekstu wielkimi literami
 ;(inne znaki siê nie zmieniaj¹)
;.686
;.model flat
;extern _ExitProcess@4 : PROC
;extern __write : PROC ; (dwa znaki podkreœlenia)
;extern __read : PROC ; (dwa znaki podkreœlenia)
;public _main
;.data
;tekst_pocz db 'Prosz',0A9h,' napisa',86h,' jaki',98h,' tekst i nacisnac Enter', 10
;koniec_t db ?
;magazyn db 80 dup (?) ;tablica 80 bajtów, ka¿dy zainicjalizowany wartoœci¹ '?'
;nowa_linia db 10
;liczba_znakow dd ?
;male_latin2 db 0A5h,86h,0A9h,88h,0E4h,0A2h,98h,0ABh,0BEh ;¹,æ
;duze_latin2 db 0A4h,8Fh,0A8h,9Dh,0E3h,0E0h,97h,8Dh,0BDh ;¥,Æ
;.code
;_main:
	;mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)	; liczba bajtów tekstu informacyjnego
	;push ecx
	;push OFFSET tekst_pocz ; adres tekstu
	;push 1 ; nr urz¹dzenia (tu: ekran - nr 1)
	;call __write ; wyœwietlenie tekstu pocz¹tkowego
;
	;;czytanie wiersza z klawiatury
	;push 80 ; maksymalna liczba znaków
	;push OFFSET magazyn
	;push 0 ; nr urz¹dzenia (tu: klawiatura - nr 0)
	;call __read ; czytanie znaków z klawiatury
	;; kody ASCII napisanego tekstu zosta³y wprowadzone
	;; do obszaru 'magazyn'
	;; funkcja read wpisuje do rejestru EAX liczbê wprowadzonych znaków
	;mov liczba_znakow, eax ;rejestr ECX pe³ni rolê licznika obiegów pêtli
    ;mov ecx, eax
	;mov ebx, 0 ; indeks pocz¹tkowy
;
;ptl: 
	;mov dl, magazyn[ebx] ; pobranie kolejnego znaku
	;cmp dl, 'a'
	;jae t1
	;jmp t3
;t1: 
	;cmp dl, 'z'
	;jbe t2
	;jmp t3
;t2:
	;sub dl, 20H ; zamiana na wielkie litery
	;jmp zapis
;t3:
	;jmp zamiana_latin2 	;mo¿e to polski znak
;zapis:
	;mov magazyn[ebx], dl ; odes³anie znaku do pamiêci
;
;dalej:
	;inc ebx ; inkrementacja indeksu
	;loop ptl ; sterowanie pêtl¹
;
	;; wyœwietlenie przekszta³conego tekstu
	;push liczba_znakow
	;push OFFSET magazyn
	;push 1
	;call __write ; wyœwietlenie przekszta³conego tekstu
	;push 0
	;call _ExitProcess@4 ; zakoñczenie programu
;
;zamiana_latin2:
	;;latin2 zamiana ma³ych polskich znaków na du¿e
	;push eax
	;push ebx
	;mov eax , 0 ;licznik petli
	;mov ebx , 9 ;iloœæ polskich znaków w alfabecie
;
;sprawdzanie:
	;cmp dl,  [male_latin2+eax]
	;jz znaleziono
	;
	;inc eax
	;cmp eax , ebx
	;jz przywroc_ze_stosu
;
	;jmp sprawdzanie
;
;znaleziono:
	;mov dl , [duze_latin2+eax]
	;pop ebx
	;pop eax
	;jmp zapis
;
;przywroc_ze_stosu:
	;pop ebx
	;pop eax
	;jmp dalej
END