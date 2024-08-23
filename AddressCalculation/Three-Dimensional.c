#include <stdio.h>

int main() {
    int x = 3, y = 3, z = 3; 
    int A[3][3][3] = {
        {
            {10, 20, 30},
            {40, 50, 60},
            {70, 80, 90}
        },
        {
            {100, 110, 120},
            {130, 140, 150},
            {160, 170, 180}
        },
        {
            {190, 200, 210},
            {220, 230, 240},
            {250, 260, 270}
        }
    };

    int L_1 = 0, L_2 = 0, L_3 = 0; 
    int n = y; 
    int p = z;

    int baseAddress = (int)&A[0][0][0]; 
    int elementSize = sizeof(A[0][0][0]);
    for (int i = 0; i < x; i++) {
        for (int j = 0; j < y; j++) {
            for (int k = 0; k < z; k++) {
                int address = baseAddress + elementSize * ((i - L_1) * n * p + (j - L_2) * p + (k - L_3));
                printf("Address of A[%d][%d][%d] = %d (Value = %d)\n", i, j, k, address, A[i][j][k]);
            }
        }
    }
}

/*
Address of A[i][j][k] = B + W * [(i - L_1) * n * p + (j - L_2) * p + (k - L_3)]
*/