;
; A simple boot sector program that loops forever.
;
[org 0x7c00] ; Expect this code to be loaded here by BIOS

    mov [BOOT_DRIVE], dl ; First remember the boot drive BIOS is using

    ; Set up the stack
    mov bp, 0x8000 ; Beyond where BIOS loads the boot sector.
    mov sp, bp

    ; Print the hello message
    mov bx, HELLO_MSG
    call print_string

    ; Load 5 sectors from disk into 0x0000(ES):0x9000(BX)
    mov bx, 0x9000
    mov dh, 5
    mov dl, [BOOT_DRIVE]
    call disk_load

    ; Print a couple of hex characters from the later sectors
    mov dx, [0x9000]
    call print_hex
    mov dx, [0x9000 + 512]
    call print_hex

    ; Print the goodbye message
    mov bx, GOODBYE_MSG
    call print_string

    jmp $

%include "bios_print.asm"
%include "bios_disk_load.asm"

; Data
BOOT_DRIVE: db 0
HELLO_MSG:
    db 'Hello, World!', 0xd, 0xa, 0
GOODBYE_MSG:
    db 'Goodbye!', 0xd, 0xa, 0

times 510-($-$$) db 0 ; Pad zeros up to 510 bytes
dw 0xaa55 ; Last two bytes are the magic number so BIOS knows we are a boot sector.

; Add some data to the next disk sectors
times 256 dw 0xdada
times 256 dw 0xface