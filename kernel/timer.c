#include "common.h"
#include "low_level.h"
#include "timer.h"
#include "vga.h"
#include "utils.h"
#include "isr.h"

uint32_t tick = 0;

// Callback for a timer interrupt
static void timer_callback(registers_t regs)
{
    tick++;

    if (tick % 1000 == 0)
    {
        char tick_ascii[256];
        vga_print("Tick: ");
        int_to_ascii(tick, tick_ascii);
        vga_print(tick_ascii);
        vga_print("\n");
    }
}

// Set up a timer callback with the given frequency in Hz
// TODO - change this to be a ms interval.
void init_timer(uint32_t freq)
{
    register_interrupt_handler(IRQ0, timer_callback);

    /* Get the PIT value: hardware clock at 1193180 Hz */
    uint32_t divisor = 1193180 / freq;
    uint8_t low = (uint8_t)(divisor & 0xFF);
    uint8_t high = (uint8_t)((divisor >> 8) & 0xFF);
    /* Send the command */
    outb(0x43, 0x36); /* Command port */
    outb(0x40, low);
    outb(0x40, high);
}