cmake_minimum_required(VERSION 3.18)
project(cuda_plugin LANGUAGES CXX CUDA)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CUDA_STANDARD 14)

add_library(cuda_plugin SHARED cuda_example.cu)

set_target_properties(cuda_plugin PROPERTIES
    CUDA_SEPARABLE_COMPILATION ON
    CUDA_ARCHITECTURES 52
)

target_include_directories(cuda_plugin PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
