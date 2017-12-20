#include<stdio.h>
void przestaw(int tabl[], int n);

int main() {
	int tab[] = {7 ,1, 4, 2, 6, 3, 2};
	int n = 7;
	printf("Przed sortowaniem: ");
	for (int i = 0; i < n; i++) {
		printf("%d ", tab[i]);
	}
	printf("\n");

	for (int i = n; i > 1; i--) {
		przestaw(tab, i);
	}

	printf("Po sortowaniu:     ");
	for (int i = 0; i < n; i++) {
		printf("%d ", tab[i]);
	}
	printf("\n");
	return 0;
}