#include "cuda_example.h"
#include <cuda_runtime.h>

__global__ void computeKernel(float *result)
{
    int idx = threadIdx.x;
    result[idx] = idx * 2.0f; // Simple computation
}

extern "C" float doCalculation()
{
    const int arraySize = 1;
    float hostResult[arraySize] = {0};
    float *deviceResult;

    cudaMalloc((void **)&deviceResult, arraySize * sizeof(float));
    computeKernel<<<1, arraySize>>>(deviceResult);
    cudaMemcpy(hostResult, deviceResult, arraySize * sizeof(float),
               cudaMemcpyDeviceToHost);
    cudaFree(deviceResult);

    return hostResult[0];
}
