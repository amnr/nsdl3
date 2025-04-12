##  Pixel format definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

# Transparency definitions.
const
  ALPHA_OPAQUE*             = byte 255
  ALPHA_OPAQUE_FLOAT*       = cfloat 1.0

const
  ALPHA_TRANSPARENT*        = byte 0
  ALPHA_TRANSPARENT_FLOAT*  = cfloat 0.0

type
  PixelType {.size: cint.sizeof.} = enum
    ##  Pixel type.
    PIXELTYPE_UNKNOWN
    PIXELTYPE_INDEX1
    PIXELTYPE_INDEX4
    PIXELTYPE_INDEX8
    PIXELTYPE_PACKED8
    PIXELTYPE_PACKED16
    PIXELTYPE_PACKED32
    PIXELTYPE_ARRAYU8
    PIXELTYPE_ARRAYU16
    PIXELTYPE_ARRAYU32
    PIXELTYPE_ARRAYF16
    PIXELTYPE_ARRAYF32
    PIXELTYPE_INDEX2

  BitmapOrder* {.size: cint.sizeof.} = enum
    ##  Bitmap pixel order (high bit to low bit).
    BITMAPORDER_NONE
    BITMAPORDER_4321
    BITMAPORDER_1234

  PackedOrder {.size: cint.sizeof.} = enum
    ##  Packed component order (high bit to low bit).
    PACKEDORDER_NONE
    PACKEDORDER_XRGB
    PACKEDORDER_RGBX
    PACKEDORDER_ARGB
    PACKEDORDER_RGBA
    PACKEDORDER_XBGR
    PACKEDORDER_BGRX
    PACKEDORDER_ABGR
    PACKEDORDER_BGRA

  ArrayOrder* {.size: cint.sizeof.} = enum
    ##  Array component order, low byte to high byte.
    ARRAYORDER_NONE
    ARRAYORDER_RGB
    ARRAYORDER_RGBA
    ARRAYORDER_ARGB
    ARRAYORDER_BGR
    ARRAYORDER_BGRA
    ARRAYORDER_ABGR

  PackedLayout {.size: cint.sizeof.} = enum
    ##  Packed component layout.
    PACKEDLAYOUT_NONE
    PACKEDLAYOUT_332
    PACKEDLAYOUT_4444
    PACKEDLAYOUT_1555
    PACKEDLAYOUT_5551
    PACKEDLAYOUT_565
    PACKEDLAYOUT_8888
    PACKEDLAYOUT_2101010
    PACKEDLAYOUT_1010102

# Note:
# SDL_ISPIXELFORMAT macros moved after PixelFormatEnum.

