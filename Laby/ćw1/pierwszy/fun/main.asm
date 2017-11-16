; program przyk³adowy (wersja 32-bitowa)
.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreœlenia)
public _main
.data
tekst db 10, 'Nazywam sie . . . ' , 10
db 'Moj pierwszy 32-bitowy program '
db 'asemblerowy dziala juz poprawnie!', 10
.code
_main PROC
_main ENDP
END