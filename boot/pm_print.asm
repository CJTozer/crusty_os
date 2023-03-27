[bits 32]
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; Print a NULL-terminated string pointed to by EBX
pm_print_string:
    pusha
    mov edx, VIDEO_MEMORY

    ; Boring format for now
    mov ah, WHITE_ON_BLACK

pm_print_string_loop:
    mov al, [ebx] ; Store next char in AL

    ; If this is NULL, string is done
    cmp al, 0
    je pm_print_string_done

    ; Store the character and format in video memory
    mov [edx], ax

    ; Move to the next char, and 2 bytes forwards in video memory
    inc ebx
    add edx, 2
    jmp pm_print_string_loop

pm_print_string_done:
    popa
    ret