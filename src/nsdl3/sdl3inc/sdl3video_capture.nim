##  Video capture.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from pixels import PixelFormatEnum

type
  VideoCaptureDeviceID* = distinct uint32
    ##  Capture device ID. Starts at 1. Value 0 == invalid ID.

  VideoCaptureDevice* = ptr object

const
  VIDEO_CAPTURE_ALLOW_ANY_CHANGE* = 1

type
  VideoCaptureSpec* {.final, pure.} = object
    format*   : PixelFormatEnum   ##  `PixelFormatEnum` format.
    width*    : cint              ##  Frame width.
    height*   : cint              ##  Frame height.

  VideoCaptureStatus {.size: cint.sizeof.} = enum
    ##  Video Capture Status.
    VIDEO_CAPTURE_FAIL = -1
    VIDEO_CAPTURE_INIT = 0
    VIDEO_CAPTURE_STOPPED
    VIDEO_CAPTURE_PLAYING

  VideoCaptureFrame* {.final, pure.} = object
    timestamp_ns* : uint64          ##  Frame timestamp (ns).
    num_planes*   : cint            ##  Number of planes.
    data*         : array[3, byte]  ##  Pointer to data of i-th plane.
    pitch*        : array[3, cint]  ##  Pitch of i-th plane.
    internal      : pointer         ##  Private.

# vim: set sts=2 et sw=2:
