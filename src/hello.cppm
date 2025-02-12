#if not defined(USE_IMPORT_STD)
module;

#include <string_view>
#endif

export module hello;

#if defined(USE_IMPORT_STD)
import std;
#endif

namespace hello {

inline auto
hi() -> std::string_view
{
  using namespace std::string_view_literals;
  return "Hello, World!\n"sv;
}

} // namespace hello
