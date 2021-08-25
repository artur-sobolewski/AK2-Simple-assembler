SYSEXIT  = 1
SYSREAD  = 3
SYSWRITE = 4
SYSOPEN  = 5
SYSCLOSE = 6
STDIN = 0
STDOUT = 1
EXIT_SUCCESS = 0

.data
newline: .ascii "\n"
newline_len = . - newline
threeBytes: .ascii "   "
.lcomm oneByte, 1

.text
.global _start
_start:

mov $threeBytes, %edi

loop:
movl $SYSREAD, %eax 		# funkcja do wywołania -SYSREAD
movl $STDIN, %ebx 			# 1 arg. -syst. deskryptor stdin
movl $oneByte, %ecx 		# 2 arg. -adres początkowy napisu
movl $1, %edx 				# 3 arg. -długość łańcucha
int $0x80	

cmp $0, %eax				# sprawdzenie czy pobrano jakis znak
je koniec

movb oneByte, %al			# pobranie kodu ascii znaku do rejestru %al
mov %al, %bl				# w rejestrze %bl mloszcze 4 bity
shr $4, %al					# w rejestrze %al starsze 4 bity
cmp $10, %al				# sprawdzenie czy > 9
jl znakS1
jmp znakS2


mlodsze:
and $0x0F, %bl				# maskowanie starszych 4 bitów
cmp $10, %bl				# sprawdzenie czy > 9
jl znakN1
jmp znakN2

znakS1:
add $48, %al
jmp mlodsze

znakS2:
add $55, %al
jmp mlodsze

znakN1:
add $48, %bl
jmp dalej

znakN2:
add $55, %bl
jmp dalej

# drukowanie kodów heksadecymalnych
dalej:
movb %al, 0(%edi)
movb %bl, 1(%edi)
movl $SYSWRITE, %eax
movl $STDOUT, %ebx
movl $threeBytes, %ecx
movl $3, %edx
int $0x80
jmp loop

koniec:
movl $SYSWRITE, %eax
movl $STDOUT, %ebx
movl $newline, %ecx
movl $newline_len, %edx
int $0x80

movl $SYSEXIT, %eax
movl $EXIT_SUCCESS, %ebx
int $0x80
