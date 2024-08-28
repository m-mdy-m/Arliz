#include <stdio.h>

void assign_value(int value) {
    if (value < -32768 || value > 32767) {
        printf("Error: Value out of range for a 16-bit integer.\n");
    } else {
        short int num = value; // Assigning value to a 16-bit integer
        printf("Assigned value: %d\n", num);
    }
}

int main() {
    int value = 40000;
    assign_value(value); // This should trigger the error
    return 0;
}