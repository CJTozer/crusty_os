print_string:
    ; Argument is in bx
    pusha
    mov ah, 0x0e
print_string_next_char:
    ; Get the next letter
    mov al, [bx]
    cmp al, $0
    ; If NULL, return
    je print_string_end
    ; Print the next letter
    mov al, [bx]
    int 0x10
    ; Move on
    inc bx
    jmp print_string_next_char
print_string_end:
    popa
    ret