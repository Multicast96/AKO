;.686
;.model flat
;extern _ExitProcess@4 : PROC
;extern _MessageBoxW@16 : PROC
;public _main
;
;.data
	;tytul_Unicode dw 'Z','n','a','k','i',0
    ;tekst_Unicode dw 'S','z','c','z','u','r',' '
				  ;dw 0d83dH,0dc00H ;szczur - 3dd800dc
				  ;dw ' ','i',' '
				  ;dw 0d83dH, 0dc04H;3dd804dc - krowa
				  ;dw ' ','k','r','o','w','a',0
;;
;.code
;_main:
	;push 0 ; stala MB_OK
	;; adres obszaru zawieraj¹cego tytu³
	;push OFFSET tytul_Unicode
	;; adres obszaru zawieraj¹cego tekst
	;push OFFSET tekst_Unicode
	;push 0 ; NULL
	;call _MessageBoxW@16
	;push 0 ; kod powrotu programu
	;call _ExitProcess@4
END