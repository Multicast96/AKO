#include<stdio.h>

unsigned int zamien_na_binarny(wchar_t *znaki);
float szereg(unsigned int n);
int main() {
	printf("*******Zad1*******\n");
	wchar_t *znaki = L"123";
	wprintf(L"%s (12) = %d (10)\n",znaki,zamien_na_binarny(znaki));

	printf("*******Zad2*******\n");
	int n = 20;
	printf("Suma szeregu dla n=%d to %.38g\n", n, szereg(n));
	return 0;
}