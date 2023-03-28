KERNEL_SRCS := $(shell find kernel -name '*.c')
KERNEL_OBJS := $(KERNEL_SRCS:kernel/%.c=output/%.o)
INC_DIRS := kernel
INC_FLAGS := $(addprefix -I,$(INC_DIRS))
CC_FLAGS := -ffreestanding -fno-pie -ffunction-sections -m32
LD_FLAGS := -T linker.x --oformat binary -melf_i386

# Main target - the OS image
output/os-image: output/boot_sect.bin output/kernel.bin
	cat output/boot_sect.bin output/kernel.bin > output/os-image

# Build the boot sector
output/boot_sect.bin: $(wildcard boot/*.asm)
	@mkdir -p output
	nasm -Iboot -o output/boot_sect.bin boot/boot_sect.asm

# Make the kernel binary
output/kernel.bin: $(KERNEL_OBJS)
	ld $(LD_FLAGS) -o $@ $(KERNEL_OBJS)

# Make the kernel object files
output/%.o: kernel/%.c
	@mkdir -p output
	gcc $(CC_FLAGS) $(INC_FLAGS) -o $@ -c $<

# Clean up the output directory
clean:
	-@rm -r output/* 2>/dev/null || true