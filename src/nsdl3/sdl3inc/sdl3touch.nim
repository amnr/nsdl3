##  Touch event definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from sdl3mouse import MouseID

type
  TouchID*  = uint64
    ##  A unique ID for a touch device.

  FingerID* = uint64
    ##  A unique ID for a single finger on a touch device.

  TouchDeviceType* {.size: cint.sizeof.} = enum
    ##  An enum that describes the type of a touch device.
    TOUCH_DEVICE_INVALID  = -1
    TOUCH_DEVICE_DIRECT
    TOUCH_DEVICE_INDIRECT_ABSOLUTE
    TOUCH_DEVICE_INDIRECT_RELATIVE

  Finger* {.final, pure.} = object
    id*:        FingerID
    x*:         cfloat
    y*:         cfloat
    pressure*:  cfloat

const
  TOUCH_MOUSEID*  = cast[MouseID](-1'i32)
    ##  Device ID for mouse events simulated with touch input.

  MOUSE_TOUCHID*  = cast[TouchID](-1'i64)
    ##  Touch ID for touch events simulated with mouse input.

# vim: set sts=2 et sw=2:
