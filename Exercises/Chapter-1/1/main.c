#include <stdio.h>
int main(){
    int array_size;
    printf("Enter size of your array: ");
    scanf("%d", &array_size);
    int total_memory = array_size * 4;
    printf("Total memory required = %d bytes\n", total_memory);
    return 0;
}