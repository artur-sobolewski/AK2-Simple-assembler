#include <stdio.h>
#include <string.h>
#define STDOUT 1								//Deklaracja sta³ej opisuj¹cej
												//standardowe wyjœcie
void write(int out, char * mes, int size);		//Prototyp funkcji write
int read(char * mes, int size);					//Prototyp funkcji read
int exit1(int size);							//Prototyp funkcji exit

int main()
{
	//Deklaracja otwieraj¹cego program napisu
	char open_message[] = "Podaj napis:\n";
	//Deklaracja bufora wczytywanego napisu o d³ugoœci 80 znaków
	char read_message[80];
	int open_size, read_size, bufor_size;
	//Wylicznie d³ugoœci otwieraj¹cego napisu
	open_size = strlen(open_message);
	//Wywo³anie funkcji wypisuj¹…cej napis
	write(STDOUT, open_message, open_size);
	//Wywo³anie funkcji wczytuj¹cej napis i zwracaj¹cej jego d³ugoœæ
	read_size = read(read_message, 80);
	//Wywo³anie funkcji wypisuj¹cej napis
	write(STDOUT, read_message, read_size);
	//Pomniejszenie d³ugoœci wczytanego napisu o wczytany znak nowej linii
	read_size = read_size - 1;
	//Wywo³anie funkcji zamykaj¹cej program i zwracaj¹cej d³ugoœæ wczytanego napisu
	exit1(read_size);
	return 0;
}