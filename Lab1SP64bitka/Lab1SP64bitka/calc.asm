printf proto c : vararg
EXTERN K : DWORD

.data
msg db 'Output from asm module is: %d', 0

.code
calc PROC

		sub		rsp,	20h
		
		xor		rax, rax
		mov		ax,	 cx
		cwde
		mov		ebx, eax
		mov		al, dl
		cbw
		cwde
		sub		ebx, eax
		mov		eax, ebx
		shl		eax, 2
		mov		r12d, eax

		xor		eax, eax
		mov		ax,	 r8w
		lea		edx, [eax + 3]
		test	ax, ax
		js		next_position
		sar		ax, 2
		jmp		end_point
		cwde
		next_position:
		mov		eax, edx
		sar		ax, 2
		cwde
		end_point:
		mov		edx, eax
		mov		eax, r12d
		add		eax, edx
		add		eax, K

		mov		r12d,	eax
		lea		rcx,	msg
		mov		edx,	eax
		call	printf
		mov		eax,	r12d
		add		rsp,	20h
		ret

calc ENDP
END