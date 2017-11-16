;.686
;.model flat
;extern _ExitProcess@4 : PROC
;extern __write : PROC
;public _main
;
;.data
	;tekst db 10, 'Nazywam sie Kamil Dakus' , 10
		  ;db 'M',0A2H,'j pierwszy 32-bitowy program '
          ;db 'asemblerowy dzia',88H,'a ju',0BEH,' poprawnie!', 10
	;
;.code
;_main:
	;push 90
	;push OFFSET tekst
	;push 1
	;call __write
;
	;push 0
	;call _ExitProcess@4
END