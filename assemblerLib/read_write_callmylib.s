.data
msg_echo: .ascii "                                           "
msg_echo_len = . -msg_echo

newline: .ascii "\n"
newline_len = . -newline

msg_hello: .ascii "Wprowadz napis\n"
msg_hello_len = . -msg_hello

file_name: .ascii "wyniki.txt"		#Definicja nazwy tworzonego pliku
									#tworzonego przez funkcję open
.section .text
.global main
main:

leal msg_hello_len, %eax
pushl %eax							#Przesłanie długości bufora na stos 
leal msg_hello, %eax
push %eax							#Przesłanie adresu bufora na stos 
pushl $1							#Przesłanie 1 na stos (ustawinie wyjścia na STDOUT)
call write							#Wywołanie funkcji write

leal msg_echo_len, %eax
pushl %eax							#Przesłanie długości bufora na stos
leal msg_echo, %eax
pushl %eax							#Przesłanie adresu bufora na stos
call read							#Wywołanie funkcji read

leal msg_echo_len, %eax
pushl %eax							#Przesłanie długości bufora na stos
leal msg_echo, %eax
pushl %eax							#Przesłanie adresu bufora na stos
pushl $1							#Przesłanie 1 na stos (ustawinie wyjścia na STDOUT)
call write							#Wywołanie funkcji write

leal newline_len, %eax
pushl %eax							#Przesłanie długości bufora na stos
leal newline, %eax
pushl %eax							#Przesłanie adresu bufora na stos
pushl $1							#Przesłanie 1 na stos (ustawinie wyjścia na STDOUT)
call write							#Wywołanie funkcji write

# Przykładowe urzycie funkcji otawarcia i zamknięcia pliku

pushl $0666						#Przesłanie wartości określającej prawa dostępu na stos
pushl $03101					#Przesłanie wartości określającej flagi na stos
pushl $file_name				#Przesłanie adresu pierwszego symbolu nazwy pliku na stos
call open						#Wywołanie funkcji open

#Zapisanie do wprowadzonego ciągu znaków do pliku 
#o nazwie określonej na początku programu
leal msg_echo_len, %eax
pushl %eax						#Przesłanie długości bufora na stos
leal msg_echo, %eax
pushl %eax						#Przesłanie adresu bufora na stos
pushl %esi						#Przesłanie uchwytu do pliku na stos
call write						#Wywołanie funkcji write

pushl %esi						#Przesłanie uchwytu do pliku na stos
call close						#Wywołanie funkcji close

pushl %edi						#Przesłanie długości wprowadzonego ciągu znaków na stos
call exit						#Wywołanie funkcji exit