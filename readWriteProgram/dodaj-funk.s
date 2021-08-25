.global dodaj
.type dodaj, @function
dodaj:
pushl %ebp
movl  %esp, %ebp
movl  8(%ebp), %eax
movl  12(%ebp), %ecx
addl  %ecx, %eax 
# wynik w %eax
movl %ebp, %esp
popl %ebp
ret

.global exit
.type exit, @function
exit:
pushl %ebp
movl  %esp, %ebp
movl  8(%ebp), %ebx     
movl  $1, %eax   
int   $0x80
ret