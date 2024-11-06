#include "cuda_example.h"
#include <cuda_runtime.h>

namespace cudaTest
{
/**
 * @brief A kernel function that performs a simple computation on an array of
 * values.
 *
 * @param input The input array containing values to compute.
 * @param output The output array to store the results.
 */
__global__ void testkernel(const int *input, float *output)
{
    *output = static_cast<float>(*input) * 2.5f;
}

float doCalculation(int inputValue)
{
    int *d_input;
    float *d_output;
    int h_input[1] = {inputValue};
    float h_output[1] = {1.0f};

    // Allocate memory on the device
    cudaMalloc(&d_input, sizeof(int));
    cudaMalloc(&d_output, sizeof(float));
    cudaMemcpy(d_input, h_input, sizeof(int), cudaMemcpyHostToDevice);

    // Launch the kernel
    testkernel<<<1, 1>>>(d_input, d_output);

    // Copy the results back to the host
    cudaMemcpy(h_output, d_output, sizeof(float), cudaMemcpyDeviceToHost);

    // Free device memory
    cudaFree(d_input);
    cudaFree(d_output);
    float result = h_output[0];
    return result;
}
} // namespace cudaTest