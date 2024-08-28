#include <stdio.h>

int main() {
    int A[5] = {10, 20, 30, 40, 50};
    int sum = 0;
    for (int index = 0; index < 5; index++) {
        sum += A[index];
    }
    printf("Sum of array elements: %d\n", sum);
    return 0;
}
