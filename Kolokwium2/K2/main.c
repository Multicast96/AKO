#include<stdio.h>

typedef unsigned short half;

float half_to_float(half a);

int main() {
	printf("*******ZAD1********\n");
	half half_min = 0x8401;
	half half_max = 0x7BFF;
	printf("half_min=%e\nhalf_max=%f\n", half_to_float(half_min), half_to_float(half_max));
	return 0;
}