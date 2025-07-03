cmake_minimum_required(VERSION 3.22)

# Setup cmake module path and compiler settings
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
message("Build type: "              ${CMAKE_BUILD_TYPE})
set(CMAKE_C_STANDARD                11)
set(CMAKE_C_STANDARD_REQUIRED       ON)
set(CMAKE_C_EXTENSIONS              ON)
set(CMAKE_CXX_STANDARD              17)
set(CMAKE_CXX_STANDARD_REQUIRED     ON)
set(CMAKE_CXX_EXTENSIONS            ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS	ON)
set(CMAKE_TOOLCHAIN_FILE	gcc-arm-none-eabi)

# Project Name    --- MUST EDIT ---
project(stm32f429zit-cmake)


enable_language(C CXX ASM)

set(PROJ_PATH                       ${PROJECT_SOURCE_DIR})

# Linker File     --- MUST EDIT ---
set(linker_script_SRC               ${PROJ_PATH}/Core/STM32F429ZITX_FLASH.ld)
set(EXECUTABLE                      ${CMAKE_PROJECT_NAME})

# MCU Parameters - I am storing all created profiles. Pick one to use.
# include(STM32G431xx_HAL_PARA)
include(STM32F429xx_HAL_PARA)

if(NOT CPU_PARAMETERS)
	message(FATAL_ERROR "CPU_PARAMETERS not set. Check HAL_PARA file.")
endif()

# USE ./getIncludeList.sh and ./getSourceList.sh to generate file list
# Include List, Source List, and MCU Sepecific Setting
# Must Update these files in cmake/ when adding new source files
include(SourceList)
include(IncludeList)

# Executable files
add_executable(${EXECUTABLE} ${source_list})

# Include paths
target_include_directories(${EXECUTABLE} PRIVATE ${include_list})

# Project symbols
target_compile_definitions(${EXECUTABLE} PRIVATE ${compiler_define})

# Compiler options
target_compile_options(${EXECUTABLE} PRIVATE
	${CPU_PARAMETERS}
	-Wall
	-Wpedantic
	-Wno-unused-parameter
)
# ------------
# # Add executable with source files only
# add_executable(STM32F429ZI-DISC ${source_list})

# # Add include directories separately
# target_include_directories(STM32F429ZI-DISC PRIVATE ${include_list})
# ------------

# Linker options
target_link_libraries(${EXECUTABLE} PRIVATE
	c
	m
	stdc++
	supc++
)
target_link_options(${EXECUTABLE} PRIVATE
	-T${linker_script_SRC}
	${CPU_PARAMETERS}
	-Wl,-Map=${CMAKE_PROJECT_NAME}.map
	--specs=nosys.specs
	#-u _printf_float                # STDIO float formatting support
	-Wl,--start-group
	-Wl,--end-group
	-Wl,--print-memory-usage
)

#Setup testing
#enable_testing()
#find_package(GTest REQUIRED)
#include_directories(${GTEST_INCLUDE_DIR})

include(FetchContent)
FetchContent_Declare(
  googletest
   URL https://github.com/google/googletest/archive/refs/heads/main.zip
   # URL https://github.com/google/googletest.git
   GIT_TAG main
)
FetchContent_MakeAvailable(googletest)


#Setup testing
include(GoogleTest)
enable_testing()
#add_executable(Tests dummy.cpp)
#gtest_discover_tests(Application/Tests)
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIR})
target_link_libraries(Application/Tests PRIVATE gtest pthread gtest_main)
add_subdirectory(Application/Tests)
# Execute post-build to print size
add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
	COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${EXECUTABLE}>
)

# Convert output to hex and binary
add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
	COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${EXECUTABLE}> ${EXECUTABLE}.hex
)

# Convert to bin file -> add conditional check?
add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
	COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${EXECUTABLE}> ${EXECUTABLE}.bin
)

