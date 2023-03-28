#include <stdint.h>
#include "vga.h"

void main();

void main()
{
    clear_screen();
    vga_print("98765\n4321");
    vga_print_at("ONE", 4, 4);
    vga_print("123");
    vga_print_at("MORE", 6, 6);
    vga_print("2121");
    vga_print_at("THING", 8, 8);
    vga_print_at("ALSO", 10, 10);
}