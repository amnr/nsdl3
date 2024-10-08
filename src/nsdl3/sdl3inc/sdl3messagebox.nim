##  Message box definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from sdl3video import Window

type
  MessageBoxFlags* {.size: uint32.sizeof.} = distinct uint32

func `+`*(a, b: MessageBoxFlags): MessageBoxFlags {.borrow.}
func `or`*(a, b: MessageBoxFlags): MessageBoxFlags {.borrow.}

const
  MESSAGEBOX_ERROR*                 = MessageBoxFlags 0x00000010  ##  Error dialog.
  MESSAGEBOX_WARNING*               = MessageBoxFlags 0x00000020  ##  Warning dialog.
  MESSAGEBOX_INFORMATION*           = MessageBoxFlags 0x00000040  ##  Informational dialog.
  MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT* = MessageBoxFlags 0x00000080  ##  Buttons placed left to right.
  MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT* = MessageBoxFlags 0x00000100  ##  Buttons placed right to left.

type
  MessageBoxButtonFlags* {.size: uint32.sizeof.} = distinct uint32

const
  MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT*  = MessageBoxButtonFlags 0x00000001  ##  Default button when return is hit.
  MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT*  = MessageBoxButtonFlags 0x00000002  ##  Default button when escape is hit.

type
  MessageBoxButtonData* {.final, pure.} = object
    ##  Individual button data.
    flags*      : MessageBoxButtonFlags   ##  `MessageBoxButtonFlags`.
    buttonid*   : cint                    ##  User defined button ID (returned by `ShowMessageBox`).
    text*       : cstring                 ##  Button text (UTF-8).

  MessageBoxColor* {.final, pure.} = object
    ##  Message box color.
    r*:   byte
    g*:   byte
    b*:   byte

  MessageBoxColorType* {.size: cint.sizeof.} = enum
    MESSAGEBOX_COLOR_BACKGROUND
    MESSAGEBOX_COLOR_TEXT
    MESSAGEBOX_COLOR_BUTTON_BORDER
    MESSAGEBOX_COLOR_BUTTON_BACKGROUND
    MESSAGEBOX_COLOR_BUTTON_SELECTED

const
  MESSAGEBOX_COLOR_COUNT* = MessageBoxColorType.high.int + 1

type
  MessageBoxColorScheme* {.final, pure.} = object
    ##  Colors for message box dialogs.
    colors*       : array[MESSAGEBOX_COLOR_COUNT, MessageBoxColor]

  MessageBoxData* {.final, pure.} = object
    ##  MessageBox data.
    flags*        : MessageBoxFlags             ##  `MessageBoxFlags`.
    window*       : Window                      ##  Parent window or `nil`.
    title*        : cstring                     ##  Title (UTF-8).
    message*      : cstring                     ##  Message text (UTF-8).

    numbuttons*   : cint
    buttons*      : ptr MessageBoxButtonData    ## Read only.

    color_scheme* : ptr MessageBoxColorScheme   ## Read only.

# vim: set sts=2 et sw=2:
