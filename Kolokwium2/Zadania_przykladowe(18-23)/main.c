#include<stdio.h>
#include<Windows.h>
#include<float.h>
#include<stdlib.h>
#include<wchar.h>

unsigned int NWD(unsigned int a, unsigned int b);

typedef struct{
	char _float;
	char _int[3];
}MIESZ32;

float miesz2float(MIESZ32 p);

MIESZ32 liczba_miesz32_1 = {0x80,0x3}; //3.5
MIESZ32 liczba_miesz32_2 = {0x80}; //0.5
MIESZ32 liczba_miesz32_3 = {0x20}; //0.125
MIESZ32 liczba_miesz32_4 = {0x0,0x0,0x0,0x80 }; //2 ^ 23
MIESZ32 liczba_miesz32_5 = {0x0,0xFF,0xFF,0xFF }; //2 ^ 24 - 1

unsigned int liczba_procesorow();
float float_razy_float(float a, float b);
unsigned __int64 sortowanie(unsigned __int64 * tabl, unsigned int n);
wchar_t * ASCII_na_UTF16(char * znaki, int n);

int main() {
	printf("**********ZAD18********\n");
	int a = 42, b = 56;
	printf("NWD %d i %d = %d\n", a, b, NWD(a, b));

	printf("**********ZAD19********\n");
	printf("%g\n", miesz2float(liczba_miesz32_1));
	printf("%g\n", miesz2float(liczba_miesz32_2));
	printf("%g\n", miesz2float(liczba_miesz32_3));
	printf("%g\n", miesz2float(liczba_miesz32_4));
	printf("%g\n", miesz2float(liczba_miesz32_5));


	printf("**********ZAD20********\n");
	printf("Liczba procesorow: %d\n", liczba_procesorow());

	printf("**********ZAD21********\n");
	float l1 = FLT_MAX;
	float l2 = 1;
	printf("%g*%g=%.38g C\n", l1, l2, l1*l2);
	printf("%g*%g=%.38g ASM\n", l1, l2, float_razy_float(l1, l2));

	printf("**********ZAD22********\n");
	unsigned __int64 tab[] = { MAXULONGLONG-1,MAXULONGLONG-2, MAXULONGLONG,21,13,MAXULONGLONG / 2, MAXULONGLONG /4,MAXULONGLONG /8};
	for (int i = 0; i < sizeof(tab) / sizeof(__int64); i++) printf("%I64u ", tab[i]);
	printf("\n");
	unsigned __int64 max = sortowanie(tab, sizeof(tab) / sizeof(__int64));
	for (int i = 0; i < sizeof(tab) / sizeof(__int64); i++) printf("%I64u ", tab[i]);
	printf("\nMaksymalny element: %I64u\n",max);

	printf("**********ZAD23********\n");
	char tekst[] = "If debugging is the process of removing software bugs, then programming must be the process of putting them in. (Edsger Dijkstra)";
	printf("%s\n", tekst);
	wchar_t *tekst2 = ASCII_na_UTF16(tekst, sizeof(tekst));
	wprintf(L"%s\n", tekst2);
	return 0;
}