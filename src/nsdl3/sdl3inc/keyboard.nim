##  Keyboard event definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

import keycode
import scancode

type
  Keysym* {.final, pure.} = object
    ##  Keysym.
    scancode*   : Scancode      ##  SDL physical key code.
    sym*        : Keycode       ##  SDL virtual key code.
    `mod`*      : Keymod        ##  Current key modifiers.
    unused      : uint32

# vim: set sts=2 et sw=2:
