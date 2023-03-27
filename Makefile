os-image: output/boot_sect.bin output/kernel.bin
	cat output/boot_sect.bin output/kernel.bin > os-image

# Build the boot sector
output/boot_sect.bin: $(wildcard boot/*.asm)
	mkdir -p output
	nasm -Iboot -o output/boot_sect.bin boot/boot_sect.asm

# Make the kernel binary
output/kernel.bin: output/kernel.o
	mkdir -p output
	ld -o output/kernel.bin -T linker.x output/kernel.o --oformat binary

# Make the kernel object file
output/kernel.o: kernel/kernel.c
	mkdir -p output
	gcc -ffreestanding -c kernel/kernel.c -o output/kernel.o

# Clean up the output directory
clean:
	rm os-image
	rm -r output/*