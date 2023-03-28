#pragma once

// Everyone needs the standard types
#include <stdint.h>

#define BOCHS_MAGIC_BREAKPOINT asm volatile("xchgw %bx, %bx")

#define low_16(address) (uint16_t)((address)&0xFFFF)
#define high_16(address) (uint16_t)(((address) >> 16) & 0xFFFF)