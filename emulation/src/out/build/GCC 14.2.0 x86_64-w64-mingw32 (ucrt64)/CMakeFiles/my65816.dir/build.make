# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.21

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"

# The command to remove a file.
RM = "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = C:\github\my65816\emulation\src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)"

# Include any dependencies generated for this target.
include CMakeFiles/my65816.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/my65816.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/my65816.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/my65816.dir/flags.make

CMakeFiles/my65816.dir/decoder.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/decoder.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/decoder.c.obj: ../../../decoder.c
CMakeFiles/my65816.dir/decoder.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/my65816.dir/decoder.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/decoder.c.obj -MF CMakeFiles\my65816.dir\decoder.c.obj.d -o CMakeFiles\my65816.dir\decoder.c.obj -c C:\github\my65816\emulation\src\decoder.c

CMakeFiles/my65816.dir/decoder.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/decoder.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\decoder.c > CMakeFiles\my65816.dir\decoder.c.i

CMakeFiles/my65816.dir/decoder.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/decoder.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\decoder.c -o CMakeFiles\my65816.dir\decoder.c.s

CMakeFiles/my65816.dir/io.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/io.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/io.c.obj: ../../../io.c
CMakeFiles/my65816.dir/io.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/my65816.dir/io.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/io.c.obj -MF CMakeFiles\my65816.dir\io.c.obj.d -o CMakeFiles\my65816.dir\io.c.obj -c C:\github\my65816\emulation\src\io.c

CMakeFiles/my65816.dir/io.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/io.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\io.c > CMakeFiles\my65816.dir\io.c.i

CMakeFiles/my65816.dir/io.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/io.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\io.c -o CMakeFiles\my65816.dir\io.c.s

CMakeFiles/my65816.dir/main.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/main.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/main.c.obj: ../../../main.c
CMakeFiles/my65816.dir/main.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/my65816.dir/main.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/main.c.obj -MF CMakeFiles\my65816.dir\main.c.obj.d -o CMakeFiles\my65816.dir\main.c.obj -c C:\github\my65816\emulation\src\main.c

CMakeFiles/my65816.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/main.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\main.c > CMakeFiles\my65816.dir\main.c.i

CMakeFiles/my65816.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/main.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\main.c -o CMakeFiles\my65816.dir\main.c.s

CMakeFiles/my65816.dir/ram.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/ram.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/ram.c.obj: ../../../ram.c
CMakeFiles/my65816.dir/ram.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/my65816.dir/ram.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/ram.c.obj -MF CMakeFiles\my65816.dir\ram.c.obj.d -o CMakeFiles\my65816.dir\ram.c.obj -c C:\github\my65816\emulation\src\ram.c

CMakeFiles/my65816.dir/ram.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/ram.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\ram.c > CMakeFiles\my65816.dir\ram.c.i

CMakeFiles/my65816.dir/ram.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/ram.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\ram.c -o CMakeFiles\my65816.dir\ram.c.s

CMakeFiles/my65816.dir/rom.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/rom.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/rom.c.obj: ../../../rom.c
CMakeFiles/my65816.dir/rom.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_5) "Building C object CMakeFiles/my65816.dir/rom.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/rom.c.obj -MF CMakeFiles\my65816.dir\rom.c.obj.d -o CMakeFiles\my65816.dir\rom.c.obj -c C:\github\my65816\emulation\src\rom.c

CMakeFiles/my65816.dir/rom.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/rom.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\rom.c > CMakeFiles\my65816.dir\rom.c.i

CMakeFiles/my65816.dir/rom.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/rom.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\rom.c -o CMakeFiles\my65816.dir\rom.c.s

CMakeFiles/my65816.dir/lib65816/cpu.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/lib65816/cpu.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/lib65816/cpu.c.obj: ../../../lib65816/cpu.c
CMakeFiles/my65816.dir/lib65816/cpu.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_6) "Building C object CMakeFiles/my65816.dir/lib65816/cpu.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/lib65816/cpu.c.obj -MF CMakeFiles\my65816.dir\lib65816\cpu.c.obj.d -o CMakeFiles\my65816.dir\lib65816\cpu.c.obj -c C:\github\my65816\emulation\src\lib65816\cpu.c

CMakeFiles/my65816.dir/lib65816/cpu.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/lib65816/cpu.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\lib65816\cpu.c > CMakeFiles\my65816.dir\lib65816\cpu.c.i

CMakeFiles/my65816.dir/lib65816/cpu.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/lib65816/cpu.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\lib65816\cpu.c -o CMakeFiles\my65816.dir\lib65816\cpu.c.s

CMakeFiles/my65816.dir/lib65816/cpuevent.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/lib65816/cpuevent.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/lib65816/cpuevent.c.obj: ../../../lib65816/cpuevent.c
CMakeFiles/my65816.dir/lib65816/cpuevent.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_7) "Building C object CMakeFiles/my65816.dir/lib65816/cpuevent.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/lib65816/cpuevent.c.obj -MF CMakeFiles\my65816.dir\lib65816\cpuevent.c.obj.d -o CMakeFiles\my65816.dir\lib65816\cpuevent.c.obj -c C:\github\my65816\emulation\src\lib65816\cpuevent.c

CMakeFiles/my65816.dir/lib65816/cpuevent.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/lib65816/cpuevent.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\lib65816\cpuevent.c > CMakeFiles\my65816.dir\lib65816\cpuevent.c.i

CMakeFiles/my65816.dir/lib65816/cpuevent.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/lib65816/cpuevent.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\lib65816\cpuevent.c -o CMakeFiles\my65816.dir\lib65816\cpuevent.c.s

CMakeFiles/my65816.dir/lib65816/debugger.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/lib65816/debugger.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/lib65816/debugger.c.obj: ../../../lib65816/debugger.c
CMakeFiles/my65816.dir/lib65816/debugger.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_8) "Building C object CMakeFiles/my65816.dir/lib65816/debugger.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/lib65816/debugger.c.obj -MF CMakeFiles\my65816.dir\lib65816\debugger.c.obj.d -o CMakeFiles\my65816.dir\lib65816\debugger.c.obj -c C:\github\my65816\emulation\src\lib65816\debugger.c

CMakeFiles/my65816.dir/lib65816/debugger.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/lib65816/debugger.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\lib65816\debugger.c > CMakeFiles\my65816.dir\lib65816\debugger.c.i

CMakeFiles/my65816.dir/lib65816/debugger.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/lib65816/debugger.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\lib65816\debugger.c -o CMakeFiles\my65816.dir\lib65816\debugger.c.s

CMakeFiles/my65816.dir/lib65816/dispatch.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/lib65816/dispatch.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/lib65816/dispatch.c.obj: ../../../lib65816/dispatch.c
CMakeFiles/my65816.dir/lib65816/dispatch.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_9) "Building C object CMakeFiles/my65816.dir/lib65816/dispatch.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/lib65816/dispatch.c.obj -MF CMakeFiles\my65816.dir\lib65816\dispatch.c.obj.d -o CMakeFiles\my65816.dir\lib65816\dispatch.c.obj -c C:\github\my65816\emulation\src\lib65816\dispatch.c

CMakeFiles/my65816.dir/lib65816/dispatch.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/lib65816/dispatch.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\lib65816\dispatch.c > CMakeFiles\my65816.dir\lib65816\dispatch.c.i

CMakeFiles/my65816.dir/lib65816/dispatch.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/lib65816/dispatch.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\lib65816\dispatch.c -o CMakeFiles\my65816.dir\lib65816\dispatch.c.s

CMakeFiles/my65816.dir/lib65816/opcodes1.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/lib65816/opcodes1.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/lib65816/opcodes1.c.obj: ../../../lib65816/opcodes1.c
CMakeFiles/my65816.dir/lib65816/opcodes1.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_10) "Building C object CMakeFiles/my65816.dir/lib65816/opcodes1.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/lib65816/opcodes1.c.obj -MF CMakeFiles\my65816.dir\lib65816\opcodes1.c.obj.d -o CMakeFiles\my65816.dir\lib65816\opcodes1.c.obj -c C:\github\my65816\emulation\src\lib65816\opcodes1.c

CMakeFiles/my65816.dir/lib65816/opcodes1.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/lib65816/opcodes1.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\lib65816\opcodes1.c > CMakeFiles\my65816.dir\lib65816\opcodes1.c.i

CMakeFiles/my65816.dir/lib65816/opcodes1.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/lib65816/opcodes1.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\lib65816\opcodes1.c -o CMakeFiles\my65816.dir\lib65816\opcodes1.c.s

