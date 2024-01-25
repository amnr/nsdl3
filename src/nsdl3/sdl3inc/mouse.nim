##  Mouse event definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  MouseID* = distinct uint32

  Cursor* = ptr object
    ##  Cursor.

  SystemCursor* {.size: cint.sizeof.} = enum
    ##  Cursor types for `create_system_cursor()`.
    SYSTEM_CURSOR_ARROW
    SYSTEM_CURSOR_IBEAM
    SYSTEM_CURSOR_WAIT
    SYSTEM_CURSOR_CROSSHAIR
    SYSTEM_CURSOR_WAITARROW
    SYSTEM_CURSOR_SIZENWSE
    SYSTEM_CURSOR_SIZENESW
    SYSTEM_CURSOR_SIZEWE
    SYSTEM_CURSOR_SIZENS
    SYSTEM_CURSOR_SIZEALL
    SYSTEM_CURSOR_NO
    SYSTEM_CURSOR_HAND
    SYSTEM_CURSOR_WINDOW_TOPLEFT
    SYSTEM_CURSOR_WINDOW_TOP
    SYSTEM_CURSOR_WINDOW_TOPRIGHT
    SYSTEM_CURSOR_WINDOW_RIGHT
    SYSTEM_CURSOR_WINDOW_BOTTOMRIGHT
    SYSTEM_CURSOR_WINDOW_BOTTOM
    SYSTEM_CURSOR_WINDOW_BOTTOMLEFT
    SYSTEM_CURSOR_WINDOW_LEFT

const
  SDL_NUM_SYSTEM_CURSORS* = SYSTEM_CURSOR_WINDOW_LEFT.int + 1

type
  MouseWheelDirection* {.size: cint.sizeof.} = enum
    ##  Scroll event scroll direction types.
    MOUSEWHEEL_NORMAL
    MOUSEWHEEL_FLIPPED

# Used as a mask when testing buttons in buttonstate.
#
# - Button 1:  Left mouse button.
# - Button 2:  Middle mouse button.
# - Button 3:  Right mouse button.

func button(x: uint32): uint32 {.compiletime.} =
  1'u32 shl (x - 1)

const
  BUTTON_LEFT*    = 1
  BUTTON_MIDDLE*  = 2
  BUTTON_RIGHT*   = 3
  BUTTON_X1*      = 4
  BUTTON_X2*      = 5
  BUTTON_LMASK*   = button BUTTON_LEFT
  BUTTON_MMASK*   = button BUTTON_MIDDLE
  BUTTON_RMASK*   = button BUTTON_RIGHT
  BUTTON_X1MASK*  = button BUTTON_X1
  BUTTON_X2MASK*  = button BUTTON_X2

# vim: set sts=2 et sw=2:
