; load DH sectors from disk DL to [ES:BX]
disk_load:
    push dx ; Save this for later so we can check segments read

    mov ah, 0x02 ; BIOS read sector
    mov al, dh   ; Number of sectors to read
    mov ch, 0x00 ; Cylinder 0
    mov dh, 0x00 ; Head 0
    mov cl, 0x02 ; Start from second sector (boot sector is first)

    int 0x13 ; BIOS interrupt to read
    jc disk_error ; If there's an error reading

    pop dx ; To check secors read is correct
    cmp dh, al
    jne disk_error
    ret

disk_error:
    mov bx, DISK_ERROR_MESSAGE
    call bios_print_string
    jmp $

DISK_ERROR_MESSAGE db "Disk read error!", 0xd, 0xa, 0
