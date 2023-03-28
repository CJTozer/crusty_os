#include <stdint.h>
#include "vga.h"

struct video DISPLAY = {
    (uint8_t *)0xb8000,
    80,
    25,
    0,
    WHITE_ON_BLACK,
};

// Print a single char to the screen, and update DISPLAY
void write_char(uint8_t c, uint8_t format)
{
    DISPLAY.base_pointer[DISPLAY.next_pos] = c;
    DISPLAY.base_pointer[DISPLAY.next_pos + 1] = format;
    DISPLAY.next_pos += 2;
}

// Print a NULL-terminated string to a new line (ignoring format for now)
void write_line(uint8_t *line)
{
    char *c;
    int current_line = DISPLAY.next_pos % (DISPLAY.columns * 2);

    while (*(c = line++) != 0)
    {
        // Display memory has a byte for format and a byte for the character
        // Default format for now
        write_char(*c, WHITE_ON_BLACK);
    }

    // Move to a new line.
    DISPLAY.next_pos = (current_line + 1) * DISPLAY.columns * 2;
}

void clear_screen()
{
    for (uint16_t ii = 0; ii < DISPLAY.columns * DISPLAY.rows; ii++)
    {
        write_char('\0', WHITE_ON_BLACK);
    }

    DISPLAY.next_pos = 0;
}