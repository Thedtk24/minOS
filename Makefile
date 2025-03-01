NASM = nasm
CC = aarch64-linux-gnu-gcc
CFLAGS = -ffreestanding -nostdlib -nodefaultlibs -mcpu=cortex-a53

BOOTLOADER = bootloader/bootloader.bin
KERNEL = kernel/kernel.bin
OS_IMAGE = final_os.bin

all: $(OS_IMAGE)

$(BOOTLOADER): bootloader/boot.asm
	$(NASM) -f bin bootloader/boot.asm -o $(BOOTLOADER)

$(KERNEL): kernel/kernel.c
	$(CC) $(CFLAGS) -o $(KERNEL) kernel/kernel.c
	
$(OS_IMAGE): $(BOOTLOADER) $(KERNEL)
	cat $(BOOTLOADER) $(KERNEL) > $(OS_IMAGE)

run: $(OS_IMAGE)
	qemu-system-x86_64 -drive format=raw,file=$(OS_IMAGE)

clean:
	rm -f $(BOOTLOADER) $(KERNEL) $(OS_IMAGE)
