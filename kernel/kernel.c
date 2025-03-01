void kernel_main() {
    char *video_memory = (char*) 0xB8000;

    for (int i = 0; i < 80 * 25 * 2; i += 2) {
        video_memory[i] = ' ';  
        video_memory[i + 1] = 0x07; 
    }

    for (int i = 0; i < 80 * 25 * 2; i += 2) {
        video_memory[i] = 'K';
        video_memory[i + 1] = 0x07;
    }

    while (1);
}

void _start() {
    kernel_main();
    while (1);
}
