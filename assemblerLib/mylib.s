#Definicje sta³ych urzytych w programie
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
.type write, @function		#Definicja funkcji wypisuj¹cej znaki
write:
push %ebp
movl  %esp, %ebp
mov $SYSWRITE, %eax			#Ustawienie wartoœci %eax na 4 (wywo³anie wypisywania)
movl  8(%ebp), %ebx			#Pobranie drugiego parametru (uchwyt pliku)
movl  12(%ebp), %ecx		#Pobranie trzeciego parametru (adres bufora)
movl  16(%ebp), %edx		#Pobranie czwartego parametru (d³ugoœæ bufora)
int $0x80					#Wywo³anie funkcji systemowej
movl %ebp, %esp
popl %ebp
ret

.global read
.type read, @function		#Definicja funkcji wczytuj¹cej znaki z konsoli
read:
pushl %ebp
movl  %esp, %ebp
mov $SYSREAD, %eax			#Ustawienie pierwszego parametru (wywo³anie wczytywania)
mov $STDIN, %ebx			#Ustawienie drugiego parametru (standardowe wejœcie-konsola)
movl  8(%ebp), %ecx			#Pobranie trzeciego parametru (uchwyt pliku)
movl  12(%ebp), %edx		#Pobranie czwartego parametru (d³ugoœæ bufora)
int $0x80					#Wywo³anie funkcji systemowej
movl %eax, %edi				#Przes³anie d³ugoœci wczytanego ci¹gu do %edi
sbbl $1, %edi				#Pomnijszenie liczby o wczytany znak \n
movl %ebp, %esp
popl %ebp
ret

.global exit
.type exit, @function		#Definicja funkcji koñcz¹cej dzia³anie programu
exit:
pushl %ebp
movl  %esp, %ebp
movl  $1, %eax				#Ustawienie pierwszego parametru (wywo³anie zakoñczenia prog.)
movl  8(%ebp), %ebx			#Pobranie drugiego argumanetu (wartoœæ zwracana)
int   $0x80					#Wywo³anie funkcji systemowej
movl %ebp, %esp
popl %ebp
ret

#---------------------------------------------------------
#  Zadanie 12.10.5 
#---------------------------------------------------------

.global open
.type open, @function		#Definicja funkcji otwieraj¹cej plik
open:
push %ebp
movl %esp, %ebp
movl $OPEN, %eax			#Ustawienie pierwszego parametru (wywo³anie funkc. open)
movl 8(%ebp), %ebx			#Pobranie drugiego parametru (nazwa pliku)
movl 12(%ebp), %ecx			#Pobranie trzeciego parametru (flagi)
movl 16(%ebp), %edx			#Pobranie czwartego parametru (prawa dostêpu)
int $0x80					#Wywo³anie funkcji systemowej
movl %eax, %esi				#Zapisanie uchwytu do pliku w %esi
movl %ebp, %esp
popl %ebp
ret


.global close
.type open, @function		#Definicja funkcji zamykaj¹cej plik
close:
push %ebp
movl %esp, %ebp
movl $CLOSE, %eax			#Ustawienie pierwszego parametru (wywo³anie funkc. close)
movl 8(%ebp), %ebx			#Pobranie drugiego parametru (uchwyt do pliku)
int $0x80					#Wywo³anie funkcji systemowej
movl %ebp, %esp
popl %ebp
ret