type
  PixelFormatEnum* {.size: uint32.sizeof.} = enum
    ##  Pixel format.
    PIXELFORMAT_UNKNOWN       = 0
    PIXELFORMAT_INDEX1LSB     = 0x11100100
    PIXELFORMAT_INDEX1MSB     = 0x11200100
    PIXELFORMAT_INDEX4LSB     = 0x12100400
    PIXELFORMAT_INDEX4MSB     = 0x12200400
    PIXELFORMAT_INDEX8        = 0x13000801
    PIXELFORMAT_RGB332        = 0x14110801
    PIXELFORMAT_XRGB4444      = 0x15120c02
    PIXELFORMAT_XRGB1555      = 0x15130f02
    PIXELFORMAT_RGB565        = 0x15151002
    PIXELFORMAT_ARGB4444      = 0x15321002
    PIXELFORMAT_ARGB1555      = 0x15331002
    PIXELFORMAT_RGBA4444      = 0x15421002
    PIXELFORMAT_RGBA5551      = 0x15441002
    PIXELFORMAT_XBGR4444      = 0x15520c02
    PIXELFORMAT_XBGR1555      = 0x15530f02
    PIXELFORMAT_BGR565        = 0x15551002
    PIXELFORMAT_ABGR4444      = 0x15721002
    PIXELFORMAT_ABGR1555      = 0x15731002
    PIXELFORMAT_BGRA4444      = 0x15821002
    PIXELFORMAT_BGRA5551      = 0x15841002
    PIXELFORMAT_XRGB8888      = 0x16161804
    PIXELFORMAT_XRGB2101010   = 0x16172004
    PIXELFORMAT_RGBX8888      = 0x16261804
    PIXELFORMAT_ARGB8888      = 0x16362004
    PIXELFORMAT_ARGB2101010   = 0x16372004
    PIXELFORMAT_RGBA8888      = 0x16462004
    PIXELFORMAT_XBGR8888      = 0x16561804
    PIXELFORMAT_XBGR2101010   = 0x16572004
    PIXELFORMAT_BGRX8888      = 0x16661804
    PIXELFORMAT_ABGR8888      = 0x16762004
    PIXELFORMAT_ABGR2101010   = 0x16772004
    PIXELFORMAT_BGRA8888      = 0x16862004
    PIXELFORMAT_RGB24         = 0x17101803
    PIXELFORMAT_BGR24         = 0x17401803
    PIXELFORMAT_RGB48         = 0x18103006
    PIXELFORMAT_RGBA64        = 0x18204008
    PIXELFORMAT_ARGB64        = 0x18304008
    PIXELFORMAT_BGR48         = 0x18403006
    PIXELFORMAT_BGRA64        = 0x18504008
    PIXELFORMAT_ABGR64        = 0x18604008
    PIXELFORMAT_RGB48_FLOAT   = 0x1a103006
    PIXELFORMAT_RGBA64_FLOAT  = 0x1a204008
    PIXELFORMAT_ARGB64_FLOAT  = 0x1a304008
    PIXELFORMAT_BGR48_FLOAT   = 0x1a403006
    PIXELFORMAT_BGRA64_FLOAT  = 0x1a504008
    PIXELFORMAT_ABGR64_FLOAT  = 0x1a604008
    PIXELFORMAT_RGB96_FLOAT   = 0x1b10600c
    PIXELFORMAT_RGBA128_FLOAT = 0x1b208010
    PIXELFORMAT_ARGB128_FLOAT = 0x1b308010
    PIXELFORMAT_BGR96_FLOAT   = 0x1b40600c
    PIXELFORMAT_BGRA128_FLOAT = 0x1b508010
    PIXELFORMAT_ABGR128_FLOAT = 0x1b608010
    PIXELFORMAT_INDEX2LSB     = 0x1c100200
    PIXELFORMAT_INDEX2MSB     = 0x1c200200

    PIXELFORMAT_EXTERNAL_OES  = 0x2053454f
    PIXELFORMAT_P010          = 0x30313050
    PIXELFORMAT_NV21          = 0x3132564e
    PIXELFORMAT_NV12          = 0x3231564e
    PIXELFORMAT_YV12          = 0x32315659
    PIXELFORMAT_YUY2          = 0x32595559
    PIXELFORMAT_MJPG          = 0x47504a4d
    PIXELFORMAT_YVYU          = 0x55595659
    PIXELFORMAT_IYUV          = 0x56555949
    PIXELFORMAT_UYVY          = 0x59565955

when cpuEndian == bigEndian:
  const
    PIXELFORMAT_RGBA32* = PIXELFORMAT_RGBA8888
    PIXELFORMAT_ARGB32* = PIXELFORMAT_ARGB8888
    PIXELFORMAT_BGRA32* = PIXELFORMAT_BGRA8888
    PIXELFORMAT_ABGR32* = PIXELFORMAT_ABGR8888
    PIXELFORMAT_RGBX32* = PIXELFORMAT_RGBX8888
    PIXELFORMAT_XRGB32* = PIXELFORMAT_XRGB8888
    PIXELFORMAT_BGRX32* = PIXELFORMAT_BGRX8888
    PIXELFORMAT_XBGR32* = PIXELFORMAT_XBGR8888
else:
  const
    PIXELFORMAT_RGBA32* = PIXELFORMAT_ABGR8888
    PIXELFORMAT_ARGB32* = PIXELFORMAT_BGRA8888
    PIXELFORMAT_BGRA32* = PIXELFORMAT_ARGB8888
    PIXELFORMAT_ABGR32* = PIXELFORMAT_RGBA8888
    PIXELFORMAT_RGBX32* = PIXELFORMAT_XBGR8888
    PIXELFORMAT_XRGB32* = PIXELFORMAT_BGRX8888
    PIXELFORMAT_BGRX32* = PIXELFORMAT_XRGB8888
    PIXELFORMAT_XBGR32* = PIXELFORMAT_RGBX8888

