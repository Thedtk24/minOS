#include <stdint.h>

#define FRAMEBUFFER_BASE 0x3F000000  
#define WIDTH 800
#define HEIGHT 600

volatile uint32_t* framebuffer = (uint32_t*) FRAMEBUFFER_BASE;

void draw_pixel(int x, int y, uint32_t color) {
    int index = y * WIDTH + x;
    framebuffer[index] = color;
}

void clear_screen(uint32_t color) {
    for (int y = 0; y < HEIGHT; y++) {
        for (int x = 0; x < WIDTH; x++) {
            draw_pixel(x, y, color);
        }
    }
}
