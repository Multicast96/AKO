.686
.model flat

	extern _ExitProcess@4 : PROC
	public _main

.data
.code

_main:

	push 0
	call _ExitProcess@4
END