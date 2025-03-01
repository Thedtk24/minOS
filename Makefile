NASM = nasm
CC = i686-linux-gnu-gcc
CFLAGS = -ffreestanding -m32 -nostdlib -nodefaultlibs

BOOTLOADER = bootloader/bootloader.bin
KERNEL_ELF = kernel/kernel.elf
KERNEL = kernel/kernel.bin
OS_IMAGE = final_os.bin

all: $(OS_IMAGE)

$(BOOTLOADER): bootloader/boot.asm
	$(NASM) -f bin bootloader/boot.asm -o $(BOOTLOADER)

$(KERNEL_ELF): kernel/kernel.c
	$(CC) $(CFLAGS) -Ttext 0x10000 -o $(KERNEL_ELF) kernel/kernel.c

$(KERNEL): $(KERNEL_ELF)
	objcopy -O binary $(KERNEL_ELF) $(KERNEL)  # Conversion en binaire brut

$(OS_IMAGE): $(BOOTLOADER) $(KERNEL)
	cat $(BOOTLOADER) $(KERNEL) > $(OS_IMAGE)
	dd if=/dev/zero bs=512 count=64 >> $(OS_IMAGE)  # Padding pour éviter des erreurs

run: $(OS_IMAGE)
	qemu-system-x86_64 -drive format=raw,file=$(OS_IMAGE)

clean:
	rm -f $(BOOTLOADER) $(KERNEL) $(KERNEL_ELF) $(OS_IMAGE)
