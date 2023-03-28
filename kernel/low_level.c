#include <stdint.h>
#include "low_level.h"

// Read a byte from the specified port
uint8_t inb(uint16_t port)
{
    uint8_t result;
    // Put port in edx read eax into result when done.
    asm volatile(
        "in %1, %0"
        : "=a"(result)
        : "Nd"(port));
    return result;
}

// Write a byte to the specified port
void outb(uint16_t port, uint8_t data)
{
    // Put port in edx and data to write in eax
    asm volatile(
        "out %0, %1"
        :
        : "a"(data), "Nd"(port));
}

// Read a word from the specified port
uint16_t inw(uint16_t port)
{
    uint16_t result;
    // Put port in edx read eax into result when done.
    asm volatile(
        "in %%dx, %%ax"
        : "=a"(result)
        : "d"(port));
    return result;
}

// Write a word to the specified port
void outw(uint16_t port, uint16_t data)
{
    // Put port in edx and data to write in eax
    asm volatile(
        "out %%ax, %%dx"
        :
        : "a"(data), "d"(port));
}