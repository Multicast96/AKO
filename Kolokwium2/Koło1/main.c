//zadania zrobione w trybie 64 bitowym
#include<stdio.h>
#include<limits.h>
extern unsigned int NWD(unsigned int a, unsigned int b);
extern float ob_stozka_sc(float r, float R, float h);
extern void sort_int(unsigned __int64 *tab,unsigned __int64 n);
int main() {
	printf("*********ZAD1*********\n");
	unsigned int a = 56, b = 42;
	printf("NWD(%d,%d)=%d\n", a, b, NWD(a, b));

	printf("*********ZAD2*********\n");
	float r = 3.4, R = 1.56, h = 86.3;
	printf("V stozka o r=%f R=%f i h=%f wynosi V=%f\n", r, R, h, ob_stozka_sc(r, R, h));
	//wolfram alpha mówi 1743.98

	printf("ZAD3 = -2.0\n");
	printf("QSort x64\n");

	unsigned __int64 tab[] = { ULLONG_MAX , 354,21323,345,1,4235,2,424,1121,4234211,12132 ,UINT_MAX};
	unsigned __int64 n = sizeof(tab) / sizeof(unsigned __int64);
	for (int i = 0; i < n; i++)printf("%llu ", tab[i]);
	printf("\n");
	sort_int(tab, n);
	for(int i = 0; i < n; i++)printf("%llu ", tab[i]);
	printf("\n");

	return 0;
}