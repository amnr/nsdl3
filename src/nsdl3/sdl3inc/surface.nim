##  Surface definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from pixels import PixelFormat
from properties import PropertiesID
from rect import Rect

type
  SurfaceFlags* = distinct uint32
    ##  Surface flags.

func `and`(a, b: SurfaceFlags): SurfaceFlags {.borrow.}
func `or`*(a, b: SurfaceFlags): SurfaceFlags {.borrow.}

func `==`*(a: SurfaceFlags, b: uint32): bool {.borrow.}

const
  SWSURFACE*    = SurfaceFlags 0            ##  Just here for compatibility.
  PREALLOC*     = SurfaceFlags 0x00000001   ##  Surface uses prealloc. memory.
  RLEACCEL*     = SurfaceFlags 0x00000002   ##  Surface is RLE encoded.
  DONTFREE*     = SurfaceFlags 0x00000004   ##  Surface is ref. internally.
  SIMD_ALIGNED* = SurfaceFlags 0x00000008   ##  Surface uses aligned memory.
  SURFACE_USES_PROPERTIES*  = SurfaceFlags 0x00000010   ##  Surface uses properties.

# Note: mustlock moved after Surface.

type
  BlitMap* {.final, incompletestruct, pure.} = object
    ##  Blit map.

  ScaleMode* {.size: cint.sizeof.} = enum
    ##  Textture scaling mode.
    SCALEMODE_NEAREST     ##  Nearest pixel sampling.
    SCALEMODE_LINEAR      ##  Linear filtering.
    SCALEMODE_BEST        ##  Anisotropic filtering.

  FlipMode* {.size: cint.sizeof.} = enum
    ##  The flip mode.
    FLIP_NONE           ##  Do not flip.
    FLIP_HORIZONTAL     ##  Flip horizontally.
    FLIP_VERTICAL       ##  Flip vertically.

type
  Surface* {.bycopy, final, pure.} = object
    ##  Surface.
    ##
    ##  Note::
    ##    This structure should be treated as read-only, except for pixels,
    ##    which, if not `nil`
    ## , contains the raw pixel data for the surface.
    flags*        : SurfaceFlags      ##  Read-only.
    format*       : ptr PixelFormat   ##  Read-only.
    w*            : cint              ##  Read-only.
    h*            : cint              ##  Read-only.
    pitch*        : cint              ##  Read-only.
    pixels*       : ptr UncheckedArray[byte]    ##  Read-write.

    # Application data associated with the surface.
    reserved      : pointer           ##  Private.

    # Information needed for surfaces requiring locks.
    locked*       : cint              ##  Read-only.

    # List of BlitMap that hold a reference to this surface.
    list_blitmap  : pointer           ##  Private.

    # Clipping information.
    clip_rect*    : Rect              ##  Read-only.

    # Info for fast blit mapping to other surfaces.
    map           : ptr BlitMap       ##  Private.

    # Reference count -- used when freeing surface.
    refcount      : cint              ##  Read-mostly.

  SurfacePtr* = ptr Surface
    ##  Surface.

func pixels16*(self: ptr Surface): ptr UncheckedArray[uint16] {.inline.} =
  ##  `Surface` pixels as unchecked array of `uint16`.
  cast[ptr UncheckedArray[uint16]](self.pixels)

func pixels32*(self: ptr Surface): ptr UncheckedArray[uint32] {.inline.} =
  ##  `Surface` pixels as unchecked array of `uint32`.
  cast[ptr UncheckedArray[uint32]](self.pixels)

# XXX:
# The type of function used for surface blitting functions.
# typedef int (SDLCALL *SDL_blit) (struct SDL_Surface *src, const SDL_Rect *srcrect,
#                                  struct SDL_Surface *dst, const SDL_Rect *dstrect);

func mustlock*(self: ptr Surface): bool {.inline.} =
  ##  Evaluates to true if the surface needs to be locked before access.
  (self.flags and RLEACCEL) != 0

# XXX: typedef SDL_blit

type
  YuvConversionMode* {.size: cint.sizeof.} = enum
    ##  The formula used for converting between YUV and RGB.
    YUV_CONVERSION_JPEG       ##  Full range JPEG.
    YUV_CONVERSION_BT601      ##  BT.601 (the default).
    YUV_CONVERSION_BT709      ##  BT.709.
    YUV_CONVERSION_AUTOMATIC  ##  BT.601 for SD content, BT.709 for HD content.

const
  # XXX: distinct type
  PROP_SURFACE_COLORSPACE_NUMBER*               = cstring"SDL.surface.colorspace"
  PROP_SURFACE_MAXCLL_NUMBER*                   = cstring"SDL.surface.maxCLL"
  PROP_SURFACE_MAXFALL_NUMBER*                  = cstring"SDL.surface.maxFALL"

# vim: set sts=2 et sw=2:
