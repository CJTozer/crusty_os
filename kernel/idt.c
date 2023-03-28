#include "common.h"
#include "idt.h"

// Set up an IDT entry with the specified handler.
void set_idt_gate(uint8_t n, uint32_t handler)
{
    idt[n].low_offset = low_16(handler);
    idt[n].selector = 0x08; // see GDT
    idt[n].always0 = 0;
    // 0x8E = 1  00 0 1  110
    //        P DPL 0 D Type
    idt[n].flags = 0x8E;
    idt[n].high_offset = high_16(handler);
}

void set_idt()
{
    idt_reg.base = (uint32_t)&idt;
    idt_reg.limit = IDT_ENTRIES * sizeof(idt_gate_t) - 1;
    /* Load &idt_reg not &idt */
    asm volatile("lidtl (%0)"
                 :
                 : "r"(&idt_reg));
}