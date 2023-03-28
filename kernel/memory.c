#include "common.h"
#include "memory.h"

void memory_copy(uint8_t *source, uint8_t *dest, uint32_t num_bytes)
{
    for (int ii = 0; ii < num_bytes; ii++)
    {
        dest[ii] = source[ii];
    }
}

void memory_set(uint8_t *addr, uint8_t val, uint32_t num_bytes)
{
    for (int ii = 0; ii < num_bytes; ii++)
    {
        addr[ii] = val;
    }
}