#include<stdio.h>
#include<float.h>

int find(double tab[], double x, int min, int max);
void ShowDate();

int main() {
	printf("**********Zad1***********\n");
	double x = 1.14235;
	double tab[] = { 1.14235,3.42,6.2315,56456,FLT_MAX };
	for (int i = 0; i < sizeof(tab) / sizeof(double); i++) printf("%lf ", tab[i]);
	printf("\nElement %lf jest na pozycji %d\n", x, find(tab, x, 0, (sizeof(tab) / sizeof(double)) - 1));

	printf("**********Zad2***********\n");
	ShowDate();

	return 0;
}