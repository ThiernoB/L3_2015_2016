/*
*	@author		Pierre Dibo
* 	@email		rg26.warforce[at]hotmail.fr
*	@date		15 nov. 2015 12:52
*/


#include "treedir.h"

/*
* @from		https://github.com/halcy/Stallman-Box/blob/master/itoa.c
*/
void strreverse(char* begin, char* end)
{
	char aux;
	while (end > begin)

		aux = *end, *end-- = *begin, *begin++ = aux;
}

/*
* @from		https://github.com/halcy/Stallman-Box/blob/master/itoa.c
*/
void itoa_s(int value, char* str, int base)
{
	static char num[] = "0123456789abcdefghijklmnopqrstuvwxyz";
	char* wstr = str;
	int sign;
	div_t res;

	// Validate base
	if (base < 2 || base > 35)
	{
		*wstr = '\0';
		return;
	}

	// Take care of sign
	if ((sign = value) < 0) value = -value;

	// Conversion. Number is reversed.
	do
	{
		res = div(value, base);
		*wstr++ = num[res.rem];
	} while (value = res.quot);

	if (sign < 0) *wstr++ = '-';
	*wstr = '\0';

	// Reverse string
	strreverse(str, wstr - 1);
}

int main(int argc, char **argv)
{
	node *current;

	/*current = new_node("un");

	new_child(current, "deux");
	new_child(current, "trois");
	new_child(current, "quatre");
	new_child(current, "cinq");
	new_child(current, "six");
	new_child(current, "sept");

	print_tree(current);
	delete_tree(current);*/
	
	current = build_from_current_file();
	print_tree(current);
	delete_tree(current);
	
	/*if (argc == 2)
		fill_dir(atoi(argv[1]));*/

	return EXIT_SUCCESS;
}


node *new_node(const char *name)
{
	node *nd;

	if (name == NULL)
	{
		printf("Null pointer exception - new_node()\n");
		return NULL;
	}

	nd = malloc(sizeof(node));
	nd->name = malloc(strlen(name));
	strcpy(nd->name, name);
	nd->nb_children = 0;
	nd->children = NULL;

	return nd;
}

void delete_node(node *nd)
{
	if (nd == NULL)
	{
		printf("Null pointer exception - delete_node()\n");
		return;
	}

	if (nd->children != NULL)
		free(nd->children);

	free(nd->name);
	free(nd);
	nd = NULL;
}


void delete_tree(node *nd)
{
	if (nd == NULL)
	{
		printf("Null pointer exception - delete_node()\n");
		return;
	}

	if (nd->children != NULL)
	{
		delete_tree(nd->children->n);
	}
	delete_node(nd);

}

int new_child(node *current, const char *name)
{
	if (current == NULL || name == NULL)
	{
		printf("Null pointer exception - new_child()\n");
		return -1;
	}

	current->nb_children++;

	if (current->children == NULL)
	{
		current->children = malloc(sizeof(list_node *));
		current->children->n = new_node(name);
		current->children->next = NULL;
	}
	else
	{
		new_child(current->children->n, name);
		current->children->next = current->children->n->children;
	}

	return 0;
}

int print_tree(node *current)
{
	list_node *child;

	if (current == NULL)
	{
		printf("Null pointer exception - print_tree()\n");
		return -1;
	}

	printf("%s\n", current->name);

	if (current->children != NULL)
	{
		child = current->children->next;

		printf("%s:%s\n", current->name, current->children->n->name);

		while (child != NULL)
		{
			printf("%s:%s\n", current->name, child->n->name);
			child = child->next;
		}
	}

	return 0;
}

node *build_from_current_file()
{
	struct stat status;
	struct dirent *entry;
	DIR *rep;
	node *root;

	if ((rep = opendir(DEFAULT_DIRECTORY)) == NULL)
	{
		perror("opendir - build_from_current_file()\n");
		return NULL;
	}

	root = new_node(basename(getcwd(NULL, PATH_LENGHT_MAX)));

	while ((entry = readdir(rep)) != NULL)
	{
		if (entry->d_name[0] == '.')
			continue;

		if (stat(entry->d_name, &status) == -1)
		{
			perror("stat - build_from_current_file\n");
			closedir(rep);
			return root;
		}

		if (new_child(root, entry->d_name) == -1)
		{
			printf("impossible new_child %s - build_from_current_file\n", entry->d_name);
			closedir(rep);
			return root;
		}
	}

	closedir(rep);

	return root;
}

//TODO
int fill_dir(int k)
{
	char buffer[BUFSIZ], tmp[BUFSIZ];
	int i;
	mode_t mode;

	mode = S_IRUSR | S_IWUSR | S_IXUSR | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH;


	if (k == 0 || k == 1)
	{
		//creat("tmp.txt", mode);
		return 0;
	}

	return 0;

}

