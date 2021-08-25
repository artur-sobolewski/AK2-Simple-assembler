SYSEXIT  = 1
SYSREAD  = 3
SYSWRITE = 4
SYSOPEN  = 5
STDIN = 0
STDOUT = 1
EXIT_SUCCESS = 0

.data
msg_echo: .ascii "                                           "
msg_echo_len = . -msg_echo

newline: .ascii "\n"
newline_len = . -newline

msg_hello: .ascii "Wprowadz napis\n"
msg_hello_len = . -msg_hello


.section .text
.globl _start
_start:

leal msg_hello_len, %eax
pushl %eax
leal msg_hello, %eax
pushl %eax
call write

leal msg_echo_len, %eax
pushl %eax
leal msg_echo, %eax
pushl %eax
call read

leal msg_echo_len, %eax
pushl %eax
leal msg_echo, %eax
pushl %eax
call write

leal newline_len, %eax
pushl %eax
leal newline, %eax
pushl %eax
call write

pushl %eax
call exit

.type write, @function
write:
pushl %ebp
movl  %esp, %ebp
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
movl  8(%ebp), %ecx
movl  12(%ebp), %edx
int $0x80
movl %ebp, %esp
popl %ebp
movl %edx, %eax
ret

.type read, @function
read:
pushl %ebp
movl  %esp, %ebp
mov $SYSREAD, %eax
mov $STDIN, %ebx
movl  8(%ebp), %ecx
movl  12(%ebp), %edx
int $0x80

movl %edx, %eax
movl %ebp, %esp
popl %ebp
ret

.type exit, @function
exit:
pushl %ebp
movl  %esp, %ebp
movl  8(%ebp), %ebx
movl  $SYSEXIT, %eax
int   $0x80
movl %ebp, %esp
popl %ebp
ret
