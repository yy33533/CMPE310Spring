section .data
    FILENAME db "randomInt100.txt", 0
    NULLTER  db 0
    SPACE    db 32
    NEWLINE  db 10

section .bss
    BUFFER   resb 200      ; file read buffer
    SUMSTR   resb 20       ; string for sum
    SUM      resd 1
    CUR      resd 1

global _start

section .text
_start:
    ; open file
    mov eax, 5
    mov ebx, FILENAME
    mov ecx, 0
    int 0x80
    mov esi, eax            ; fd

    ; read file into BUFFER
    mov eax, 3
    mov ebx, esi
    mov ecx, BUFFER
    mov edx, 200
    int 0x80
    mov edi, eax            ; bytes read

    ; initialize sum and current number
    mov eax, 0
    mov [SUM], eax
    mov [CUR], eax

    mov ecx, 0              ; index
parse_loop:
    cmp ecx, edi
    jge commit_last
    mov al, [BUFFER + ecx]
    cmp al, '0'
    jb not_digit
    cmp al, '9'
    ja not_digit
    ; digit
    sub al, '0'
    movzx eax, al
    mov ebx, [CUR]
    imul ebx, ebx, 10
    add ebx, eax
    mov [CUR], ebx
    inc ecx
    jmp parse_loop
not_digit:
    ; commit CUR to SUM if CUR>0
    mov eax, [CUR]
    cmp eax, 0
    je skip_commit
    mov ebx, [SUM]
    add ebx, eax
    mov [SUM], ebx
    mov eax, 0
    mov [CUR], eax
skip_commit:
    inc ecx
    jmp parse_loop

commit_last:
    mov eax, [CUR]
    cmp eax, 0
    je convert_sum
    mov ebx, [SUM]
    add ebx, eax
    mov [SUM], ebx
    mov eax, 0
    mov [CUR], eax

convert_sum:
    ; convert SUM to ASCII string in SUMSTR (build backwards)
    mov eax, [SUM]
    mov edi, SUMSTR
    add edi, 19
    mov byte [edi], 0      ; null terminator

    cmp eax, 0
    jne conv_loop_start
    dec edi
    mov byte [edi], '0'
    jmp print_loop

conv_loop_start:
conv_loop:
    mov edx, 0
    mov ebx, 10
    div ebx                  ; eax = eax/10, edx = remainder
    add dl, '0'
    dec edi
    mov [edi], dl
    cmp eax, 0
    jne conv_loop

print_loop:
    ; print character by character
    mov esi, edi
print_char:
    mov al, [esi]
    cmp al, 0
    je done
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    mov edx, 1
    int 0x80
    inc esi
    jmp print_char

done:
    ; print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, NEWLINE
    mov edx, 1
    int 0x80

    ; close file
    mov eax, 6
    mov ebx, esi
    ;int 0x80

    ; exit
    mov eax, 1
    mov ebx, 0
    int 0x80
