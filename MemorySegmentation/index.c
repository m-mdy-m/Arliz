#include <stdio.h>
#include <stdlib.h>

#define SEGMENT_SIZE 100  // Define segment size
#define SEGMENT_BASE 0x1000  // Define a base address for the segment

// Function to simulate segmented memory access
void access_memory(int offset) {
    // Simulated segment base address and size
    int segment_base = SEGMENT_BASE;
    int segment_size = SEGMENT_SIZE;
    
    // Check if the offset is within the segment bounds
    if (offset < 0 || offset >= segment_size) {
        printf("Error: Segmentation fault! Attempted to access offset %d, which is outside the segment bounds.\n", offset);
        return;
    }
    
    // Calculate the physical address (simulated)
    int physical_address = segment_base + offset;
    printf("Accessing memory at offset %d (physical address: 0x%X)\n", offset, physical_address);
}

int main() {
    printf("Example of memory segmentation and bounds checking:\n");

    // Access within bounds
    access_memory(50);  // Valid access within the segment
    
    // Access outside bounds
    access_memory(150);  // Invalid access, triggers a segmentation fault

    return 0;
}
