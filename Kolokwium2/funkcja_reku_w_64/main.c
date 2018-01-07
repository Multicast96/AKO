#include<stdio.h>

float funkcja_64(__int64 n) {
	if (n == 1)return 1;
	else if (n == 2) return 2;
	else return (1.2 - funkcja_64(n - 1)) / n;
}

extern float funkcja(__int64 n,int a,int b,int c,int d);
int main() {
	__int64 n = 10;
	printf("Dla n=%ld funkcja = %f\n", n, funkcja_64(n));
	printf("Dla n=%ld funkcja = %f\n", n, funkcja(n,0,0,0,1));
}