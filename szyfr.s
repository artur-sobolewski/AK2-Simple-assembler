SYSEXIT  = 1
SYSREAD  = 3
SYSWRITE = 4
SYSOPEN  = 5
STDIN = 0
STDOUT = 1
EXIT_SUCCESS = 0
KEY = 1

.data
msg_echo: .ascii "                                             "
msg_echo_len = . -msg_echo

newline: .ascii "\n"
newline_len = . -newline

.text
.global _start
_start:

movl $SYSREAD, %eax # funkcja do wywołania -SYSREAD
movl $STDIN, %ebx # 1 arg. -syst. deskryptor stdin
movl $msg_echo, %ecx # 2 arg. -adres początkowy napisu
movl $msg_echo_len, %edx # 3 arg. -długość łańcucha
int $0x80

movl $0, %edi 				#wyzerowanie licznika elementów bufora
repet:
cmpl %edx, %edi 			#sprawdzenie czy licznik nie przekroczył liczby elementów
je koniec
movb (%ecx, %edi, 1), %al
movb $0x7a, %bl				#sprawdzenie, czy znak jest ostatnią literą
cmpb %al, %bl
je zetm
movb $0x5a, %bl				#sprawdzenie, czy znak jest ostatnią literą
cmpb %al, %bl
je zetd
movb $0x41, %bl				#sprawdzenie zakresu liter
cmpb %al, %bl
jg skip
movb $0x7A, %bl				#sprawdzenie zakresu liter
cmpb %al, %bl
jl skip
addb $KEY, %al				#zmiana znaku z przesunieciem KEY
movb %al, (%ecx, %edi, 1)	#zapisanie zmienionego elem. do bufora
incl %edi					#zwiekszenie licznika
jmp repet

zetm:
movb $0x61, (%ecx, %edi, 1)	#Zastąpienie literą 'a'
incl %edi
jmp repet

zetd:
movb $0x41, (%ecx, %edi, 1)	#Zastąpienie literą 'A'
incl %edi
jmp repet

skip:
incl %edi
jmp repet

koniec:

# wypisujemy na STDOUT msg_echo
movl $SYSWRITE, %eax 
movl $STDOUT, %ebx 
movl $msg_echo, %ecx 		# 2 arg. -adres początkowy napisu
movl $msg_echo_len, %edx 	# 3 arg. -długość łańcucha
int $0x80					
# wypisujemy na STDOUT znak \n
movl $SYSWRITE, %eax 
movl $STDOUT, %ebx 
movl $newline, %ecx 		# 2 arg. -adres początkowy napisu
movl $newline_len, %edx 	# 3 arg. -długość łańcucha
int $0x80				
# zakonczenie programu
movl $SYSEXIT, %eax			# funkcja do wywołania -SYSEXIT
movl $EXIT_SUCCESS, %ebx 	# 1 arg. --kod wyjścia z programu
int $0x80					# wywołanie przerwania programowego - wykonanie funcji systemowej.