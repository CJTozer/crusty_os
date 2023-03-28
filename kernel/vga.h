void write_line(uint8_t *line);
void clear_screen();

#define WHITE_ON_BLACK 0x0f

struct video
{
    uint8_t *base_pointer;
    uint16_t columns;
    uint16_t rows;
    uint16_t next_pos;
    uint8_t current_format;
};
