#include <stdio.h>
#include "array.h"
/**
- Implement a static array in C where the size is fixed at compile time.
-  Add bounds checking to prevent out-of-bounds access.
-  The array should allow for basic operations like:
    - insertion,
    - deletion, and 
    - retrieval.
-  Implement a simple program where the user can interactively choose operations on the array (e.g., insert an element, retrieve an element, etc.).
-  Implement custom error handling for out-of-bounds access and demonstrate how different types of memory issues (e.g., stack overflow, segmentation faults) might arise when bounds checking is not in place.
*/
int main() {
    StaticArray arr = initial();  // Initialize the static array

    int choice, value, index;

    while (1) {
        // Display menu
        printf("Choose an operation:\n");
        printf("1. Push\n");
        printf("2. Pop\n");
        printf("3. Insert\n");
        printf("4. Retrieve\n");
        printf("5. Display\n");
        printf("6. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1: // Push
                printf("Enter a value to push: ");
                scanf("%d", &value);
                push(&arr, value);
                break;
            case 2: // Pop
                value = pop(&arr);
                if (value != -1) {
                    printf("Popped value: %d\n", value);
                }
                break;
            case 3: // Insert
                printf("Enter index and value to insert: ");
                scanf("%d %d", &index, &value);
                insert(&arr, index, value);
                break;
            case 4: // Retrieve
                printf("Enter index to retrieve: ");
                scanf("%d", &index);
                value = retrieve(&arr, index);
                if (value != -1) {
                    printf("Retrieved value: %d\n", value);
                }
                break;
            case 5: // Display
                display(&arr);
                break;
            case 6: // Exit
                printf("Exiting program...\n");
                return 0;
            default:
                printf("Invalid choice, try again.\n");
        }
    }

    return 0;
}
