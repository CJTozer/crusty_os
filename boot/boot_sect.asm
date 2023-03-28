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
    call bios_print_string

    ; Load the Kernel
    call load_kernel

    ; Switch to 32-bit protected mode
    call switch_to_pm

    jmp $

%include "bios_print.asm"
%include "gdt.asm"
%include "bios_disk_load.asm"
%include "pm_print.asm"
%include "switch_to_pm.asm"

[bits 16]
; Load the Kernel
load_kernel:
KERNEL_OFFSET equ 0x1000
    mov bx, MSG_LOAD_KERNEL
    call bios_print_string

    mov ax, 0x0 ; Load the first 15 sectors (excluding the boot sector) to [0:KERNEL_OFFSET]
    mov es, ax
    mov bx, KERNEL_OFFSET
    mov dh, 15
    mov dl, [BOOT_DRIVE]
    call disk_load

    ; Print the first few bytes of where the Kernel should be
    mov dx, [KERNEL_OFFSET]
    call bios_print_hex

    ret

[bits 32]
; After switching to protected mode, we arrive here
BEGIN_PM:
    mov ebx, MSG_PROTECTED_MODE_BOOT
    call pm_print_string

    ; Call our Kernel entrypoint
    ; xchg bx, bx ; Breakpoint for Bochs
    call KERNEL_OFFSET

    jmp $

; Global variables
BOOT_DRIVE: db 0
MSG_REAL_MODE_BOOT: db 'Starting boot in 16-bit real mode...', 0xd, 0xa, 0 ; \r\n for BIOS only
MSG_PROTECTED_MODE_BOOT: db 'Switched to 32-bit protected mode...', 0
MSG_LOAD_KERNEL: db 'Loading kernel into memory...' , 0

; Bootsector padding
times 510-($-$$) db 0 ; Pad zeros up to 510 bytes
dw 0xaa55 ; Last two bytes are the magic number so BIOS knows we are a boot sector.