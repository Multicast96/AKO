.686
.model flat

extern _ExitProcess@4 : PROC

public _main

.data

pwnd db 64h,35h,34h,61h,32h,63h,67h,34h,60h,61h,64h,37h,36h
	 db 5fh,37h,60h,64h,66h,37h,67h,33h,61h,37h,32h,61h,34h
	 db 66h,60h,36h,67h,62h,5dh,34h,40h,3eh,0ah

n = $ - pwnd

.code
_main:
	mov ecx, offset pwnd
	mov edx, ecx

	add ecx, n
	jmp _C
	db 83h,0b0h,01h,0cdh,80h
_A:
	add al, 2Fh
	mov byte PTR [edx] , al
_B:
	inc edx
	cmp edx, ecx
	je $-11
_C:
	movzx eax, byte PTR [edx]
	lea ebx, [eax-21h]

	cmp bl, 5Dh
	ja _A

	cmp al, 4Fh
	jle _A

	sub al, 2Fh
	inc edx
	mov byte PTR [edx - 1] , al
	cmp edx, ecx
	jne _C

	jmp $-38

	push 0
	call _ExitProcess@4
END