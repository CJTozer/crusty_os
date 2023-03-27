[bits 16]
; Switch to 32-bit protected mode
switch_to_pm:
    cli ; Turn off interrupts until the interrupt vector is set up
    lgdt [gdt_descriptor] ; Load the GDT

    ; Set first bit of CR0 to enable 32-bit protected mode
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    ; Make a "far jump" to ensure the CPU pipeline is clear of 16-bit real-mode instructions
    jmp CODE_SEG:init_pm

[bits 32]
; Set up stack and registers once in PM
init_pm:
    ; Point all the segment registers at the data selector
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Update stack pointer to the top of our free space
    mov esp, 0x90000
    mov ebp, esp

    ; Finally call some well-known label
    call BEGIN_PM
