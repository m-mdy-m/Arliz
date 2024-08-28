#include <stdio.h>
#include <string.h>

int main() {
    char buffer[10];
    strcpy(buffer, "This is a string longer than 10 characters."); // Overflow
    printf("Buffer content: %s\n", buffer); // Unpredictable behavior
    return 0;
}
