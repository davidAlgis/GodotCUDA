#include "godot_cuda.h"
#include "cuda_test_library/cuda_example.h"

void GodotCUDA::cuda_calculation(int p_value)
{
    count = cudaTest::doCalculation(p_value);
}

void GodotCUDA::reset()
{
    count = 0;
}

float GodotCUDA::get_total() const
{
    return count;
}

void GodotCUDA::_bind_methods()
{
    ClassDB::bind_method(D_METHOD("cuda_calculation", "value"),
                         &GodotCUDA::cuda_calculation);
    ClassDB::bind_method(D_METHOD("get_total"), &GodotCUDA::get_total);
}

GodotCUDA::GodotCUDA()
{
    count = 0;
}