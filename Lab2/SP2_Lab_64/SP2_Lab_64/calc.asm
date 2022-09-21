.data
const_4		dd 4.0
const_1		dd 1.0
const_31	dd 31.0
temp_res	dd 0.0

.code
calc PROC
 ; переносимо параметр з xmm0, xmm1, xmm2 у стек. Згідно угод для 64-розрядної платформи перші 4
 ; параметри передаються в регістрах, а для дійсних параметрів використовуються регістри
 ; xmm0- xmm3. Результат дійсного типу повертають в регістрі xmm0.
 movsd qword ptr[rsp+8], xmm0
 movss dword ptr[rsp+16], xmm1
 movss dword ptr[rsp+20], xmm2

 push rbp
 mov rbp, rsp

 finit
 fld dword ptr[rbp+24]   ;load c
 fcom dword ptr[rbp+28]  ;c - d
 fstsw ax				 ;save flags in ax
 sahf

 ja _calculate_c_abov_d  ;if c > d goto _calculate_c_abov_d
						 ;else skip this jamp

 fsub dword ptr[rbp + 28]
 fadd const_1
 fstp temp_res

 fld dword ptr[rbp + 28]
 fdiv qword ptr[rbp + 16]
 fadd const_4
 fptan
 fstp const_4
 fadd dword ptr[rbp + 28]
 fdiv dword ptr [temp_res]
 jmp _to_return			 

 _calculate_c_abov_d:

 fmul const_4			
 fsubr qword ptr[rbp+16]
 fsub const_1
 fstp temp_res

 fld dword ptr[rbp+24]
 fdiv const_31
 fstp const_31
 fld qword ptr[rbp+16]
 fmul dword ptr[rbp+28]
 fptan
 fstp const_1
 fadd const_31
 fdivr temp_res

 

_to_return:
 pop rbp

 ;переносимо результат з математичного співпроцесора у xmm0
 fstp qword ptr [rsp+8]
 movsd xmm0, qword ptr [rsp+8]


 ret

calc ENDP
END