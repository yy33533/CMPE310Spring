section .data

    FILENAME db "randomInt100.txt", 0

    SPACE db 32

    NEWLINE db 10

    CARRIAGE db 13 ;Each line ends with a space/carriage return/new line

    NULLTER db 0 ;The file ends with nullterminator

section .bss

    BUFFER resb 3000 ;Big enough to store 1000 words

    TEMP resd 1 

    SUM resd 1

    OUTPUTBUFFER resb 20 ;Stores the output

global main

section .text

main:

    mov eax, 5

    mov ebx, FILENAME

    mov ecx, 0

    int 0x80 ;Reads the file

    mov edi, eax

    mov dword [TEMP], 0

    mov dword [SUM], 0

    jmp READ

READ:

    mov eax, 3  

    mov ebx, edi

    mov ecx, BUFFER

    mov edx, 3000

    int 0x80

    mov esi, eax

    mov ecx, 0

    jmp LOOP

LOOP:

    mov eax, 0

    mov al, [BUFFER + ecx] ;Stores each digit

    cmp al, [SPACE]

    je ADDNUM ;If al is space, new line, or a carriage return, the number is added on to the total

    cmp al, [NEWLINE]

    je ADDNUM

    cmp al, [CARRIAGE]

    je ADDNUM

    cmp al, [NULLTER]

    je DONE ;When null terminator is reached, end of file is reached

    cmp al, '0'

    jl ADDNUM ;Adds digit on to the end to form a number (between ASCII 0 and ASCII 9)

    cmp al, '9'

    jg ADDNUM

    sub eax, '0' ;Turns digit back into ASCII

    mov ebx, [TEMP] 

    imul ebx, ebx, 10

    add ebx, eax

    mov [TEMP], ebx

    add ecx, 1

    jmp LOOP

ADDNUM:

    mov eax, [TEMP]

    add [SUM], eax 

    mov dword [TEMP], 0 ;Resets the TEMP for the next number

    inc ecx ;Increments ecx
    
    jmp LOOP

DONE:

    mov eax, [TEMP]

    add [SUM], eax

    jmp PRINT

PRINT:

    mov eax, [SUM]

    mov edi, OUTPUTBUFFER

    add edi, 20

    mov byte [edi], 0

    jmp CONVERT

CONVERT:

    mov edx, 0

    mov ebx, 10

    div ebx

    add dl, '0'

    sub edi, 1

    mov [edi], dl

    cmp eax, 0

    jne CONVERT

    mov eax, 4

    mov ebx, 1

    mov ecx, edi

    mov edx, OUTPUTBUFFER + 20

    sub edx, edi

    int 0x80

    mov eax, 1

    mov ebx, 0

    int 0x80 ;Exits kernel and terminates program