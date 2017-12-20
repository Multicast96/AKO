#include<stdio.h>
void przyklad();
float srednia_harmoniczna(float * tablica, unsigned int n);
float nowy_exp(float x);

int main() {
	/*Zad 5.1*/
	float tab[] = { 1,2,4 };
	unsigned int n = 3;
	float srednia = srednia_harmoniczna(tab, n);
	printf("%f\n*****************\n", srednia);

	float suma = nowy_exp(4.32);
	printf("%f\n*****************\n", suma);

	//przyklad();
	return 0;
}