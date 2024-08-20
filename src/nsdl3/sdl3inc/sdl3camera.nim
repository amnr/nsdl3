##  Viceo capture.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

from sdl3pixels import PixelFormatEnum

type
  CameraDeviceID* = distinct uint32
    ##  Unique ID for a camera device.
    ##
    ##  The ID starts at 1. The value 0 is an invalid ID.

  Camera* = ptr object

  CameraSpec* {.final, pure.} = object
    format*   : PixelFormatEnum   ##  Frame format.
    width*    : cint              ##  Frame width.
    height*   : cint              ##  Frame height.
    interval_numerator*   : cint  ##  Frame rate numerator ((dom / num) == fps, (num / dom) == duration).
    interval_denominator* : cint  ##  Frame rate demoninator ((dom / num) == fps, (num / dom) == duration).

  CameraPosition* {.size: cint.sizeof.} = enum
    ##  The position of camera in relation to system device.
    CAMERA_POSITION_UNKNOWN
    CAMERA_POSITION_FRONT_FACING
    CAMERA_POSITION_BACK_FACING

# vim: set sts=2 et sw=2:
