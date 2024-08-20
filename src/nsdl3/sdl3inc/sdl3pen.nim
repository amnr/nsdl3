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

#define SDL_PEN_INPUT_DOWN       (1u << 0)  /**< & to see if pen is pressed down */
#define SDL_PEN_INPUT_BUTTON_1   (1u << 1)  /**< & to see if button 1 is pressed */
#define SDL_PEN_INPUT_BUTTON_2   (1u << 2)  /**< & to see if button 2 is pressed */
#define SDL_PEN_INPUT_BUTTON_3   (1u << 3)  /**< & to see if button 3 is pressed */
#define SDL_PEN_INPUT_BUTTON_4   (1u << 4)  /**< & to see if button 4 is pressed */
#define SDL_PEN_INPUT_BUTTON_5   (1u << 5)  /**< & to see if button 5 is pressed */
#define SDL_PEN_INPUT_ERASER_TIP (1u << 30) /**< & to see if eraser tip is used */

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
  PEN_NUM_AXES* = PenAxis.high.int + 1
    ##  Last valid axis index.

# vim: set sts=2 et sw=2:
