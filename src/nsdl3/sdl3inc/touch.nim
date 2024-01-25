##  Touch event definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  TouchID*  = uint64
  FingerID* = uint64

  TouchDeviceType* {.size: cint.sizeof.} = enum
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
  TOUCH_MOUSEID*  = cast[uint32](-1'i32)
    ##  Device ID for mouse events simulated with touch input.

  MOUSE_TOUCHID*  = cast[uint64](-1'i64)
    ##  Touch ID for touch events simulated with mouse input.

# vim: set sts=2 et sw=2:
