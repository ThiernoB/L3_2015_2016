#include "tuteur.h"

//PRId32,CNd8, SCNd16, SCNd32 and SCNd64 -- %" SCNd32 "\n"

void * tutoThread(void * param);

pthread_mutex_t verrou = PTHREAD_MUTEX_INITIALIZER;
static uint16_t compteur = 0;
list_tuteurs *list = NULL;

int main(int argc, char** argv)
{
	struct sockaddr_in in;
	int sock, sock_clt, *clt_info;
	pthread_t thread;
	socklen_t sz;
	
	if(argc != 2)
    {
        fprintf(stdout, "%s\n", SERVEUR_ARGUMENT);
        return EXIT_FAILURE;
    }
	
	if((sock = socket(PF_INET, SOCK_STREAM, FLAG_SOCK)) == FAILURE)
    {
        fprintf(stdout, "%s\n", strerror(errno));
        return EXIT_FAILURE;
    }
	
	in.sin_family = AF_INET;
    in.sin_port = htons(atoi(argv[1]));
    in.sin_addr.s_addr = htonl(INADDR_ANY);
	
	sz = sizeof(in);
	
    if(bind(sock, (struct sockaddr *) &in, sz) == FAILURE)
    {
        fprintf(stdout, "%s\n", strerror(errno));
        close(sock);
        return EXIT_FAILURE;
    }
	
	if(listen(sock, SOMAXCONN) == FAILURE)
	{
		fprintf(stdout, "%s\n", strerror(errno));
        close(sock);
        return EXIT_FAILURE;
	}
	
	printf("Le serveur est en attente sur le port : %d \n", ntohs(in.sin_port));
	
	ListTuteur_Init();
	
	sz = sizeof(in);
	
	while(1)
    {
        if((sock_clt = accept(sock, (struct sockaddr *) &in, &sz)) == FAILURE)
        {
			fprintf(stdout, "%s\n", strerror(errno));
            close(sock);
            ListTuteur_Free();
			return EXIT_FAILURE;
        }

		printf("\nClient connecté socket : %d\n", sock_clt);
		
		if ((clt_info = malloc(sizeof(int))) == NULL)
		{
			fprintf(stdout, "%s\n", strerror(errno));
			close(sock_clt);
			close(sock);
			ListTuteur_Free();
			return EXIT_FAILURE;
		}
		*clt_info = sock_clt;
        pthread_create(&thread, NULL, tutoThread, clt_info);
    }
	
	close(sock);
	ListTuteur_Free();
	
	return EXIT_SUCCESS;
}

void * tutoThread(void * param)
{
	char buffer_in[BUFSIZ], buffer_out[BUFSIZ];
	char discip[DISCIPLINE_SIZE];
	int i, sock, byte_read, byte_write;
	uint16_t id;
	size_t size;
	

	sock = *((int *) param);
	
	free(param);
	pthread_detach(pthread_self());		

	memset(buffer_in, 0, BUFSIZ);
	memset(buffer_out, 0, BUFSIZ);
	memset(discip, 0, DISCIPLINE_SIZE);
	do
	{
		if ((byte_read = recv(sock, buffer_in, BUFSIZ, FLAG_RECV)) < 0)
		{
			fprintf(stdout, "%s\n", strerror(errno));
			break;
		}
		
		buffer_in[byte_read] = '\0';
			
			
		if(!strncmp(buffer_in, "quit", SIZE_MSG_1))
		{		
			break;
		}
		
		if(!strncmp(buffer_in, "disp", SIZE_MSG_1))
		{
			pthread_mutex_lock(&verrou);
			
			sprintf(buffer_out, "%d!\n", list->size);

			if((byte_write = send(sock, buffer_out, BUFSIZ, FLAG_SEND)) == FAILURE)
			{
				fprintf(stdout, "%s\n", strerror(errno));
				break;
			}
			
			for(i = 0; i < MAX_TUTEUR; i++)
			{
				if(list->tuteurs[i] != NULL)
				{
					sprintf(buffer_out, "<%d> <%s>\n", list->tuteurs[i]->id, list->tuteurs[i]->discipline);
					
					if((byte_write = send(sock, buffer_out, BUFSIZ, FLAG_SEND)) == FAILURE)
					{
						fprintf(stdout, "%s\n", strerror(errno));
						break;
					}
				}
			}

			pthread_mutex_unlock(&verrou);
			continue;
		}
		
		if(!strncmp(buffer_in, "help", SIZE_MSG_1))
		{
			pthread_mutex_lock(&verrou);
			
			pthread_mutex_unlock(&verrou);
			continue;
		}


		if(!strncmp(buffer_in, "get", SIZE_MSG_2))
		{
            pthread_mutex_lock(&verrou);
			
			pthread_mutex_unlock(&verrou);
			continue;
		}
		
		if(!strncmp(buffer_in, "add", SIZE_MSG_2))
		{
			pthread_mutex_lock(&verrou);
			
			sscanf(buffer_in, "add %" SCNd16 " %s", &id, discip);

			ListTuteur_Add(id, discip);
			
			pthread_mutex_unlock(&verrou);
			continue;
		}

		break;
	}while(byte_read > 0);

	printf("\nClient fin connection socket : %d\n", sock);
	
	close(sock);

    pthread_exit(NULL);
}

