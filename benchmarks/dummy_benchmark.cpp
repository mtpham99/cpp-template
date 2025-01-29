#include <doctest/doctest.h>
#include <nanobench.h>

TEST_CASE("dummy")
{
  ankerl::nanobench::Bench b{};
  b.relative(true);
  b.performanceCounters(true);
  b.title("dummy");
  b.unit("op");

  auto x = 0;

  b.run("pre-increment", [&]() { b.doNotOptimizeAway(++x); });
  b.run("post-increment", [&]() { b.doNotOptimizeAway(x++); });
}
