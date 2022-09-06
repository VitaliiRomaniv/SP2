.686
.model flat, c

printf proto c : vararg
EXTERN K : DWORD

.data
msg db 'Output from asm module is:   %d', 0

.code
calc PROC

		push	ebp
		mov		ebp, esp


		; b - c
		mov		ax, word ptr [ebp + 8]
		cwde
		mov		ebx, eax
		mov		al, byte ptr [ebp + 12]
		cbw
		cwde
		sub		ebx, eax
		mov		eax, ebx
		
		shl		eax, 2
		push	eax

		;xor		eax, eax
		;mov		ax, word ptr [ebp + 16]
		;sar		ax, 2
		;cwde
		;
		;cmp		eax, 0
		;jl		go
		;jmp		next_to
		;
		;go:
		;mov		edx, eax
		;
		;test	eax, 1
		;jz		divisible
		;jmp		next_to
		;
		;divisible:
		;mov		eax, edx
		;add		eax, 1
		;
		;
		;next_to:

;		xor		eax, eax
;		mov		ax, word ptr [ebp + 16]
;		xor		dx, dx
;		mov		bx, 2
;		div		bx
;		cmp		dx, 0
;		jg		divisible
;
;to_calcl:
;		mov		ax, word ptr [ebp + 16]
;		sar		ax, 2
;		cwde
;		jmp		end_end
;
;
;divisible:
;		mov		ax, word ptr [ebp + 16]
;		mov		edx, 0
;		cmp		edx, eax
;		jl		go_calcl
;		jmp		to_calcl
;
;
;go_calcl:
;		xor		eax, eax
;		mov		ax, word ptr [ebp + 16]
;		sar		ax, 2
;		cwde
;		add		eax, 1
;
;
;
;end_end:

		xor		eax, eax
		;movl	8(%ebp), %eax
		mov		ax, word ptr [ebp + 16]
		;movw	%ax, -20(%ebp)
		;movzwl	-20(%ebp), %eax
		;leal	3(%eax), %edx
		lea		edx, [eax + 3]
		;testw	%ax, %ax
		test	ax, ax
		js		next_position
		sar		ax, 2
		jmp		end_point
		cwde
		next_position:
		mov		eax, edx
		sar		ax, 2
		cwde
		;cmovs	%edx, %eax
		;sarw	$2, %ax
		;movw	%ax, -2(%ebp)
		;movswl	-2(%ebp), %eax

		end_point:
		mov		edx, eax
		pop		eax

		add		eax, edx
		add		eax, K

		pop		ebp
		push	eax

invoke printf, offset msg, eax

		pop		eax
		ret
calc ENDP

END