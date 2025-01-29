find_package(doctest QUIET)
if(doctest_FOUND)
  message(STATUS "Found system installed \"doctest\". Using system installed library.")
else()
  message(STATUS "\"doctest\" not installed. Fetching from GitHub.")
  include(FetchContent)
  FetchContent_Declare(
    doctest
    GIT_REPOSITORY https://github.com/doctest/doctest.git
    GIT_TAG v2.4.11
    GIT_SHALLOW TRUE)
  FetchContent_MakeAvailable(doctest)
  list(APPEND CMAKE_MODULE_PATH ${doctest_SOURCE_DIR}/scripts/cmake/)
endif()

find_package(nanobench QUIET)
if(nanobench_FOUND)
  message(STATUS "Found system installed \"nanobench\". Using system installed library.")
else()
  message(STATUS "\"nanobench\" not installed. Fetching from GitHub.")
  include(FetchContent)
  FetchContent_Declare(
    nanobench
    GIT_REPOSITORY https://github.com/martinus/nanobench.git
    GIT_TAG v4.3.11
    GIT_SHALLOW TRUE)
  FetchContent_MakeAvailable(nanobench)
endif()

add_executable(dummy_benchmark)
target_sources(dummy_benchmark PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
                                       ${CMAKE_CURRENT_SOURCE_DIR}/dummy_benchmark.cpp)
target_link_libraries(dummy_benchmark PRIVATE doctest::doctest nanobench::nanobench)

include(CTest)
include(doctest)
doctest_discover_tests(dummy_benchmark)
