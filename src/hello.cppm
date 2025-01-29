export module hello;

import std;

namespace hello {

inline auto
hi() -> std::string_view
{
  using namespace std::string_view_literals;
  return "Hello, World!\n"sv;
}

} // namespace hello
