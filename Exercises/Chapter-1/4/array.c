#include <stdio.h>
#include <stdlib.h>
#include "array.h"
StaticArray initial() {
    StaticArray arr;
    arr.size = 0;
    return arr;
}
void push(StaticArray *arr, int value) {
    if (arr->size < MAX_SIZE) {
        arr->array[arr->size] = value;
        arr->size++;
    } else {
        printf("Error: Array is full, cannot push element %d\n", value);
    }
}
int pop(StaticArray *arr) {
    if (arr->size > 0) {
        arr->size--;
        return arr->array[arr->size];
    } else {
        printf("Error: Array is empty, cannot pop element\n");
        return -1;  // Return -1 to signify error (or another error code)
    }
}
void insert(StaticArray *arr, int index, int value) {
    if (index < 0 || index > arr->size || arr->size == MAX_SIZE) {
        printf("Error: Index out of bounds or array is full\n");
        return;
    }
    for (int i = arr->size; i > index; i--) {
        arr->array[i] = arr->array[i - 1];
    }
    arr->array[index] = value;
    arr->size++;
}
int retrieve(StaticArray *arr, int index) {
    if (index < 0 || index >= arr->size) {
        printf("Error: Index out of bounds\n");
        return -1;
    }
    return arr->array[index];
}
void display(StaticArray *arr) {
    if (arr->size == 0) {
        printf("Array is empty\n");
        return;
    }
    printf("Array: ");
    for (int i = 0; i < arr->size; i++) {
        printf("%d ", arr->array[i]);
    }
    printf("\n");
}
