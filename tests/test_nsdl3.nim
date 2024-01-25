##  SDL3 library wrapper.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

import std/unittest

include nsdl3

test "open library":
  check open_sdl3_library()

  check Init()

  let ver = GetVersion()

  check ver.major == 3

  Quit()
  close_sdl3_library()

# vim: set sts=2 et sw=2:
