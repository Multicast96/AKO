#include<stdio.h>

unsigned char iteracja(unsigned char a);
int main() {
	printf("**********ZAD6********\n");
	unsigned int a = 16;
	printf("%d^2=%u\n", a, kwadrat(a));

	printf("**********ZAD7********\n");
	printf("iteracja(32)=%d\n",iteracja(32));

	printf("**********ZAD8********\n");
	zad8();

	printf("**********ZAD9********\n");
	zad9();

	printf("**********ZAD10********\n");
	zad10();

	printf("**********ZAD11_12********\n");
	zad11_12();
	return 0;
}