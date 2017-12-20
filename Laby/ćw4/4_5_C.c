/* Poszukiwanie najwiêkszego elementu w tablicy liczb
ca³kowitych za pomoca funkcji (podprogramu)
szukaj64_max, ktora zostala zakodowana w asemblerze.
Wersja 64-bitowa
*/
#include <stdio.h>
extern __int64 suma_siedmiu_liczb(__int64 v1, __int64 v2, __int64 v3, __int64 v4, __int64 v5, __int64 v6, __int64 v7);
int main()
{
	//__int64 liczby[7] =
	//{ -19000444, 31, 456000000000000, 444444444444444, -123456789098765, 1 , 2 };
	__int64 liczby[7] =
	{ 1,1,1,1,1,1,2 };
	__int64 suma = suma_siedmiu_liczb(liczby[0] , liczby[1] , liczby[2] , liczby[3] , liczby[4], liczby[5], liczby[6]);
	printf("\nSuma siedmiu wynosi %I64d\n", suma);
	return 0;
}