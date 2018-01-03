#include<stdio.h>

typedef unsigned short half;

float half_to_float(half a);
half float_to_half(float a);

int main() {
	printf("*******Half to float********\n");
	half half_min = 0x8401;
	half half_max = 0x7BFF;
	printf("half_min=%e\nhalf_max=%f\n", half_to_float(half_min), half_to_float(half_max));

	printf("*******Float to half********\n");
	float f1 = 1.2345;
	printf("float1=%f\nhalf1=%f\n", f1, half_to_float(float_to_half(f1)));
	return 0;
}