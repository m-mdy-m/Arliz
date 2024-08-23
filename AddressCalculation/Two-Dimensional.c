#include <stdio.h>
int main(){
    int A[3][3] = {
        {10, 20, 30},
        {40, 50, 60},
        {70, 80, 90},
    };
    
    int rows = 3;
    int cols = 3;
    // Row Major Order
    printf("Row Major Order Address Calculation:\n");
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int baseAddress = (int)&A[0][0];
            int elementSize = sizeof(A[0][0]);
            int address = baseAddress + elementSize * (cols * i + j);
            printf("Address of A[%d][%d] = %d (Value = %d)\n", i, j, address, A[i][j]);
        }
    }

    // Column Major Order
    printf("\nColumn Major Order Address Calculation:\n");
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int baseAddress = (int)&A[0][0];
            int elementSize = sizeof(A[0][0]);
            int address = baseAddress + elementSize * (i + rows * j);
            printf("Address of A[%d][%d] = %d (Value = %d)\n", i, j, address, A[i][j]);
        }
    }
}
/**                     Row Major Order:                      */
/** Address of A[i][j] = B + W * [ N * (i - L_r) + (j - L_c)] */
/**                     Column Major Order:                   */
/** Address of A[i][j] = B + W * [ (i - L_r) + M * (j - L_c)] */
