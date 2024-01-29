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

type
  ColorPrimaries* {.size: cint.sizeof.} = enum
    ##  The color primaries,
    ##  as described by https://www.itu.int/rec/T-REC-H.273-201612-S/en
    COLOR_PRIMARIES_UNKNOWN       = 0
    COLOR_PRIMARIES_BT709         = 1
    COLOR_PRIMARIES_UNSPECIFIED   = 2
    COLOR_PRIMARIES_BT470M        = 4
    COLOR_PRIMARIES_BT470BG       = 5
    COLOR_PRIMARIES_BT601         = 6
    COLOR_PRIMARIES_SMPTE240      = 7
    COLOR_PRIMARIES_GENERIC_FILM  = 8
    COLOR_PRIMARIES_BT2020        = 9
    COLOR_PRIMARIES_XYZ           = 10
    COLOR_PRIMARIES_SMPTE431      = 11
    COLOR_PRIMARIES_SMPTE432      = 12   ##  DCI P3.
    COLOR_PRIMARIES_EBU3213       = 22

const
  COLOR_PRIMARIES_IEC61966_2_4*   = COLOR_PRIMARIES_BT709

type
  TransferCharacteristics* {.size: cint.sizeof.} = enum
    ##  The transfer characteristics,
    ##  as described by https://www.itu.int/rec/T-REC-H.273-201612-S/en
    TRANSFER_CHARACTERISTICS_UNKNOWN        = 0
    TRANSFER_CHARACTERISTICS_BT709          = 1
    TRANSFER_CHARACTERISTICS_UNSPECIFIED    = 2
    TRANSFER_CHARACTERISTICS_BT470M         = 4   ##  2.2 gamma.
    TRANSFER_CHARACTERISTICS_BT470BG        = 5   ##  2.8 gamma.
    TRANSFER_CHARACTERISTICS_BT601          = 6
    TRANSFER_CHARACTERISTICS_SMPTE240       = 7
    TRANSFER_CHARACTERISTICS_LINEAR         = 8
    TRANSFER_CHARACTERISTICS_LOG100         = 9
    TRANSFER_CHARACTERISTICS_LOG100_SQRT10  = 10
    TRANSFER_CHARACTERISTICS_IEC61966       = 11
    TRANSFER_CHARACTERISTICS_BT1361         = 12
    TRANSFER_CHARACTERISTICS_SRGB           = 13
    TRANSFER_CHARACTERISTICS_BT2020_10BIT   = 14
    TRANSFER_CHARACTERISTICS_BT2020_12BIT   = 15
    TRANSFER_CHARACTERISTICS_SMPTE2084      = 16   ##  PQ.
    TRANSFER_CHARACTERISTICS_SMPTE428       = 17
    TRANSFER_CHARACTERISTICS_HLG            = 18

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
  PROP_SURFACE_COLOR_PRIMARIES_NUMBER*          = cstring"SDL.surface.color_primaries"
  PROP_SURFACE_TRANSFER_CHARACTERISTICS_NUMBER* = cstring"SDL.surface.transfer_characteristics"
  PROP_SURFACE_MAXCLL_NUMBER*                   = cstring"SDL.surface.maxCLL"
  PROP_SURFACE_MAXFALL_NUMBER*                  = cstring"SDL.surface.maxFALL"

# vim: set sts=2 et sw=2:
