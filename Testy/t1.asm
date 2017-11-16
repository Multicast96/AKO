;.686
;.model flat
;extern _ExitProcess@4 : PROC
;public _main
;
;.data
;.code
;_main:
;
;MOV ebx , 1 ;liczba n-2
;MOV ecx , 1 ;liczba n-1 ;wynik procedury
;MOV esi , 2 ;licznik pêtli
;MOV edi , 7 ;n -ta liczba fibonacciego
;
;petla:
;inc esi
;push ecx
;add ecx , ebx
;pop ebx
;
;cmp esi , edi ; sprawdzenie warunku
;jnz petla
;
;call _ExitProcess@4
END
