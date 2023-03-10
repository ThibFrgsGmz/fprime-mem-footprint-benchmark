####
# 'App' Deployment:
#
# This sets up the build for the 'App' Application, including the custom reference
# components. In addition, it imports FPrime.cmake, which includes the core F Prime
# components.
###
cmake_minimum_required(VERSION 3.13)
cmake_policy(SET CMP0048 NEW)
project(App VERSION 1.0.0 LANGUAGES C CXX)

## Include all of the F prime core components, and imports the make-system.
include("${FPRIME_FRAMEWORK_PATH}/cmake/FPrime.cmake")
# NOTE: register custom targets between these two lines
include("${FPRIME_FRAMEWORK_PATH}/cmake/FPrime-Code.cmake")

# Includes component subdirectories
include("${CMAKE_CURRENT_LIST_DIR}/App.cmake")

# Add Topology subdirectory
add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/Top/")

set(SOURCE_FILES "${CMAKE_CURRENT_LIST_DIR}/Main.cpp")
set(MOD_DEPS ${PROJECT_NAME}/Top)

set(COMPILER_OPTIMIZATION_FLAGS "-Os")

set(CMAKE_C_FLAGS "${COMPILER_OPTIMIZATION_FLAGS}")
set(CMAKE_CXX_FLAGS "${COMPILER_OPTIMIZATION_FLAGS} -fno-exceptions")
set(CMAKE_CXX_FLAGS "${COMPILER_OPTIMIZATION_FLAGS} -fno-rtti")
set(CMAKE_CXX_FLAGS "${COMPILER_OPTIMIZATION_FLAGS} -ffunction-sections -fdata-sections")
set(CMAKE_CXX_FLAGS "${COMPILER_OPTIMIZATION_FLAGS} -fno-unroll-loops")
set(CMAKE_CXX_FLAGS "${COMPILER_OPTIMIZATION_FLAGS} -fno-jump-tables")

set(CMAKE_EXE_LINKER_FLAGS "-fno-jump-tables")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -flto")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
# Following NOT WORKING : profile count data file not found [-Wmissing-profile]
# set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-generate -fprofile-use")

register_fprime_deployment()
# The following compile options will only apply to the deployment executable.
# The extra warnings trigger in core F Prime so we don't apply them there.
target_compile_options(${PROJECT_NAME} PUBLIC -Wall)
target_compile_options(${PROJECT_NAME} PUBLIC -Wextra)
target_compile_options(${PROJECT_NAME} PUBLIC -Werror)
#target_compile_options(${PROJECT_NAME} PUBLIC -Wshadow)
target_compile_options(${PROJECT_NAME} PUBLIC -Wconversion)
target_compile_options(${PROJECT_NAME} PUBLIC -Wsign-conversion)
target_compile_options(${PROJECT_NAME} PUBLIC -Wformat-security)
target_compile_options(${PROJECT_NAME} PUBLIC -Wnon-virtual-dtor)
target_compile_options(${PROJECT_NAME} PUBLIC -Wold-style-cast)
target_compile_options(${PROJECT_NAME} PUBLIC -Woverloaded-virtual)
target_compile_options(${PROJECT_NAME} PUBLIC -Wno-unused-parameter)
target_compile_options(${PROJECT_NAME} PUBLIC -Wundef)

set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 11)
