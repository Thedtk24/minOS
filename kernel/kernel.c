#include "framebuffer.c"

void kernel_main() {
    clear_screen(0x0000FF);  
    draw_pixel(100, 100, 0xFFFFFF); 
}

void _start() {
    kernel_main();
}
