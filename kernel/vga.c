#include <stdint.h>
#include "vga.h"
#include "low_level.h"

struct video DISPLAY = {
    (uint8_t *)0xb8000,
    80,
    25,
    0,
    WHITE_ON_BLACK,
};

// Print a single char at the cursor.
void print_char(uint8_t c, uint8_t attributes)
{
    uint16_t offset = DISPLAY.next_pos;

    if (!attributes)
    {
        attributes = DISPLAY.current_format;
    }

    // If this is a newline, start the next row, otherwise print the character
    if (c == '\n')
    {
        int current_line = DISPLAY.next_pos / (DISPLAY.columns * 2);
        offset = get_screen_offset(0, current_line + 1);
    }
    else
    {
        DISPLAY.base_pointer[offset] = c;
        DISPLAY.base_pointer[offset + 1] = attributes;
        offset += 2;
    }

    // Handle scrolling
    offset = handle_scrolling(offset);

    // Update the cursor
    set_cursor(offset);
}

uint32_t get_screen_offset(uint16_t col, uint16_t row)
{
    return (row * DISPLAY.columns + col) * 2; // 2 bytes per character
}

uint16_t get_cursor()
{
    uint16_t offset;
    // Get the high byte
    outb(REG_SCREEN_CTRL, CURSOR_OFFSET_HI);
    offset = inb(REG_SCREEN_DATA) << 8;
    // And the low byte
    outb(REG_SCREEN_CTRL, CURSOR_OFFSET_LO);
    offset += inb(REG_SCREEN_DATA);
    // 2 bytes per character, so double the result
    return offset * 2;
}

uint16_t set_cursor(uint16_t offset)
{
    // Offset is double the "position" that VGA sees
    uint16_t pos = offset / 2;
    DISPLAY.next_pos = offset;
    // Set the high byte
    outb(REG_SCREEN_CTRL, CURSOR_OFFSET_HI);
    outb(REG_SCREEN_DATA, (uint8_t)(pos >> 8));
    // And the low byte
    outb(REG_SCREEN_CTRL, CURSOR_OFFSET_LO);
    outb(REG_SCREEN_DATA, (uint8_t)(pos & 0xFF));
}

// Print a NULL-terminated string at the current cursor.
void vga_print(uint8_t *message)
{
    vga_print_at(message, -1, -1);
}

// Print a NULL-terminated string at a specific screen position.
void vga_print_at(uint8_t *message, int16_t col, int16_t row)
{
    uint8_t *c;

    // If coords specified, move the cursor before starting
    if (col >= 0 && row >= 0)
    {
        set_cursor(get_screen_offset(col, row));
    }

    // Print each char in turn
    while (*(c = message++) != 0)
    {
        print_char(*c, WHITE_ON_BLACK);
    }
}

void clear_screen()
{
    set_cursor(get_screen_offset(0, 0));
    for (uint16_t ii = 0; ii < DISPLAY.columns * DISPLAY.rows; ii++)
    {
        print_char(' ', WHITE_ON_BLACK);
    }
    set_cursor(get_screen_offset(0, 0));
}

uint16_t handle_scrolling(uint16_t offset)
{
    // TODO
    return offset;
}