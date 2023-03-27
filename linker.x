/* Linker script for command executable files */
OUTPUT_FORMAT(binary)
SECTIONS
{
  .text 0x1000 : { *(.text) }
  .data : { *(.data) *(.bss) }
  /DISCARD/ : { *(.eh_frame) }
}