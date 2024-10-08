##  Mouse event definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  MouseID* = distinct uint32
    ##  Mouse ID.

  Cursor* = ptr object
    ##  Cursor.

  SystemCursor* {.size: cint.sizeof.} = enum
    ##  Cursor types for `create_system_cursor()`.
    SYSTEM_CURSOR_DEFAULT
    SYSTEM_CURSOR_TEXT
    SYSTEM_CURSOR_WAIT
    SYSTEM_CURSOR_CROSSHAIR
    SYSTEM_CURSOR_PROGRESS
    SYSTEM_CURSOR_NWSE_RESIZE
    SYSTEM_CURSOR_NESW_RESIZE
    SYSTEM_CURSOR_EW_RESIZE
    SYSTEM_CURSOR_NS_RESIZE
    SYSTEM_CURSOR_MOVE
    SYSTEM_CURSOR_NOT_ALLOWED
    SYSTEM_CURSOR_POINTER
    SYSTEM_CURSOR_NW_RESIZE
    SYSTEM_CURSOR_N_RESIZE
    SYSTEM_CURSOR_NE_RESIZE
    SYSTEM_CURSOR_E_RESIZE
    SYSTEM_CURSOR_SE_RESIZE
    SYSTEM_CURSOR_S_RESIZE
    SYSTEM_CURSOR_SW_RESIZE
    SYSTEM_CURSOR_W_RESIZE

const
  SDL_SYSTEM_CURSOR_COUNT* = SystemCursor.high.int + 1

type
  MouseWheelDirection* {.size: cint.sizeof.} = enum
    ##  Scroll event scroll direction types.
    MOUSEWHEEL_NORMAL
    MOUSEWHEEL_FLIPPED

type
  MouseButtonFlags* = distinct uint32
    ##  Bitmask of pressed mouse buttons.

func button_mask(x: MouseButtonFlags): MouseButtonFlags {.compiletime.} =
  MouseButtonFlags 1'u32 shl (x.uint32 - 1)

const
  BUTTON_LEFT*    = MouseButtonFlags 1
  BUTTON_MIDDLE*  = MouseButtonFlags 2
  BUTTON_RIGHT*   = MouseButtonFlags 3
  BUTTON_X1*      = MouseButtonFlags 4
  BUTTON_X2*      = MouseButtonFlags 5
  BUTTON_LMASK*   = button_mask BUTTON_LEFT
  BUTTON_MMASK*   = button_mask BUTTON_MIDDLE
  BUTTON_RMASK*   = button_mask BUTTON_RIGHT
  BUTTON_X1MASK*  = button_mask BUTTON_X1
  BUTTON_X2MASK*  = button_mask BUTTON_X2

# vim: set sts=2 et sw=2:
