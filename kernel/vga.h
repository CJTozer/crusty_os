// # Public interface
void vga_print(uint8_t *message);
void vga_print_at(uint8_t *message, int16_t col, int16_t row);

// # Private functions/structs - move
void print_char(uint8_t c, uint8_t attributes);
uint32_t get_screen_offset(uint16_t col, uint16_t row);
uint16_t get_cursor();
uint16_t set_cursor(uint16_t offset);
void clear_screen();
uint16_t handle_scrolling(uint16_t offset);

#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

#define CURSOR_OFFSET_HI 14
#define CURSOR_OFFSET_LO 15

#define WHITE_ON_BLACK 0x0f

struct video
{
    uint8_t *base_pointer;
    uint16_t columns;
    uint16_t rows;
    uint16_t next_pos;
    uint8_t current_format;
};
