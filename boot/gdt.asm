; GDT itself
gdt_start:

; NULL entry to start the GDT
gdt_null:
    times 2 dd 0x0

; Code segment
gdt_code:
    ; base=0x0, limit=0xfffff
    ; flags:
    ;    "1st" (present)1 (privilege)00 (descriptor type)1 -> 1001b
    ;    "type" (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
    ;    "2nd" (granularity)1 (32-bit?)1 (64-bit?)0 (AVL)0 -> 1100b
    dw 0xffff    ; Limit (bits 0-15)
    dw 0x0       ; Base (bits 0-15)
    db 0x0       ; Base (bits 16-23)
    db 10011010b ; 1st and type flags 
    db 11001111b ; 2nd flags and limit (bits 16-19)
    db 0x0       ; base (bits 24-31)

; Data segment
gdt_data:
    ; Same as code, but type flags are
    ;     (code)0 (direction)0 (writeable)1 (accessed)0 -> 0010b
    dw 0xffff    ; Limit (bits 0-15)
    dw 0x0       ; Base (bits 0-15)
    db 0x0       ; Base (bits 16-23)
    db 10010010b ; 1st and type flags [the only bit that differs to code]
    db 11001111b ; 2nd flags and limit (bits 16-19)
    db 0x0       ; base (bits 24-31)

gdt_end: ; only used to calculate the size in the assembler


; GDT descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; GDT size, minus one (presumably to fit max size into a word)
    dd gdt_start               ; GDT start address

; Constants to use to simplify the addressing - this will just provide the 16-bit segment to use
; for each part of the GDT
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start