# GodotCUDA

This project demonstrate that it's possible to use [CUDA](https://developer.nvidia.com/cuda-toolkit) directly in Godot. 

This demonstration is based on these two documentation page : [Custom modules in c++](https://docs.godotengine.org/en/latest/contributing/development/core_and_modules/custom_modules_in_cpp.html) and [Binding to external libraries](https://docs.godotengine.org/en/stable/contributing/development/core_and_modules/binding_to_external_libraries.html).

Briefly, I made a C++ module which is my entry point from a custom Godot engine to a simple CUDA library that is in `cuda_test_library` folder. 


## Warning 

I'm not an expert in Godot or SConstruct, so the method used here to integrate CUDA might not be the most efficient. The code and demonstration are quite rough and were only created to prove that CUDA can be used in Godot. If you plan to use this in a real application, I recommend cleaning up the code and procedure.

Finally, this project has been test only on windows 11 and Godot 4.4.

# Installation

Here are the step to follows, to make this module works:

1. Retrieve the source code of [Godot](https://github.com/godotengine/godot.git)

2. Create a folder named `godot_cuda` in the folder `modules\` of Godot sources.

3. Copy the content of this repository in the new folder `modules\godot_cuda`

4. Adapt `SCsub` file in `modules\godot_cuda`. I didn't succeed to make it works with relative path, therefore you need to put your path to the folder `cuda_test_library` of this module on this line: 
```py
env.Append(LIBPATH=['your_path_to_cuda_test_library/cuda_test_library'])
```

5. [Optional] I versioned the binary file of my simple cuda library, but you can generate and compile them manually with [CMake](https://cmake.org/), using these commands lines:
```bash
cmake -B build
cmake --build build --config release
``` 
It's a very simple and "artificial" library that only have one function that multiply by 2.5 with CUDA a given int. But you can replace it by any CUDA calculation.

6. Copy `cudart.lib` (which is normally located in `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.3\lib\x64`) to `cuda_test_library` folder, to make SCons find it. I didn't succeed to make it find directly the library in `CUDA_PATH`.

7. Install SCons the tools for Godot construction, using one of this command line (ensure you have [python](https://www.python.org) and pip in your path first):
```bash
pip install -r "requirements.txt" //this command should be launch from godot_cuda folder
pip install scons
```
8. Execute SCons from Godot source folder, by calling this single line:
```bash
scons
```
It might takes a while (~45 min) for the first execution (it's reconstructing the whole engine in addition of our simple module).

9. Once it has finish, copy `cuda_plugin.dll` located in `cuda_test_library/` to the `bin/` folder of Godot source.

10. In the same way, copy the cuda main library `cudart64_12.dll` (which is by default on windows located at `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.3\bin`) to the `bin/` folder of Godot source. (I didn't succeed to make Godot locate this two library from path, they had to be right next the Godot executable)

11. Open the Godot executable located in `bin/` folder.

12. Create a new project.

13. Add a scene in the project with this script:
```py
extends Node3D

func _ready():
    var s = GodotCUDA.new()
    # simply performs a multiplication by 2.5 from 10
    s.cuda_calculation(10)
    # should print 25
    print(s.get_total())
```

14. Execute the scene, it should print `25`. 

Congratulation Godot is running a CUDA function !

