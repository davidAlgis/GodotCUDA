#include "godot_cuda.h"

void GodotCUDA::add(int p_value) {
	count += p_value;
}

void GodotCUDA::reset() {
	count = 0;
}

int GodotCUDA::get_total() const {
	return count;
}

void GodotCUDA::_bind_methods() {
	ClassDB::bind_method(D_METHOD("add", "value"), &GodotCUDA::add);
	ClassDB::bind_method(D_METHOD("reset"), &GodotCUDA::reset);
	ClassDB::bind_method(D_METHOD("get_total"), &GodotCUDA::get_total);
}

GodotCUDA::GodotCUDA() {
	count = 0;
}