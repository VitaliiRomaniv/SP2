.686
.model flat, c

printf proto c : vararg
EXTERN K : DWORD

.data
msg db 'Output from asm module is:   %d', 0

.code
calc PROC
;Save the previous base pointer (ebp) 
;and set EBP to point at that position on 
;the stack (right below the return address).  
push	ebp 
mov		ebp, esp

;Enter the first operand from the function parameters
mov		ax, word ptr [ebp + 8]

;Extend ax to eax
cwde

;Save data from eax to ebx
mov		ebx, eax

;Enter the second operand from the function parameters
mov		al, byte ptr [ebp + 12]

;firstly extend al to ax then ax to eax
cbw
cwde

;Perform the subtraction operation
;(B - C)
sub		ebx, eax
mov		eax, ebx

;Perform the mult
;4*(B-C)
shl		eax, 2

;Save result to stack
push	eax

;Reset the eax register
xor		eax, eax

;Enter the third operand from the function parametrs
mov		ax, word ptr [ebp + 16]

;Save result of data from eax plus 3 in edx register
lea		edx, [eax + 3]

;check if the third operand is negative
test	ax, ax
js		next_position
;if not just perform D/4 then go to another operations
sar		ax, 2
jmp		end_point

;if this is a negative operand 
;move to eax data from edx register 52line on code
;and then D/4 
next_position:
mov		eax, edx
sar		ax, 2
cwde


end_point:
;Save result in edx resister (D/4 result)
mov		edx, eax

;Take data from stack to eax register
pop		eax

;Perform 4 * (B - C)+ D/4
;and then perform 4 * (B - C)+ D/4 + K
add		eax, edx
add		eax, K

;Take previous base pointer (ebp)
pop		ebp

;Save the eax data to the stack
push	eax

;Print massage to the screen
invoke printf, offset msg, eax

;Take the data from the stack and return it
pop		eax
ret

calc ENDP

END