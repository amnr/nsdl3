##  Pen event definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from sdl3mouse import MouseID

type
  PenID* = distinct uint32
    ##  `PenIDs` identify pens uniquely within a session.

type
  PenInputFlags* = distinct uint32
    ##  Pen input flags.

const
  PEN_INPUT_DOWN*         = PenInputFlags 1u shl 0
  PEN_INPUT_BUTTON_1*     = PenInputFlags 1u shl 1
  PEN_INPUT_BUTTON_2*     = PenInputFlags 1u shl 2
  PEN_INPUT_BUTTON_3*     = PenInputFlags 1u shl 3
  PEN_INPUT_BUTTON_4*     = PenInputFlags 1u shl 4
  PEN_INPUT_BUTTON_5*     = PenInputFlags 1u shl 5
  PEN_INPUT_ERASER_TIP*   = PenInputFlags 1u shl 30

type
  PenAxis* {.size: cint.sizeof.} = enum
    ##  Pen axis indices.
    PEN_AXIS_PRESSURE
    PEN_AXIS_XTILT
    PEN_AXIS_YTILT
    PEN_AXIS_DISTANCE
    PEN_AXIS_ROTATION
    PEN_AXIS_SLIDER
    PEN_AXIS_TANGENTIAL_PRESSURE

const
  PEN_AXIS_COUNT* = PenAxis.high.int + 1
    ##  Last valid axis index.

# vim: set sts=2 et sw=2:
