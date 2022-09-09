printf proto c : vararg
EXTERN K : DWORD

.data
msg db 'Output from asm module is: %d', 0

.code
calc PROC
		;allocate space for local variables
		sub		rsp,	20h
		
		;reset rax
		xor		rax, rax
		;move the first operant from fuction parametrs
		;to ax
		mov		ax,	 cx
		;extend ax to eax
		cwde
		;save the eax data to the ebx register
		mov		ebx, eax
		;move the second operant from fuction parametrs
		;to al
		mov		al, dl
		;extend al to ax then ax to eax
		cbw
		cwde
		;Perfort B-C
		sub		ebx, eax
		mov		eax, ebx
		;Perfort 4*(B-C)
		shl		eax, 2
		;Save result to the r12d register
		mov		r12d, eax

		;reset eax
		xor		eax, eax
		;enter the third operant from fuction parametrs
		;to al
		mov		ax,	 r8w
		;Save result of data from eax plus 3 in edx register
		lea		edx, [eax + 3]
		;check if the third operand is negative
		test	ax, ax
		js		next_position
		;if not just perform D/4 then go to another operations
		sar		ax, 2
		cwde
		jmp		end_point

		next_position:
		;if this is a negative operand 
		;move to eax data from edx register 41line on code
		;and then D/4 
		mov		eax, edx
		sar		ax, 2
		cwde

		end_point:
		;Save result in edx resister (D/4 result)
		mov		edx, eax
		;Take the first step result to the eax register(32line)
		mov		eax, r12d

		;Perform 4 * (B - C)+ D/4
		;and then perform 4 * (B - C)+ D/4 + K
		add		eax, edx
		add		eax, K

		;Save result to the r12d register
		mov		r12d,	eax
		;Print message
		lea		rcx,	msg
		mov		edx,	eax
		call	printf
		;Return result value
		mov		eax,	r12d
		;Return the stack pointer to the same position
		;free space of local variables
		add		rsp,	20h
		;return
		ret

calc ENDP
END