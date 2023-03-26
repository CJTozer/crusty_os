;
; A simple boot sector program that loops forever.
;
loop:
    jmp loop

times 510-($-$$) db 0 ; Pad zeros up to 510 bytes
dw 0xaa55 ; Last two bytes are the magic number so BIOS knows we are a boot sector.