;
; A simple boot sector program that loops forever.
;
[org 0x7c00] ; Expect this code to be loaded here by BIOS

    ; Set up the stack
    mov bp, 0x8000 ; Beyond where BIOS loads the boot sector.
    mov sp, bp

    ; Print the hello message
    mov bx, HELLO_MSG
    call print_string

    ; Print the goodbye message
    mov bx, GOODBYE_MSG
    call print_string

    jmp $

%include "bios_print.asm"

; Data
HELLO_MSG:
    db 'Hello, World!', 0xa, 0

GOODBYE_MSG:
    db 'Goodbye!', 0xa, 0

times 510-($-$$) db 0 ; Pad zeros up to 510 bytes
dw 0xaa55 ; Last two bytes are the magic number so BIOS knows we are a boot sector.