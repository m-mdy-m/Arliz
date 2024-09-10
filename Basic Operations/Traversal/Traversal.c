#include <stdio.h>
int main(){
     int arr[2]={1,4};
     int size = sizeof(arr) / sizeof(arr[0]);
     for(int i =0;i<size;i++){
        printf("%d\n", arr[i]);
     }
	return 0;
}
