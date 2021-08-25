# kompilacja: as read_write.s --32 -o read_write.o -g
# laczenie:   ld read_write.o -m elf_i386 -o read_write
SYSEXIT  = 1
SYSREAD  = 3
SYSWRITE = 4
SYSOPEN  = 5
STDIN = 0
STDOUT = 1
EXIT_SUCCESS = 0
SHIFT = 32


.data
msg_echo: .ascii "                                           "
msg_echo_len = . -msg_echo

newline: .ascii "\n"
newline_len = . -newline

.text
.global _start			# wskazanie punktu wejścia do programu
_start:
# czytamy string do msg_echo
movl $SYSREAD, %eax 		# funkcja do wywołania -SYSREAD
movl $STDIN, %ebx 		# 1 arg. -syst. deskryptor stdin
movl $msg_echo, %ecx 		# 2 arg. -adres początkowy napisu
movl $msg_echo_len, %edx 	# 3 arg. -długość łańcucha
int $0x80			# w %eax będzie dlugosc lancucha


#zmiana małych liter na duże

movl $0, %esi 			#wyzerowanie licznika elementów bufora
repet:
cmpl %edx, %esi 		#sprawdzenie czy licznik nie przekroczył liczby elementów
jge koniec
movb (%ecx,%esi, 1), %al	#pobreranie kolejnych elemnetów burofa do rejestru al
movb $0x61, %bl				
cmpb %al, %bl			#sprawdzenie kodu ascii znaku
jg dalej			#jeśli zly to skok do dalej
movb $0x7a, %bl
cmpb %al, %bl			#sprawdzenie kodu ascii znaku
jl dalej			#jeśli zly to skok do dalej
subb $SHIFT, %al		#zmniejszenie kodu ascii o 32(zwiększenie litery)
movb %al, (%ecx,%esi, 1)	#zamisanie zmienionej litery spowrotem do bufora
incl %esi 			#zwiększenie licznika
jmp repet

dalej:
incl %esi 			#zwiększenie licznika
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
movl $SYSEXIT, %eax		# funkcja do wywołania -SYSEXIT
movl $EXIT_SUCCESS, %ebx 	# 1 arg. --kod wyjścia z programu
int $0x80			# wywołanie przerwania programowego - wykonanie funcji systemowej.