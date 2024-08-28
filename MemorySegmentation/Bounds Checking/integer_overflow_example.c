#include <stdio.h>
#include <limits.h>

int main() {
    unsigned char num = UCHAR_MAX; // Max value for unsigned char (255)
    printf("Initial value: %u\n", num);
    
    num += 1; // This will cause an overflow and wrap around to 0
    printf("After overflow: %u\n", num);
    
    return 0;
}
