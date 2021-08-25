.data
SYSEXIT  = 1
SYSREAD  = 3
SYSWRITE = 4
OPEN  = 5
CLOSE = 6
STDIN = 0
STDOUT = 1
EXIT_SUCCESS = 0
READ_ONLY = 0


.text
.global write
.type write, @function
write:
push %ebp
movl  %esp, %ebp
mov $SYSWRITE, %eax
movl  8(%ebp), %ebx		#uchwyt pliku
movl  12(%ebp), %ecx 	#adres bufora
movl  16(%ebp), %edx	#długość ciągu
int $0x80
movl %ebp, %esp
popl %ebp
movl %edx, %eax
ret

.global read
.type read, @function
read:
pushl %ebp
movl  %esp, %ebp
mov $SYSREAD, %eax
mov $STDIN, %ebx
movl  8(%ebp), %ecx
movl  12(%ebp), %edx
int $0x80
movl %ebp, %esp
popl %ebp
ret

.global exit1
.type exit1, @function
exit1:
pushl %ebp
movl  %esp, %ebp
movl  8(%ebp), %ebx
movl  $1, %eax
int   $0x80
movl %ebp, %esp
popl %ebp
ret


.global open
.type open, @function
open:
push %ebp
movl %esp, %ebp
movl $OPEN, %eax
movl 8(%ebp), %ebx
movl 12(%ebp), %ecx
movl 16(%ebp), %edx
int $0x80
movl %eax, %esi
movl %ebp, %esp
popl %ebp
ret


.global close
.type open, @function
close:
push %ebp
movl %esp, %ebp
movl $CLOSE, %eax
movl 8(%ebp), %ebx
int $0x80
movl %ebp, %esp
popl %ebp
ret