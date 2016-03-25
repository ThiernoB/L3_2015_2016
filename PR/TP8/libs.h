#ifndef LIBS_INCLUDED_H
#define LIBS_INCLUDED_H

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <pthread.h>
#include <errno.h>
#include <unistd.h>
#include <inttypes.h>

#include <sys/types.h>
#include <sys/socket.h>

#include <netinet/in.h>
#include <arpa/inet.h>

#define SERVEUR_ARGUMENT	"./serveur <port>"
#define CLIENT_ARGUMENT		"./client <ip_adress> <port>"

#define SUCCESS 	0
#define FAILURE    -1

#define FLAG_SOCK 	0
#define FLAG_RECV 	0
#define FLAG_SEND 	0

#define SIZE_MSG_1 	4
#define SIZE_MSG_2 	3
#endif

