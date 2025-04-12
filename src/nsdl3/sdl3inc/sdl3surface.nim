##  Surface definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from sdl3pixels import PixelFormatEnum

type
  SurfaceFlags* = distinct uint32
    ##  Surface flags.

func `and`(a, b: SurfaceFlags): SurfaceFlags {.borrow.}
func `or`*(a, b: SurfaceFlags): SurfaceFlags {.borrow.}

func `==`*(a: SurfaceFlags, b: uint32): bool {.borrow.}

const
  SURFACE_DEFAULT*        = SurfaceFlags 0
  SURFACE_PREALLOCATED*   = SurfaceFlags 0x00000001
  SURFACE_LOCK_NEEDED*    = SurfaceFlags 0x00000002
  SURFACE_LOCKED*         = SurfaceFlags 0x00000004
  SURFACE_SIMD_ALIGNED*   = SurfaceFlags 0x00000008

# Note: mustlock moved after Surface.

type
  BlitMap* {.final, incompletestruct, pure.} = object
    ##  Blit map.

  ScaleMode* {.size: cint.sizeof.} = enum
    ##  Textture scaling mode.
    SCALEMODE_INVALID = -1
    SCALEMODE_NEAREST       ##  Nearest pixel sampling.
    SCALEMODE_LINEAR        ##  Linear filtering.

  FlipMode* {.size: cint.sizeof.} = enum
    ##  The flip mode.
    FLIP_NONE               ##  Do not flip.
    FLIP_HORIZONTAL         ##  Flip horizontally.
    FLIP_VERTICAL           ##  Flip vertically.

type
  Surface* {.bycopy, final, pure.} = object
    ##  Surface.
    ##
    ##  Note::
    ##    This structure should be treated as read-only, except for pixels,
    ##    which, if not `nil`
    ## , contains the raw pixel data for the surface.
    flags*        : SurfaceFlags                ##  Read-only.
    format*       : PixelFormatEnum             ##  Read-only.
    w*            : cint                        ##  Read-only.
    h*            : cint                        ##  Read-only.
    pitch*        : cint                        ##  Read-only.
    pixels*       : ptr UncheckedArray[byte]    ##  Read-write.
    refcount      : cint
    internal      : ptr SurfaceData

  SurfaceData {.final, incompletestruct, pure.} = object

  SurfacePtr* = ptr Surface
    ##  Surface.

func pixels16*(self: ptr Surface): ptr UncheckedArray[uint16] {.inline.} =
  ##  `Surface` pixels as unchecked array of `uint16`.
  cast[ptr UncheckedArray[uint16]](self.pixels)

func pixels32*(self: ptr Surface): ptr UncheckedArray[uint32] {.inline.} =
  ##  `Surface` pixels as unchecked array of `uint32`.
  cast[ptr UncheckedArray[uint32]](self.pixels)

func mustlock*(self: ptr Surface): bool {.inline.} =
  ##  Evaluates to true if the surface needs to be locked before access.
  (self.flags and SURFACE_LOCK_NEEDED) != 0

type
  PropSurface* = enum
    PROP_SURFACE_COLORSPACE_NUMBER        = cstring"SDL.surface.colorspace"
    PROP_SURFACE_SDR_WHITE_POINT_FLOAT    = cstring"SDL.surface.SDR_white_point"
    PROP_SURFACE_HDR_HEADROOM_FLOAT       = cstring"SDL.surface.HDR_headroom"
    PROP_SURFACE_TONEMAP_OPERATOR_STRING  = cstring"SDL.surface.tonemap"
    PROP_SURFACE_HOTSPOT_X_NUMBER         = cstring"SDL.surface.hotspot.x"
    PROP_SURFACE_HOTSPOT_Y_NUMBER         = cstring"SDL.surface.hotspot.y"

# vim: set sts=2 et sw=2:
