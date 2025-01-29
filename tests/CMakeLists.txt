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

add_executable(dummy_test)
target_sources(dummy_test PRIVATE main.cpp dummy_test.cpp)
target_link_libraries(dummy_test PRIVATE doctest::doctest)

include(CTest)
include(doctest)
doctest_discover_tests(dummy_test)
