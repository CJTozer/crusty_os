#pragma once
#include "isr.h"

static void keyboard_callback(registers_t regs);
void init_keyboard();
void print_letter(uint8_t scancode);