CMakeFiles/my65816.dir/lib65816/opcodes2.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/lib65816/opcodes2.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/lib65816/opcodes2.c.obj: ../../../lib65816/opcodes2.c
CMakeFiles/my65816.dir/lib65816/opcodes2.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_11) "Building C object CMakeFiles/my65816.dir/lib65816/opcodes2.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/lib65816/opcodes2.c.obj -MF CMakeFiles\my65816.dir\lib65816\opcodes2.c.obj.d -o CMakeFiles\my65816.dir\lib65816\opcodes2.c.obj -c C:\github\my65816\emulation\src\lib65816\opcodes2.c

CMakeFiles/my65816.dir/lib65816/opcodes2.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/lib65816/opcodes2.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\lib65816\opcodes2.c > CMakeFiles\my65816.dir\lib65816\opcodes2.c.i

CMakeFiles/my65816.dir/lib65816/opcodes2.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/lib65816/opcodes2.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\lib65816\opcodes2.c -o CMakeFiles\my65816.dir\lib65816\opcodes2.c.s

CMakeFiles/my65816.dir/lib65816/opcodes3.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/lib65816/opcodes3.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/lib65816/opcodes3.c.obj: ../../../lib65816/opcodes3.c
CMakeFiles/my65816.dir/lib65816/opcodes3.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_12) "Building C object CMakeFiles/my65816.dir/lib65816/opcodes3.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/lib65816/opcodes3.c.obj -MF CMakeFiles\my65816.dir\lib65816\opcodes3.c.obj.d -o CMakeFiles\my65816.dir\lib65816\opcodes3.c.obj -c C:\github\my65816\emulation\src\lib65816\opcodes3.c

CMakeFiles/my65816.dir/lib65816/opcodes3.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/lib65816/opcodes3.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\lib65816\opcodes3.c > CMakeFiles\my65816.dir\lib65816\opcodes3.c.i

CMakeFiles/my65816.dir/lib65816/opcodes3.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/lib65816/opcodes3.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\lib65816\opcodes3.c -o CMakeFiles\my65816.dir\lib65816\opcodes3.c.s

CMakeFiles/my65816.dir/lib65816/opcodes4.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/lib65816/opcodes4.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/lib65816/opcodes4.c.obj: ../../../lib65816/opcodes4.c
CMakeFiles/my65816.dir/lib65816/opcodes4.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_13) "Building C object CMakeFiles/my65816.dir/lib65816/opcodes4.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/lib65816/opcodes4.c.obj -MF CMakeFiles\my65816.dir\lib65816\opcodes4.c.obj.d -o CMakeFiles\my65816.dir\lib65816\opcodes4.c.obj -c C:\github\my65816\emulation\src\lib65816\opcodes4.c

CMakeFiles/my65816.dir/lib65816/opcodes4.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/lib65816/opcodes4.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\lib65816\opcodes4.c > CMakeFiles\my65816.dir\lib65816\opcodes4.c.i

CMakeFiles/my65816.dir/lib65816/opcodes4.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/lib65816/opcodes4.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\lib65816\opcodes4.c -o CMakeFiles\my65816.dir\lib65816\opcodes4.c.s

CMakeFiles/my65816.dir/lib65816/opcodes5.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/lib65816/opcodes5.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/lib65816/opcodes5.c.obj: ../../../lib65816/opcodes5.c
CMakeFiles/my65816.dir/lib65816/opcodes5.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_14) "Building C object CMakeFiles/my65816.dir/lib65816/opcodes5.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/lib65816/opcodes5.c.obj -MF CMakeFiles\my65816.dir\lib65816\opcodes5.c.obj.d -o CMakeFiles\my65816.dir\lib65816\opcodes5.c.obj -c C:\github\my65816\emulation\src\lib65816\opcodes5.c

CMakeFiles/my65816.dir/lib65816/opcodes5.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/lib65816/opcodes5.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\lib65816\opcodes5.c > CMakeFiles\my65816.dir\lib65816\opcodes5.c.i

CMakeFiles/my65816.dir/lib65816/opcodes5.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/lib65816/opcodes5.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\lib65816\opcodes5.c -o CMakeFiles\my65816.dir\lib65816\opcodes5.c.s

