#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

__global__ void hello(char* d_buf)
{
    char str[] = "Hello";
    for(int i = 0; i < 6; i++) {
        d_buf[i] = str[i];
    }
}

int main(int argc, char* argv[])
{
    char buf[100];
    char *d_buf;

    cudaMalloc((void **) &d_buf, 100);

    hello<<<1, 1>>>(d_buf);

    cudaMemcpy(buf, d_buf, 100, cudaMemcpyDeviceToHost);
    cudaFree(d_buf);

    printf("%s\n", buf);

    cudaDeviceReset();

    return 0;
}
