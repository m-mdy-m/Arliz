#include <stdio.h>

int main() {
    // Define an array of integers
    int A[] = {10, 20, 30, 40, 50};
    int sum = 0;
    
    // Define a pointer to the start of the array (acts like an index register)
    int *ptr = A;
    
    // Define the number of elements in the array
    int n = sizeof(A) / sizeof(A[0]);

    // Use the pointer to sum the array elements
    for (int i = 0; i < n; i++) {
        sum += *ptr;   // Indirect addressing: accessing the value at the address stored in ptr
        ptr++;         // Increment the pointer to move to the next array element
    }

    // Output the result
    printf("Sum of array elements: %d\n", sum);

    return 0;
}
