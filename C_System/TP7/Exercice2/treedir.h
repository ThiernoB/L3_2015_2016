/*
*	@author		Pierre Dibo
* 	@email		rg26.warforce[at]hotmail.fr
*	@date		15 nov. 2015 12:52
*/

#ifndef TREEDIR_INCLUDED_H
#define TREEDIR_INCLUDED_H

#include <libgen.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>

#define DEFAULT_DIRECTORY "."
#define PATH_LENGHT_MAX 1024

typedef struct _node node;
typedef struct _list_node list_node;

struct _node {
	char *name;
	int nb_children;
	list_node *children;
};

struct _list_node {
	node *n;
	list_node *next;
};


node *new_node(const char *name);

void delete_node(node *nd);

void delete_tree(node *nd);

int new_child(node *current, const char *name);

int print_tree(node *current);

node *build_from_current_file();

int fill_dir(int k);

#endif