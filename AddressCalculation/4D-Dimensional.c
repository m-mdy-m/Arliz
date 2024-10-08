#include <stdio.h>

int main() {
    int w = 1; 
    int L[4] = {0, 0, 0, 0}; 
    int N[4] = {3, 3, 3, 3}; 

    int A[3][3][3][3] = {
        {
            {
                {1, 2, 3}, {4, 5, 6}, {7, 8, 9}
            },
            {
                {10, 11, 12}, {13, 14, 15}, {16, 17, 18}
            },
            {
                {19, 20, 21}, {22, 23, 24}, {25, 26, 27}
            }
        },
        {
            {
                {28, 29, 30}, {31, 32, 33}, {34, 35, 36}
            },
            {
                {37, 38, 39}, {40, 41, 42}, {43, 44, 45}
            },
            {
                {46, 47, 48}, {49, 50, 51}, {52, 53, 54}
            }
        },
        {
            {
                {55, 56, 57}, {58, 59, 60}, {61, 62, 63}
            },
            {
                {64, 65, 66}, {67, 68, 69}, {70, 71, 72}
            },
            {
                {73, 74, 75}, {76, 77, 78}, {79, 80, 81}
            }
        }
    };

    int baseAddress = (int)&A[0][0][0][0];
    int elementSize = sizeof(A[0][0][0][0]);

    for (int i = 0; i < N[0]; i++) {
        for (int j = 0; j < N[1]; j++) {
            for (int k = 0; k < N[2]; k++) {
                for (int l = 0; l < N[3]; l++) {
                    int address = baseAddress + elementSize * (
                        (i - L[0]) * N[1] * N[2] * N[3] +
                        (j - L[1]) * N[2] * N[3] +
                        (k - L[2]) * N[3] +
                        (l - L[3])
                    );
                    printf("Address of A[%d][%d][%d][%d] = %d (Value = %d)\n", i, j, k, l, address, A[i][j][k][l]);
                }
            }
        }
    }

    return 0;
}
