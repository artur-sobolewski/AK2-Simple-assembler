#include <stdio.h> 
/* prototype for asm function */ 
int dodaj(int x,int y);
int exit(int result);

int main() { 
int arg1, arg2, wynik;
printf("Podaj a i b\n");
scanf("%i %i", &arg1, &arg2);
printf("Podano a = %i i b = %i\n", arg1, arg2);
/* call the asm function */
wynik = dodaj(arg1, arg2);
printf("wynik %d\n", wynik);
exit(wynik);
return 0; 
} 