func pixel_flag(format: PixelFormatEnum): uint32 {.inline.} =
  (format.uint32 shr 28) and 0x0f

func pixel_type(format: PixelFormatEnum): uint32 {.inline.} =
  (format.uint32 shr 24) and 0x0f

func pixel_order(format: PixelFormatEnum): uint32 {.inline.} =
  (format.uint32 shr 20) and 0x0f

func pixel_layout(format: PixelFormatEnum): uint32 {.inline.} =
  (format.uint32 shr 16) and 0x0f

func is_fourcc(format: PixelFormatEnum): bool {.inline.} =
  (format != PIXELFORMAT_UNKNOWN) and (format.pixel_flag != 1)

func bits_per_pixel*(format: PixelFormatEnum): int {.inline.} =
  int (if format.is_fourcc: 0'u32 else: (format.uint32 shr 8) and 0xff)

func bytes_per_pixel*(format: PixelFormatEnum): int {.inline.} =
  if format.is_fourcc:
    case format
    of PIXELFORMAT_YUY2, PIXELFORMAT_UYVY, PIXELFORMAT_YVYU, PIXELFORMAT_P010:
      2
    else:
      1
  else:
    int format.uint32 and 0xff

func is_indexed*(format: PixelFormatEnum): bool {.inline.} =
  format.is_fourcc.not and (
    (format.pixel_type == PIXELTYPE_INDEX1.uint32) or
    (format.pixel_type == PIXELTYPE_INDEX2.uint32) or
    (format.pixel_type == PIXELTYPE_INDEX4.uint32) or
    (format.pixel_type == PIXELTYPE_INDEX8.uint32)
  )

func is_packed*(format: PixelFormatEnum): bool {.inline.} =
  format.is_fourcc.not and (
    (format.pixel_type == PIXELTYPE_PACKED8.uint32) or
    (format.pixel_type == PIXELTYPE_PACKED16.uint32) or
    (format.pixel_type == PIXELTYPE_PACKED32.uint32)
  )

func is_array*(format: PixelFormatEnum): bool {.inline.} =
  format.is_fourcc.not and (
    (format.pixel_type == PIXELTYPE_ARRAYU8.uint32) or
    (format.pixel_type == PIXELTYPE_ARRAYU16.uint32) or
    (format.pixel_type == PIXELTYPE_ARRAYU32.uint32) or
    (format.pixel_type == PIXELTYPE_ARRAYF16.uint32) or
    (format.pixel_type == PIXELTYPE_ARRAYF32.uint32)
  )

func is_alpha*(format: PixelFormatEnum): bool {.inline.} =
  format.is_packed and (
    (format.pixel_order == PACKEDORDER_ARGB.uint32) or
    (format.pixel_order == PACKEDORDER_RGBA.uint32) or
    (format.pixel_order == PACKEDORDER_ABGR.uint32) or
    (format.pixel_order == PACKEDORDER_BGRA.uint32)
  )

func is_10bit*(format: PixelFormatEnum): bool {.inline.} =
  format.is_fourcc.not and (
    (format.pixel_type == PIXELTYPE_PACKED32.uint32) and
    (format.pixel_layout == PACKEDLAYOUT_2101010.uint32)
  )

func is_float*(format: PixelFormatEnum): bool {.inline.} =
  format.is_fourcc.not and (
    (format.pixel_type == PIXELTYPE_ARRAYF16.uint32) or
    (format.pixel_type == PIXELTYPE_ARRAYF32.uint32)
  )

type
  ColorType* {.size: cint.sizeof.} = enum
    ##  The color type.
    COLOR_TYPE_UNKNOWN  = 0
    COLOR_TYPE_RGB      = 1
    COLOR_TYPE_YCBCR    = 2

  ColorRange* {.size: cint.sizeof.} = enum
    ##  The color range,
    ##  as described by https://www.itu.int/rec/R-REC-BT.2100-2-201807-I/en.
    COLOR_RANGE_UNKNOWN = 0
    COLOR_RANGE_LIMITED = 1
    COLOR_RANGE_FULL    = 2

  ColorPrimaries* {.size: cint.sizeof.} = enum
    ##  The color primaries,
    ##  as described by https://www.itu.int/rec/T-REC-H.273-201612-S/en.
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
    COLOR_PRIMARIES_SMPTE432      = 12    ##  DCI P3.
    COLOR_PRIMARIES_EBU3213       = 22
    COLOR_PRIMARIES_CUSTOM        = 31

  TransferCharacteristics* {.size: cint.sizeof.} = enum
    ##  The transfer characteristics,
    ##  as described by https://www.itu.int/rec/T-REC-H.273-201612-S/en.
    TRANSFER_CHARACTERISTICS_UNKNOWN        = 0
    TRANSFER_CHARACTERISTICS_BT709          = 1
    TRANSFER_CHARACTERISTICS_UNSPECIFIED    = 2
    TRANSFER_CHARACTERISTICS_GAMMA22        = 4
    TRANSFER_CHARACTERISTICS_GAMMA28        = 5
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
    TRANSFER_CHARACTERISTICS_PQ             = 16
    TRANSFER_CHARACTERISTICS_SMPTE428       = 17
    TRANSFER_CHARACTERISTICS_HLG            = 18
    TRANSFER_CHARACTERISTICS_CUSTOM         = 31

  MatrixCoefficients* {.size: cint.sizeof.} = enum
    ##  The matrix coefficients,
    ##  as described by https://www.itu.int/rec/T-REC-H.273-201612-S/en.
    MATRIX_COEFFICIENTS_IDENTITY            = 0
    MATRIX_COEFFICIENTS_BT709               = 1
    MATRIX_COEFFICIENTS_UNSPECIFIED         = 2
    MATRIX_COEFFICIENTS_FCC                 = 4
    MATRIX_COEFFICIENTS_BT470BG             = 5
    MATRIX_COEFFICIENTS_BT601               = 6
    MATRIX_COEFFICIENTS_SMPTE240            = 7
    MATRIX_COEFFICIENTS_YCGCO               = 8
    MATRIX_COEFFICIENTS_BT2020_NCL          = 9
    MATRIX_COEFFICIENTS_BT2020_CL           = 10
    MATRIX_COEFFICIENTS_SMPTE2085           = 11
    MATRIX_COEFFICIENTS_CHROMA_DERIVED_NCL  = 12
    MATRIX_COEFFICIENTS_CHROMA_DERIVED_CL   = 13
    MATRIX_COEFFICIENTS_ICTCP               = 14
    MATRIX_COEFFICIENTS_CUSTOM              = 31

  ChromaLocation* {.size: cint.sizeof.} = enum
    ##  The chroma sample location.
    CHROMA_LOCATION_NONE      = 0
    CHROMA_LOCATION_LEFT      = 1
    CHROMA_LOCATION_CENTER    = 2
    CHROMA_LOCATION_TOPLEFT   = 3

#[
func define_colorspace(typ: ColorType, range: ColorRange,
                       primaries: ColorPrimaries,
                       transfer: TransferCharacteristics,
                       matrix: MatrixCoefficients,
                       chroma: ChromaLocation): uint32 =
  ##  Colorspace definition.
  (typ.uint32 shl 28) or (range.uint32 shl 24) or (chroma.uint32 shl 20) or
  (primaries.uint32 shl 10) or (transfer.uint32 shl 5) or (matrix.uint32 shl 0)
]#

