#include <stdio.h>

int main() {
    int w = 1;
    int L[5] = {0, 0, 0, 0, 0};
    int N[5] = {2, 2, 2, 2, 2};

    int A[2][2][2][2][2] = {
        {
            {
                {{1, 2}, {3, 4}},
                {{5, 6}, {7, 8}}
            },
            {
                {{9, 10}, {11, 12}},
                {{13, 14}, {15, 16}}
            }
        },
        {
            {
                {{17, 18}, {19, 20}},
                {{21, 22}, {23, 24}}
            },
            {
                {{25, 26}, {27, 28}},
                {{29, 30}, {31, 32}}
            }
        }
    };

    int baseAddress = (int)&A[0][0][0][0][0]; 
    int elementSize = sizeof(A[0][0][0][0][0]);

    for (int i = 0; i < N[0]; i++) {
        for (int j = 0; j < N[1]; j++) {
            for (int k = 0; k < N[2]; k++) {
                for (int l = 0; l < N[3]; l++) {
                    for (int m = 0; m < N[4]; m++) {
                        int address = baseAddress + elementSize * (
                            (i - L[0]) * N[1] * N[2] * N[3] * N[4] +
                            (j - L[1]) * N[2] * N[3] * N[4] +
                            (k - L[2]) * N[3] * N[4] +
                            (l - L[3]) * N[4] +
                            (m - L[4])
                        );
                        printf("Address of A[%d][%d][%d][%d][%d] = %d (Value = %d)\n", i, j, k, l, m, address, A[i][j][k][l][m]);
                    }
                }
            }
        }
    }

    return 0;
}
