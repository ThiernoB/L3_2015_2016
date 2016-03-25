#include "libs.h"

int main(int argc, char** argv)
{
	struct sockaddr_in in;
	char buffer_in[BUFSIZ], buffer_out[BUFSIZ];
	int sock, byte_read, i, size;
	
	if(argc != 3)
    {
        fprintf(stdout, "%s\n", CLIENT_ARGUMENT);
        return EXIT_FAILURE;
    }
	
    if((sock = socket(PF_INET, SOCK_STREAM, FLAG_SOCK)) == FAILURE)
    {
        fprintf(stdout, "%s\n", strerror(errno));
        return EXIT_FAILURE;
    }
	
	in.sin_family = AF_INET;
    in.sin_port = htons(atoi(argv[2]));
    in.sin_addr.s_addr = htonl(INADDR_ANY);
	
	if(connect(sock, (struct sockaddr *)&in, sizeof(in)) == FAILURE)
	{
		fprintf(stdout, "%s\n", strerror(errno));
		return EXIT_FAILURE;
	}
	
	memset(buffer_in, 0, BUFSIZ);
	memset(buffer_out, 0, BUFSIZ);
	
	while(1)
	{
		printf("\n$");
		
		fgets(buffer_out, BUFSIZ, stdin);
		
		if(!strncmp(buffer_out, "quit", SIZE_MSG_1))
			break;
		
		if(send(sock, buffer_out, BUFSIZ, FLAG_SEND) == FAILURE)
		{
			fprintf(stdout, "%s\n", strerror(errno));
			close(sock);
            return EXIT_FAILURE;
		}
		
		if(!strncmp(buffer_out, "disp", SIZE_MSG_1))
		{
			if((byte_read = recv(sock, buffer_in, BUFSIZ, FLAG_RECV)) < 0)
			{
				fprintf(stdout, "%s\n", strerror(errno));
				close(sock);
				return EXIT_FAILURE;
			}

			buffer_in[byte_read] = '\0';
			printf("%s\n", buffer_in);
			size = buffer_in[0] - '0';

			for(i = 0; i < size; i++)
			{
				if((byte_read = recv(sock, buffer_in, BUFSIZ, FLAG_RECV)) < 0)
				{
					fprintf(stdout, "%s\n", strerror(errno));
					close(sock);
					return EXIT_FAILURE;
				}
				
				buffer_in[byte_read] = '\0';
				printf("%s\n", buffer_in);
			}	
			
			continue;
		}

		if(!strncmp(buffer_out, "get", SIZE_MSG_2) || !strncmp(buffer_out, "help", SIZE_MSG_1))
		{
            if((byte_read = recv(sock, buffer_in, BUFSIZ, FLAG_RECV)) == FAILURE)
            {
				fprintf(stdout, "%s\n", strerror(errno));
                close(sock);
                return EXIT_FAILURE;
            }

            buffer_in[byte_read] = '\0';
            printf("%s\n", buffer_in);
			
			continue;
		}
		
		if(!strncmp(buffer_out, "add", SIZE_MSG_2))
			continue;
		
		break;
	}
	
	close(sock);
	
	return EXIT_SUCCESS;
}
