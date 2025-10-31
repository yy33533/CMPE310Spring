section .data
DATA1: db "foo"
LENGTH1: equ $-DATA1    ;Immediately takes the length of first string before doing the second string
DATA2: db "bar"
LENGTH2: equ $-DATA2
NEWLINE: db 10

section .bss
OUTPUT: resd 1
BUFFER: resb 10

global main
section .text
main:

    mov dword [OUTPUT], 0   ;Clears the output and registers
    mov esi, 0
    mov eax, 0
    mov ebx, 0
    mov edi, 0

    mov eax, LENGTH1
    mov ebx, LENGTH2
    cmp eax, ebx    ;Sets edi to the shorter string length
    jae SETSECOND
    jb SETFIRST

SETSECOND:
    mov edi, ebx
    jmp LOOP

SETFIRST:
    mov edi, eax
    jmp LOOP

LOOP:

    cmp esi, edi    ;Keeps looping while esi is less than edi, the length of the shorter string
    jge END

    mov al, [DATA1 + esi]   ;Takes the lower byte of each character of DATA1
    mov bl, [DATA2 + esi]
    xor al, bl  ;Performs an bitwise XOR operation to determine bit differences and isolates byte

    mov edx, 0
    jmp COUNT



COUNT:  ;Nested loop
    cmp eax, 0  
    je OUT  ;When all bits are shifted out, this statement will be true
    mov ecx, eax
    and ecx, 1
    add edx, ecx
    shr eax, 1
    jmp COUNT

OUT:
    add dword [OUTPUT], edx     ;Adds on the bits accumulated by edx to the total output
    inc esi
    jmp LOOP

END:

    mov eax, [OUTPUT]
    mov edi, BUFFER + 10    ;Arranges buffer to fill with each digit of output
    mov byte [edi], 0

    jmp CONVERT

CONVERT:
    mov edx, 0
    mov ebx, 10
    div ebx
    add dl, '0' ;Converts to ASCII and puts in buffer
    dec edi
    mov [edi], dl
    cmp eax, 0
    jne CONVERT

    mov eax, 4
    mov ebx, 1 
    mov ecx, edi
    mov edx, BUFFER + 10    ;Prints out the digits in buffer
    sub edx, edi
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, NEWLINE
    mov edx, 1
    int 0x80


    mov eax, 1  ;Exits kernel
    mov ebx, 0
    int 0x80
