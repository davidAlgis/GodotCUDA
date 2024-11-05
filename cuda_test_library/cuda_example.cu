#include "cuda_example.h"
#include <cuda_runtime.h>

namespace cudaTest
{
/**
 * @brief A kernel function that performs a heavy computation on an array of
 * values.
 *
 * This kernel squares each element in the input array and stores the result in
 * the output array. Each thread is responsible for computing the square of a
 * single element, allowing for parallel computation across multiple threads.
 *
 * @param input The input array containing values to compute.
 * @param output The output array to store the results.
 * @param size The number of elements in the input/output arrays.
 */
__global__ void computeHeavyKernel(const int *input, float *output, int size)
{
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    if (idx < size)
    {
        output[idx] =
            static_cast<float>(input[idx]) * input[idx]; // Square the value
    }
}

/**
 * @brief A function that performs a heavy calculation using CUDA.
 *
 * This function takes an integer as input and initializes a large array with
 * this value, then uses CUDA to compute the square of each element in the array
 * in parallel. The results are copied back to the host, and the sum of all
 * elements in the output array is returned as the result.
 *
 * @param inputValue The integer value used to populate the input array.
 * @return The sum of all squared values in the output array.
 */
float doCalculation(int inputValue)
{
    const int arraySize = 1024;
    int hostInput[arraySize];
    float hostOutput[arraySize] = {0};
    int *deviceInput;
    float *deviceOutput;

    // Initialize the input array on the host
    for (int i = 0; i < arraySize; ++i)
    {
        hostInput[i] = inputValue;
    }

    // Allocate memory on the device
    cudaMalloc(&deviceInput, arraySize * sizeof(int));
    cudaMalloc(&deviceOutput, arraySize * sizeof(float));

    // Copy the host input array to the device
    cudaMemcpy(deviceInput, hostInput, arraySize * sizeof(int),
               cudaMemcpyHostToDevice);

    // Launch the kernel with enough threads to cover all elements
    int threadsPerBlock = 256;
    int blocksPerGrid = (arraySize + threadsPerBlock - 1) / threadsPerBlock;
    computeHeavyKernel<<<blocksPerGrid, threadsPerBlock>>>(
        deviceInput, deviceOutput, arraySize);

    // Copy the results back to the host
    cudaMemcpy(hostOutput, deviceOutput, arraySize * sizeof(float),
               cudaMemcpyDeviceToHost);

    // Free device memory
    cudaFree(deviceInput);
    cudaFree(deviceOutput);

    // Sum all results
    float result = 0.0f;
    for (int i = 0; i < arraySize; ++i)
    {
        result += hostOutput[i];
    }

    return result;
}
} // namespace cudaTest