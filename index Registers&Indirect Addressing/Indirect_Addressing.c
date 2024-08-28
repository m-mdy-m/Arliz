#include <stdio.h>
int main() {
    int A[5] = {10, 20, 30, 40, 50};
    int sum = 0;

    // Pointer to the array's first element
    int *ptr = A;

    // Accessing array elements indirectly using the pointer
    for (int i = 0; i < 5; i++) {
        sum += *(ptr + i);  // Accessing data via pointer arithmetic
    }

    printf("Sum of array elements: %d\n", sum);
    return 0;
}