# XXX:
#func COLORSPACETYPE(x)       (SDL_ColorType)(((X) >> 28) & 0x0F)
#func COLORSPACERANGE(x)      (SDL_ColorRange)(((X) >> 24) & 0x0F)
#func COLORSPACECHROMA(x)     (SDL_ChromaLocation)(((X) >> 20) & 0x0F)
#func COLORSPACEPRIMARIES(x)  (SDL_ColorPrimaries)(((X) >> 10) & 0x1F)
#func COLORSPACETRANSFER(x)   (SDL_TransferCharacteristics)(((X) >> 5) & 0x1F)
#func COLORSPACEMATRIX(x)     (SDL_MatrixCoefficients)((X) & 0x1F)

# XXX:
#define SDL_ISCOLORSPACE_MATRIX_BT601(X)        (SDL_COLORSPACEMATRIX(X) == SDL_MATRIX_COEFFICIENTS_BT601 || SDL_COLORSPACEMATRIX(X) == SDL_MATRIX_COEFFICIENTS_BT470BG)
#define SDL_ISCOLORSPACE_MATRIX_BT709(X)        (SDL_COLORSPACEMATRIX(X) == SDL_MATRIX_COEFFICIENTS_BT709)
#define SDL_ISCOLORSPACE_MATRIX_BT2020_NCL(X)   (SDL_COLORSPACEMATRIX(X) == SDL_MATRIX_COEFFICIENTS_BT2020_NCL)
#define SDL_ISCOLORSPACE_LIMITED_RANGE(X)       (SDL_COLORSPACERANGE(X) != SDL_COLOR_RANGE_FULL)
#define SDL_ISCOLORSPACE_FULL_RANGE(X)          (SDL_COLORSPACERANGE(X) == SDL_COLOR_RANGE_FULL)

