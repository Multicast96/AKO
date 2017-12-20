#include<stdio.h>
#include<Windows.h>

int roznica(int *odejmna, int **odejmnik);
int *kopia_tablicy(int tabl[],unsigned int n);char *komunikat(char * tekst);int *szukaj_elem_min(int tablica[], int n);
int main() {
	printf("**********ZAD1********\n");
	int a = 20, b = 25;
	int **wsk = &b;
	printf("%d - %d = %d\n", a, b, roznica(&a, &wsk));

	printf("**********ZAD2********\n");
	int tab[] = {2,4,1,6,8,3,10,12,5 };
	unsigned int n = sizeof(tab)/sizeof(int);
	int *kopia = kopia_tablicy(tab, n);
	printf("Tab1 Tab2\n");
	for (int i = 0; i < n; i++) printf(" %d    %d\n", tab[i], kopia[i]);
	free(kopia);

	printf("**********ZAD3********\n");
	char *tekst = "Przepelnienie stosu, niestety nie zdajesz. :( \n", *komunikat_tekst = komunikat(tekst);
	printf("%s\n", komunikat_tekst);
	free(komunikat_tekst);

	printf("**********ZAD4********\n");
	int pomiary[] = { -2,4,123,-32414,2335,-423,1253 }, *min = szukaj_elem_min(pomiary, sizeof(pomiary)/sizeof(int));
	printf("Element minimalny = %d\n",*min);

	return 0;
}