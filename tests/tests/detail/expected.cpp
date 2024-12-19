// Copyright (c) 2024 Bronek Kozicki
//
// Distributed under the ISC License. See accompanying file LICENSE.md
// or copy at https://opensource.org/licenses/ISC

#include "functional/detail/expected.hpp"

#include <catch2/catch_all.hpp>

enum Error { unknown };

TEST_CASE("expected_polyfill", "[expected][polyfill][cxx20compat]")
{
  using T = fn::detail::expected<int, Error>;
  SUCCEED();
}
