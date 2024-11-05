#pragma once

#ifdef _WIN32
#define DLL_EXPORT __declspec(dllexport)
#else
#define DLL_EXPORT
#endif

namespace cudaTest
{

extern "C"
{
    /**
     * @brief A function that performs a heavy calculation using CUDA.
     *
     * This function takes an integer as input and initializes a large array
     * with this value, then uses CUDA to compute the square of each element in
     * the array in parallel. The results are copied back to the host, and the
     * sum of all elements in the output array is returned as the result.
     *
     * @param inputValue The integer value used to populate the input array.
     * @return The sum of all squared values in the output array.
     */
    extern "C" DLL_EXPORT float doCalculation(int inputValue);
}
} // namespace cudaTest