type
  Colorspace* {.size: cint.sizeof.} = enum
    ##  The color space.
    COLORSPACE_UNKNOWN        = 0
    COLORSPACE_SRGB_LINEAR    = 0x12000500
    COLORSPACE_SRGB           = 0x120005a0
    COLORSPACE_HDR10          = 0x12002600
    COLORSPACE_BT709_LIMITED  = 0x21100421
    COLORSPACE_BT601_LIMITED  = 0x211018c6
    COLORSPACE_BT2020_LIMITED = 0x21102609
    COLORSPACE_JPEG           = 0x220004c6
    COLORSPACE_BT709_FULL     = 0x22100421
    COLORSPACE_BT601_FULL     = 0x221018c6
    COLORSPACE_BT2020_FULL    = 0x22102609

const
  COLORSPACE_RGB_DEFAULT* = COLORSPACE_SRGB
    ##  The default colorspace for RGB surfaces if no colorspace is specified.

  COLORSPACE_YUV_DEFAULT* = COLORSPACE_JPEG
    ##  The default colorspace for YUV surfaces if no colorspace is specified.

type
  Color* {.final, pure.} = object
    ##  Color.
    r*  : byte
    g*  : byte
    b*  : byte
    a*  : byte

func init*(T: typedesc[Color], r, g, b: byte, a: byte = 0xff): T {.inline.} =
  T(r: r, g: g, b: b, a: a)

type
  FColor* {.final, pure.} = object
    ##  The bits of this structure can be directly reinterpreted
    ##  as a float-packed color which uses the `PIXELFORMAT_RGBA128_FLOAT`
    ##  format.
    r*  : cfloat
    g*  : cfloat
    b*  : cfloat
    a*  : cfloat

  FColour* = FColor

func init*(T: typedesc[FColor], r, g, b: SomeFloat,
           a: SomeFloat = 1.0): FColor {.inline.} =
  T(r: r.cfloat, g: g.cfloat, b: b.cfloat, a: a.cfloat)

type
  Palette* {.final, pure.} = object
    ncolors*  : cint
    colors*   : ptr UncheckedArray[Color]
    version*  : uint32
    refcount  : cint

type
  PixelFormatDetails* {.bycopy, final, pure.} = object
    ##  Pixel format. All attributes are read-only.
    format*           : PixelFormatEnum
    bits_per_pixel*   : byte
    bytes_per_pixel*  : byte
    padding           : array[2, byte]
    rmask*            : uint32
    gmask*            : uint32
    bmask*            : uint32
    amask*            : uint32
    rbits*            : byte
    gbits*            : byte
    bbits*            : byte
    abits*            : byte
    rshift*           : byte
    gshift*           : byte
    bshift*           : byte
    ashift*           : byte

  PixelFormatDetailsPtr* = ptr PixelFormatDetails
    ##  Pixel format pointer.

# --------------------------------------------------------------------------- #
#   Sanity checks                                                             #
# --------------------------------------------------------------------------- #

when defined(gcc) and hostCPU == "amd64":
  when Palette.sizeof != 24:
    {.error: "invalid Palette size: " & $Palette.sizeof.}
  # when PixelFormatDetails.sizeof != 56:
  #   {.error: "invalid PixelFormat size: " & $PixelFormatDetails.sizeof.}

# vim: set sts=2 et sw=2:
