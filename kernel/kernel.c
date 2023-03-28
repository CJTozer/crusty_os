#include "common.h"
#include "vga.h"
#include "keyboard.h"

void main();

void main()
{
    enable_cursor(9, 15);
    clear_screen();
    vga_print("98765\n4321");
    vga_print_at("ONE", 4, 4);
    vga_print("123");
    vga_print_at("MORE", 6, 6);
    vga_print("2121");
    vga_print_at("THING", 8, 8);
    vga_print_at("ALSO", 10, 10); // Cursor in the right place after this
    // vga_print_at("EXTRA", 60, 24); // But not after this...
    vga_print_at("EXTRA", 60, 23);
    vga_print("123456789012345");
    // vga_print("1234567890");

    isr_install();
    asm volatile("sti");
    init_keyboard();
}