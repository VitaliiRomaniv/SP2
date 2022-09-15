.686
.model flat, c

.data
const_4		dd 4.0
const_1		dd 1.0
const_31	dd 31.0
temp_res	dd 0.0

.code
calc PROC

 push ebp
 mov ebp, esp

 finit
 fld dword ptr[ebp+16]   ;load c
 fcom dword ptr[ebp+20]  ;c - d
 fstsw ax				
 sahf
 ja _calculate_c_abov_d  ;if c > d goto _calculate_c_abov_d
						 ;else skip this jamp

 fld dword ptr[ebp + 20]
 fsub
 fadd const_1
 fst temp_res
 fld qword ptr[ebp + 8]
 fld dword ptr[ebp + 20]
 fdiv
 fadd const_4
 fptan
 fld dword ptr[ebp + 20]
 fadd ST, ST(2)
 fld temp_res
 fdiv

 jmp _to_return
 _calculate_c_abov_d:
 fmul const_4
 fld  qword ptr[ebp + 8]
 fsub ST, ST(1)
 fsub const_1
 fst temp_res
 fld qword ptr[ebp + 8]
 fld dword ptr[ebp + 20]
 fmul
 fptan

 fld dword ptr[ebp + 16]
 fdiv const_31
 fadd ST, ST(2)

 fld temp_res
 fdivr

_to_return:
 pop ebp
 ret

calc ENDP
END
