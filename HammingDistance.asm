section .data

    DATA1: db "foo"

    DATA2: db "bar"

    LENGTH1: equ $-DATA1

    LENGTH2: equ $-DATA2

    ;OUTPUT: db 0

    ;jmp main

    ;RETURN:

    ;OUTPUTLENGTH: equ $-OUTPUT

    ;jmp PRINT

section .bss

    OUTPUT: resb 0

global main

section .txt

    main:

        cmp LENGTH1, LENGTH2

        jae SETFIRST

        jbe SETSECOND




        SETFIRST: mov dl, LENGTH1

        SETSECOND: mov dl, LENGTH2

        mov cl, 0

        mov al, 0

        mov bl, 0

        mov ax, 0
            
        ;jmp LOOP

        LOOP:

            mov byte al, [DATA1+cl]

            mov byte bl, [DATA2+cl]

            xor al, bl

            add ax, al

            cmp cl, dl
            ;inc [cl]

            inc cl    ;cl is 0 here and goes to 1
            jne LOOP
            ;je OUT

        ;OUT:

        mov [OUTPUT], ax

        ;jmp RETURN

        ;PRINT:

        mov eax, 4

        mov ebx, 1

        mov ecx, OUTPUT

        mov edx, equ $- OUTPUT

        int 0x80

        mov eax, 1

        int 0x80


;Version 2

        
section .data

    DATA1: db "foo", 0

    DATA2: db "bar", 0

    LENGTH1: equ $-DATA1

    LENGTH2: equ $-DATA2
    
    INCREMENTER: db 0

    ;OUTPUT: db 10
    
    ;OUTPUTLENGTH: equ $- OUTPUT

    ;jmp main

    ;RETURN:

    ;OUTPUTLENGTH: equ $-OUTPUT

    ;jmp PRINT
    
    ;OUTPUT: resb 0
    
    ;OUTPUTLENGTH: equ $- OUTPUT



global main

section .txt

    main:

        mov eax, LENGTH1

        cmp eax, LENGTH2

        ja SETFIRST

        jb SETSECOND

        SETFIRST: mov edx, LENGTH1

        SETSECOND: mov edx, LENGTH2

        mov ecx, 0

        mov eax, 0

        mov ebx, 0

        ;mov ax, 0
            
        ;jmp LOOP

        LOOP:

            ;mov byte eax, [DATA1 + ecx]

            ;mov byte ebx, [DATA2 + ecx]
            
            mov eax, [DATA1 + ecx]

            mov ebx, [DATA2 + ecx]

            xor eax, ebx

            add [INCREMENTER], eax 

            cmp ecx, edx
            ;inc [cl]

            inc ecx    ;cl is 0 here and goes to 1
            jne LOOP
            ;je OUT

        ;OUT:

        mov [OUTPUT], ax

        ;jmp RETURN

        ;PRINT:

        mov eax, 4

        mov ebx, 1

        mov ecx, OUTPUT

        mov edx, OUTPUTLENGTH
        
        ;mov edx, equ $- OUTPUT

        int 0x80

        mov eax, 1

        int 0x80
        
section .bss

    OUTPUT: resb 8
    
    OUTPUTLENGTH: equ $- OUTPUT

            

        


