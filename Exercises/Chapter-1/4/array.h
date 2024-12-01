#ifndef ARRAY_H
#define ARRAY_H
#include <stdio.h>
#include <stdlib.h>

#define MAX_SIZE 10

typedef struct {
    int array[MAX_SIZE];
    int size;
} StaticArray;
StaticArray initial();
void push(StaticArray *arr, int value);
int pop(StaticArray *arr);
void insert(StaticArray *arr, int index, int value);
int retrieve(StaticArray *arr, int index);
void display(StaticArray *arr);

#endif