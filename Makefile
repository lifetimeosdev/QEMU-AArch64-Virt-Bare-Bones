all: kernel.elf

boot.o: boot.s
	aarch64-linux-gnu-as boot.s -o boot.o

kernel.o: kernel.c
	aarch64-linux-gnu-gcc -ffreestanding -c kernel.c -o kernel.o

kernel.elf: boot.o kernel.o
	aarch64-linux-gnu-ld -nostdlib -Tlinker.ld boot.o kernel.o -o kernel.elf


run: kernel.elf
	qemu-system-aarch64 -machine virt -cpu cortex-a57 -kernel kernel.elf -nographic

clean:
	rm boot.o kernel.o kernel.elf

