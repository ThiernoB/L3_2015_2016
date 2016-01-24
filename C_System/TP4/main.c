/*
*	@author		Pierre Dibo
* 	@email		rg26.warforce[at]hotmail.fr
*	@date 		09 ‎nov. ‎2015 at ‏‎21:46:55
*/

#include "dictionnaire.h"

dictionnaire_t *dico = NULL;
/*
{ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q','r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' }
char *key[] = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" }; */
int main(void)
{
	char *test[ALPHABET_LENGTH][BUFSIZE];

	test[0][0] = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
	//test[6][6] = "Plein de blabla 2";

	//printf("%d\n", sizeof("Plein de blabla 2"));

	dico = malloc(sizeof(dictionnaire_t));
	
	//Dictionnaire_init(dico);

	printf("%s\n", test[6][6]);

	//printf("%s\n", test[6][6]);

	free(dico);

	return EXIT_SUCCESS;
}