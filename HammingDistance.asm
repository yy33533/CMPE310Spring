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

        

            

        


