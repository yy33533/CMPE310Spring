section .data

    DATA1: db "foo"

    DATA2: db "bar"

    LENGTH1: equ $-DATA1

    LENGTH2: equ $-DATA2

;section .bss


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

        in 0x80

        

            

        


