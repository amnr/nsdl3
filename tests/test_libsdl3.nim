##  SDL3 ABI functions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

import std/unittest

import nsdl3/libsdl3

test "open library":
  check open_sdl3_library()
  close_sdl3_library()

# vim: set sts=2 et sw=2:
