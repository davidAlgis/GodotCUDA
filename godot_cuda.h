#pragma once
#include "core/object/ref_counted.h"

class GodotCUDA : public RefCounted
{
    GDCLASS(GodotCUDA, RefCounted);

    float count;

    protected:
    static void _bind_methods();

    public:
    void cuda_calculation(int p_value);
    void reset();
    float get_total() const;

    GodotCUDA();
};