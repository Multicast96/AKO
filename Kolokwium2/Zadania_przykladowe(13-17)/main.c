#include<stdio.h>
#include<float.h>

float iloraz();
double float_to_double(float a);
float pole_kola(float *pr);
double plus_jeden(double x);
float avg_wd(int n, void *tablica, void *wagi);

int main() {
	printf("**********ZAD13********\n");
	printf("x/y=%f\n", iloraz());

	printf("**********ZAD14********\n");
	float a = FLT_MIN;
	double b = DBL_MIN;
	printf("MIN float:%e\nMIN double:%e \n", a,b);
	double c = float_to_double(FLT_MIN);
	printf("%e = %e\n", FLT_MIN, c);

	printf("**********ZAD15********\n");
	float pr = 3.4231;
	printf("Pole kola o promieniu %f wynosi %f\n",pr, pole_kola(&pr));
	
	printf("**********ZAD16********\n");
	double liczba2 = 9007199254740991;
	double liczba1 = 1.0000000000000002220446049250313080847263336181640625;
	printf("%.308g + 1 = %.308g C\n", liczba1,liczba1+1.0f);
	printf("%.308g + 1 = %.308g ASM\n", liczba1, plus_jeden(liczba1));

	printf("%.308g + 1 = %.308g C\n", liczba2, liczba2 + 1.0f);
	printf("%.308g + 1 = %.308g ASM\n", liczba2, plus_jeden(liczba2));
	//wyk³adnik z przedzialu <1023, 1075> 
	//najmniejsza liczba o wykladniku 1023(0): 1.0000000000000002220446049250313080847263336181640625
	//najwieksza liczba o wykladniku 1075(52): 9007199254740991

	printf("**********ZAD17********\n");
	float tablica[] = { 1.2,42.231,4231.64,2342.6543 };
	float wagi[] = { 432.53,98.3452,12.756,1043.12 };
	printf("Srednia wazona: %.308g\n",avg_wd(sizeof(tablica)/sizeof(float),tablica,wagi));
	
	return 0;
}