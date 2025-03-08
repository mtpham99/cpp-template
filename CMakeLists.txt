cmake_minimum_required(VERSION 3.30)

# https://www.kitware.com/import-std-in-cmake-3-30
# https://github.com/Kitware/CMake/blob/v3.31.3/Help/dev/experimental.rst
set(CMAKE_EXPERIMENTAL_CXX_IMPORT_STD "0e5b6991-d74f-4b3d-a41c-cf096e0b2508")
set(CMAKE_CXX_MODULE_STD ON)

project(
  hello-world
  VERSION 0.1.0
  LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(hello)
add_library(hello::hello ALIAS hello)
target_sources(
  hello
  PUBLIC FILE_SET
         CXX_MODULES
         BASE_DIRS
         ${PROJECT_SOURCE_DIR}/src
         FILES
         ${PROJECT_SOURCE_DIR}/src/hello.cppm)

option(BUILD_EXAMPLES "Build examples" OFF)
if(BUILD_EXAMPLES)
  add_subdirectory(${PROJECT_SOURCE_DIR}/examples)
endif()

option(BUILD_TESTS "Build tests" OFF)
if(BUILD_TESTS)
  add_subdirectory(${PROJECT_SOURCE_DIR}/tests)
endif()

option(BUILD_BENCHMARKS "Build benchmarks" OFF)
if(BUILD_BENCHMARKS)
  add_subdirectory(${PROJECT_SOURCE_DIR}/benchmarks)
endif()
