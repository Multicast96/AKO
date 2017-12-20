#include<stdio.h>
void liczba_przeciwna(int *a);

int main() {
	int a;
	printf("\nProsze podac liczbe calkowita: ");
	scanf_s("%d", &a);
	int b = a;
	liczba_przeciwna(&b);
	printf("\nLiczba przeciwna do %d to %d.\n", a , b);
}