CMakeFiles/my65816.dir/lib65816/table.c.obj: CMakeFiles/my65816.dir/flags.make
CMakeFiles/my65816.dir/lib65816/table.c.obj: CMakeFiles/my65816.dir/includes_C.rsp
CMakeFiles/my65816.dir/lib65816/table.c.obj: ../../../lib65816/table.c
CMakeFiles/my65816.dir/lib65816/table.c.obj: CMakeFiles/my65816.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_15) "Building C object CMakeFiles/my65816.dir/lib65816/table.c.obj"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/my65816.dir/lib65816/table.c.obj -MF CMakeFiles\my65816.dir\lib65816\table.c.obj.d -o CMakeFiles\my65816.dir\lib65816\table.c.obj -c C:\github\my65816\emulation\src\lib65816\table.c

CMakeFiles/my65816.dir/lib65816/table.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/my65816.dir/lib65816/table.c.i"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\github\my65816\emulation\src\lib65816\table.c > CMakeFiles\my65816.dir\lib65816\table.c.i

CMakeFiles/my65816.dir/lib65816/table.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/my65816.dir/lib65816/table.c.s"
	C:\msys64\ucrt64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\github\my65816\emulation\src\lib65816\table.c -o CMakeFiles\my65816.dir\lib65816\table.c.s

# Object files for target my65816
my65816_OBJECTS = \
"CMakeFiles/my65816.dir/decoder.c.obj" \
"CMakeFiles/my65816.dir/io.c.obj" \
"CMakeFiles/my65816.dir/main.c.obj" \
"CMakeFiles/my65816.dir/ram.c.obj" \
"CMakeFiles/my65816.dir/rom.c.obj" \
"CMakeFiles/my65816.dir/lib65816/cpu.c.obj" \
"CMakeFiles/my65816.dir/lib65816/cpuevent.c.obj" \
"CMakeFiles/my65816.dir/lib65816/debugger.c.obj" \
"CMakeFiles/my65816.dir/lib65816/dispatch.c.obj" \
"CMakeFiles/my65816.dir/lib65816/opcodes1.c.obj" \
"CMakeFiles/my65816.dir/lib65816/opcodes2.c.obj" \
"CMakeFiles/my65816.dir/lib65816/opcodes3.c.obj" \
"CMakeFiles/my65816.dir/lib65816/opcodes4.c.obj" \
"CMakeFiles/my65816.dir/lib65816/opcodes5.c.obj" \
"CMakeFiles/my65816.dir/lib65816/table.c.obj"

# External object files for target my65816
my65816_EXTERNAL_OBJECTS =

my65816.exe: CMakeFiles/my65816.dir/decoder.c.obj
my65816.exe: CMakeFiles/my65816.dir/io.c.obj
my65816.exe: CMakeFiles/my65816.dir/main.c.obj
my65816.exe: CMakeFiles/my65816.dir/ram.c.obj
my65816.exe: CMakeFiles/my65816.dir/rom.c.obj
my65816.exe: CMakeFiles/my65816.dir/lib65816/cpu.c.obj
my65816.exe: CMakeFiles/my65816.dir/lib65816/cpuevent.c.obj
my65816.exe: CMakeFiles/my65816.dir/lib65816/debugger.c.obj
my65816.exe: CMakeFiles/my65816.dir/lib65816/dispatch.c.obj
my65816.exe: CMakeFiles/my65816.dir/lib65816/opcodes1.c.obj
my65816.exe: CMakeFiles/my65816.dir/lib65816/opcodes2.c.obj
my65816.exe: CMakeFiles/my65816.dir/lib65816/opcodes3.c.obj
my65816.exe: CMakeFiles/my65816.dir/lib65816/opcodes4.c.obj
my65816.exe: CMakeFiles/my65816.dir/lib65816/opcodes5.c.obj
my65816.exe: CMakeFiles/my65816.dir/lib65816/table.c.obj
my65816.exe: CMakeFiles/my65816.dir/build.make
my65816.exe: CMakeFiles/my65816.dir/linklibs.rsp
my65816.exe: CMakeFiles/my65816.dir/objects1.rsp
my65816.exe: CMakeFiles/my65816.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_16) "Linking C executable my65816.exe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\my65816.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/my65816.dir/build: my65816.exe
.PHONY : CMakeFiles/my65816.dir/build

CMakeFiles/my65816.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles\my65816.dir\cmake_clean.cmake
.PHONY : CMakeFiles/my65816.dir/clean

CMakeFiles/my65816.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" C:\github\my65816\emulation\src C:\github\my65816\emulation\src "C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)" "C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)" "C:\github\my65816\emulation\src\out\build\GCC 14.2.0 x86_64-w64-mingw32 (ucrt64)\CMakeFiles\my65816.dir\DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/my65816.dir/depend

