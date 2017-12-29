.686
.model flat

public _iteracja

.code
_iteracja PROC
 push ebp
 mov ebp, esp
 mov al, [ebp+8]
 sal al, 1
; SAL wykonuje przesuniecie logiczne
; w lewo
 jc zakoncz
 inc al
 push eax
 call _iteracja
 add esp, 4
 pop ebp
 ret
zakoncz: rcr al, 1
; rozkaz RCR wykonuje przesuni�cie
; cykliczne w prawo przez CF
 pop ebp
 ret
_iteracja ENDP

END