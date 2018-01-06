#include<stdio.h>
#include<stdlib.h>

double c(int x) {
	if (x == 1) return 5;
	else if (x == 2) return 6;
	else return (3 - c(x - 1)) / x;
}

float *testXYZ2R(float *tabCIEXYZ, int n) {
	float *wsk = malloc(n * sizeof(float));
	for (int i = 0; i < n; i++) {
		wsk[i] = 3.063*tabCIEXYZ[i*3] - 1.393*tabCIEXYZ[i*3+1] - 0.476*tabCIEXYZ[i*3+2];
	}
	return wsk;
}

float *XYZ2R(float *tabCIEXYZ, int n);
double ciag(int *x);
float dziel16(float a);

int main() {
	printf("***********Zad1***********\n");
	float a = 23423.234234;
	printf("%f/16=%.308g\n", a, dziel16(a));
	printf("***********Zad2***********\n");
	int x = 123;
	printf("Dla x = %d wynik ciagu to %.308g\n", x, c(x));
	printf("Dla x = %d wynik ciagu to %.308g\n", x, ciag(&x));
	printf("***********Zad3***********\n");

	float tab[] = { 646,435,23 ,765,234.435,235.645,756.234,56.234,654.234254 };
	int n = sizeof(tab) / sizeof(float) / 3;
	float *wsk = testXYZ2R(tab, n);
	float *wsk2 = XYZ2R(tab, n);
	for (int i = 0; i < n; i++) printf("%.10f ", wsk[i]);
	printf("\n");
	for (int i = 0; i < n; i++) printf("%.10f ", wsk2[i]);
	printf("\n");
	free(wsk);
	free(wsk2);
	return 0;
}