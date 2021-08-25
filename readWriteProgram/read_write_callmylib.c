#include <stdio.h>
#include <string.h>
#define STDOUT 1								//Deklaracja sta�ej opisuj�cej
												//standardowe wyj�cie
void write(int out, char * mes, int size);		//Prototyp funkcji write
int read(char * mes, int size);					//Prototyp funkcji read
int exit1(int size);							//Prototyp funkcji exit

int main()
{
	//Deklaracja otwieraj�cego program napisu
	char open_message[] = "Podaj napis:\n";
	//Deklaracja bufora wczytywanego napisu o d�ugo�ci 80 znak�w
	char read_message[80];
	int open_size, read_size, bufor_size;
	//Wylicznie d�ugo�ci otwieraj�cego napisu
	open_size = strlen(open_message);
	//Wywo�anie funkcji wypisuj��cej napis
	write(STDOUT, open_message, open_size);
	//Wywo�anie funkcji wczytuj�cej napis i zwracaj�cej jego d�ugo��
	read_size = read(read_message, 80);
	//Wywo�anie funkcji wypisuj�cej napis
	write(STDOUT, read_message, read_size);
	//Pomniejszenie d�ugo�ci wczytanego napisu o wczytany znak nowej linii
	read_size = read_size - 1;
	//Wywo�anie funkcji zamykaj�cej program i zwracaj�cej d�ugo�� wczytanego napisu
	exit1(read_size);
	return 0;
}