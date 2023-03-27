;
; A simple boot sector program that loops forever.
;
[org 0x7c00] ; Expect this code to be loaded here by BIOS

    mov [BOOT_DRIVE], dl ; First remember the boot drive BIOS is using

    ; Set up the stack
    mov bp, 0x8000 ; Beyond where BIOS loads the boot sector.
    mov sp, bp

    ; Print the 16-bit boot message
    mov bx, MSG_REAL_MODE_BOOT
    call print_string

    ; ; Load 5 sectors from disk into 0x0000(ES):0x9000(BX)
    ; mov bx, 0x9000
    ; mov dh, 5
    ; mov dl, [BOOT_DRIVE]
    ; call disk_load

    ; ; Print a couple of hex characters from the later sectors
    ; mov dx, [0x9000]
    ; call print_hex
    ; mov dx, [0x9000 + 512]
    ; call print_hex

    call switch_to_pm

    jmp $

%include "bios_print.asm"
%include "gdt.asm"
; %include "bios_disk_load.asm"
%include "pm_print.asm"
%include "switch_to_pm.asm"

; After switching to protected mode, we arrive here
BEGIN_PM:
    mov ebx, MSG_PROTECTED_MODE_BOOT
    call pm_print_string

    jmp $

; Global variables
BOOT_DRIVE: db 0
MSG_REAL_MODE_BOOT: db 'Starting boot in 16-bit real mode...', 0xd, 0xa, 0
MSG_PROTECTED_MODE_BOOT: db 'Switched to 32-bit protected mode...', 0xd, 0xa, 0

; Bootsector padding
times 510-($-$$) db 0 ; Pad zeros up to 510 bytes
dw 0xaa55 ; Last two bytes are the magic number so BIOS knows we are a boot sector.

times 1024 db 0 ; Make some space?