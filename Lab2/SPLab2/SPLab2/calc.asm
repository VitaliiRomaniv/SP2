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
 fstsw ax				 ;save flags in ax
 sahf

 ja _calculate_c_abov_d  ;if c > d goto _calculate_c_abov_d
						 ;else skip this jamp

 fsub dword ptr[ebp + 20] ;c - d result save to ST(0)
 fadd const_1			  ;c - d + 1 save to ST(0)
 fstp temp_res			  ;save temp result and pop out
						  ;ST(0)

 fld dword ptr[ebp + 20]  ;load d 
 fdiv qword ptr[ebp + 8]  ;d/a save to ST(0)
 fadd const_4			  ;d/a + 4 save to ST(0)
 fptan					  ;tan(d/a+4) save to ST(1)
 fstp const_4			  ;pop up 1  from ST(0)
 fadd dword ptr[ebp + 20] ;tan(d/a+4)+d save to ST(0)
 fdiv dword ptr [temp_res];(tan(d/a+4)+d)/(c - d + 1)
 jmp _to_return			  ;go to return result

 _calculate_c_abov_d:

 fmul const_4			 ;c*4 save to ST(0)
 fsubr qword ptr[ebp+8]	 ;a-(c*4) save to ST(0)
 fsub const_1			 ;a-(c*4)-1
 fstp temp_res			 ;save temp result and pop out
						 ;ST(0)
 fld dword ptr[ebp+16]	 ;load c
 fdiv const_31			 ;c/31 save to ST(0)
 fstp const_31			 ;save result and pop out ST(0)
 fld qword ptr[ebp+8]	 ;load a to ST(0)
 fmul dword ptr[ebp+20]  ;a*d
 fptan					 ;tan(a*d)
 fstp const_1			 ;POP OUT ST(0)
 fadd const_31			 ;tan(a*d)+c/31
 fdivr temp_res			 ;(a-(c*4)-1)/(tan(a*d)+c/31)

_to_return:
 pop ebp
 ret

calc ENDP
END
