##  Desktop related functions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

import ../../nsdl3

proc get_desktop_size*(width, height: var int, desktop_index = 0): bool =
  ##  Return usable desktop size.
  ##
  ##  This function return total desktop size prior to SDL 2.0.5.
  GetDisplayUsableBounds(desktop_index, width, height)

# vim: set sts=4 et sw=4:
