#include <stdio.h>

int main(){
    int input;
    int A[5] = {10, 20, 30, 40, 50};
    
    printf("Enter a number from 0 to 4 to calculate the address of the desired element.\n");
    scanf("%d", &input);
    
   if(input>=0 && input<5){
    int baseArray = (int)&A[0];
    int size = sizeof(A[0]);
    int address = baseArray + 4 * (input - 0);
    printf("Address of A[%d] is: %d\n", input, address);
    printf("Value at A[%d] is: %d\n", input, A[input]);
   }else{
    printf("ERROR\n");
   }
}
// {Address of } A[i] = B + W \times (i - L_B)