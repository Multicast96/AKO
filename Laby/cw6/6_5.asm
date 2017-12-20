; Program linie.asm
; Wyświetlanie znaków * w takt przerwań zegarowych
; Uruchomienie w trybie rzeczywistym procesora x86
; lub na maszynie wirtualnej
; zakończenie programu po naciśnięciu dowolnego klawisza
; asemblacja (MASM 4.0): masm gwiazdki.asm,,,;
; konsolidacja (LINK 3.60): link gwiazdki.obj;
.386
rozkazy SEGMENT use16
 ASSUME cs:rozkazy
 
linia PROC
; przechowanie rejestrów
 push ax
 push bx
 push es
 push si
 push di
 
 
 mov ax, 0A000H ; adres pamięci ekranu dla trybu 13H
 
 mov es, ax
 mov bx, cs:adres_pikselaL ;adres bieżący piksela lewej przekątnej
 mov di, cs:adres_pikselaR ;adres bieżący piksela prawej przekątnej
 mov al, cs:kolor
 mov si, cs:blad_e
 
 cmp bx, 320 * 200
 ja nie_rysuj

 mov es:[bx], al ;lewa przekątna wpisanie koloru piksela
 mov es:[di], al ;prawa przekątna wpisanie koloru piksela
 
 inc bx,1 ;x1 = x1+1
 dec di,1 ;x2 = x2 - 1
 sub si,200 ;blad = blad - dy
 
 cmp si,0
 jge koniec
 
 add bx,320 ;y1 = y1 + 1
 add di,320 ;y2 = y2 + 1
 add si,320 ;blad = blad + dx
 
koniec:
 mov cs:adres_pikselaL, bx
 mov cs:adres_pikselaR, di
 mov cs:blad_e, si
nie_rysuj:

 pop di
 pop si
 pop es
 pop bx
 pop ax
; skok do oryginalnego podprogramu obsługi przerwania
; zegarowego
 jmp dword PTR cs:wektor8
 
; zmienne procedury
kolor db 00000111b ; bieżący numer koloru
adres_pikselaL dw 0 ; bieżący adres piksela przekątnej z lewej strony
adres_pikselaR dw 319 ;bieżący aders piksela przekątnej z prawej strony

linia_dx dw 320
linia_dy dw 200
blad_e dw 160
przekatna dw 0

przyrost dw 0
wektor8 dd ?
linia ENDP

; INT 10H, funkcja nr 0 ustawia tryb sterownika graficznego
zacznij:
 mov ah, 0
 mov al, 13H ; nr trybu
 int 10H
 mov bx, 0
 mov es, bx ; zerowanie rejestru ES
 mov eax, es:[32] ; odczytanie wektora nr 8
 mov cs:wektor8, eax; zapamiętanie wektora nr 8
; adres procedury 'linia' w postaci segment:offset
 mov ax, SEG linia
 mov bx, OFFSET linia
 cli ; zablokowanie przerwań
; zapisanie adresu procedury 'linia' do wektora nr 8
 mov es:[32], bx
 mov es:[32+2], ax
 sti ; odblokowanie przerwań
czekaj:
 mov ah, 1 ; sprawdzenie czy jest jakiś znak
 int 16h ; w buforze klawiatury
 jz czekaj
 mov ah, 0 ; funkcja nr 0 ustawia tryb sterownika
 mov al, 3H ; nr trybu
 int 10H
; odtworzenie oryginalnej zawartości wektora nr 8 
 mov eax, cs:wektor8
 mov es:[32], eax
; zakończenie wykonywania programu
 mov ax, 4C00H
 int 21H
rozkazy ENDS
stosik SEGMENT stack
 db 256 dup (?)
stosik ENDS
END zacznij 
