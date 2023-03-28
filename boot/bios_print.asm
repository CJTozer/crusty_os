; Print the null-terminated string whose address is in bx
bios_print_string:
    pusha
    mov ah, 0x0e
bios_print_string_next_char:
    ; Get the next letter
    mov al, [bx]
    cmp al, $0
    ; If NULL, return
    je bios_print_string_end
    ; Print the next letter
    int 0x10
    ; Move on
    inc bx
    jmp bios_print_string_next_char
bios_print_string_end:
    popa
    ret

; TODO just push each nibble onto the stack?
; Print the hex value in register dx
bios_print_hex:
    pusha
    mov ah, 0x0e

    ; Start with the hex prefix
    mov al, '0'
    int 0x10
    mov al, 'x'
    int 0x10

    ; Start with the most significant byte
    mov cx, $0

    ; First nibble
    mov al, dh
    shr al, $4
    call bios_print_hex_nibble

    ; Second nibble
    mov al, dh
    and al, 0x0f
    call bios_print_hex_nibble

    ; For least-significant byte
    ; First nibble
    mov al, dl
    shr al, $4
    call bios_print_hex_nibble

    ; Second nibble
    mov al, dl
    and al, 0x0f
    call bios_print_hex_nibble

    popa
    ret

; Print the hex representation of the lowest 4 bits in cl
bios_print_hex_nibble:
    pusha
    mov ah, 0x0e

    ; If <= 9, add '0'
    cmp al, 0x9
    jg bios_print_hex_nibble_alpha
    add al, '0'
    jmp bios_print_hex_nibble_end

bios_print_hex_nibble_alpha:
    ; For alpha, use lower case - add ('a' - 10 = 'W')
    ; add al, 0x57
    add al, 'W'
    ; sub al, $10
    jmp bios_print_hex_nibble_end

bios_print_hex_nibble_end:
    int 0x10
    popa
    ret