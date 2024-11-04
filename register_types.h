/* register_types.h */
#pragma once
#include "modules/register_module_types.h"

void initialize_godot_cuda_module(ModuleInitializationLevel p_level);
void uninitialize_godot_cuda_module(ModuleInitializationLevel p_level);
/* yes, the word in the middle must be the same as the module folder name */
