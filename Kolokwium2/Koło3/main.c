#include<stdio.h>
#include<limits.h>

unsigned __int64 NWW(unsigned int a, unsigned int b);
double funkcja(double tab[], int n);
int main() {
	unsigned int a = 12345675, b =1234565;
	printf("*********Zad1********\n");
	printf("NWW(%d , %d)=%lu\n", a, b, NWW(a, b));

	printf("*********Zad2********\n");
	double tab[] = { 4.5,4.3,1.234,345.2342563,8.23423 };
	printf("Suma = %.308g\n", funkcja(tab, sizeof(tab) / sizeof(double)));
	return 0;
}
