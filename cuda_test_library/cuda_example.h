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
     * @brief A function that call a kernel CUDA to multiply by 2.5 the input.
     *
     * @return 2.5*inputValue
     */
    extern "C" DLL_EXPORT float doCalculation(int inputValue);
}
} // namespace cudaTest