##  Pixel format definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

# Transparency definitions.
const
  ALPHA_OPAQUE*       = byte 255
  ALPHA_TRANSPARENT*  = byte 0

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

  BitmapOrder {.size: cint.sizeof.} = enum
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

  ArrayOrder {.size: cint.sizeof.} = enum
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

func define_pixelfourcc(a, b, c, d: byte or char): uint32 {.compiletime.} =
  # Defined in SDL_stdinc.h.
  a.uint32 or (b.uint32 shl 8) or (c.uint32 shl 16) or (d.uint32 shl 24)

func define_pixelformat(typ: PixelType,
                        order: ArrayOrder or BitmapOrder or PackedOrder or byte,
                        layout: PackedLayout or byte,
                        bits, bytes: byte): uint32 {.compiletime.} =
  (1'u32 shl 28) or (typ.uint32 shl 24) or (order.uint32 shl 20) or
  (layout.uint32 shl 16) or (bits.uint32 shl 8) or bytes

type
  PixelFormatEnum* {.size: uint32.sizeof.} = enum
    ##  Pixel format.
    PIXELFORMAT_UNKNOWN
    PIXELFORMAT_INDEX1LSB   = define_pixelformat(PIXELTYPE_INDEX1, BITMAPORDER_4321, 0, 1, 0)
    PIXELFORMAT_INDEX1MSB   = define_pixelformat(PIXELTYPE_INDEX1, BITMAPORDER_1234, 0, 1, 0)
    PIXELFORMAT_INDEX4LSB   = define_pixelformat(PIXELTYPE_INDEX4, BITMAPORDER_4321, 0, 4, 0)
    PIXELFORMAT_INDEX4MSB   = define_pixelformat(PIXELTYPE_INDEX4, BITMAPORDER_1234, 0, 4, 0)
    PIXELFORMAT_INDEX8      = define_pixelformat(PIXELTYPE_INDEX8, 0, 0, 8, 1)
    PIXELFORMAT_RGB332      = define_pixelformat(PIXELTYPE_PACKED8, PACKEDORDER_XRGB, PACKEDLAYOUT_332, 8, 1)
    PIXELFORMAT_XRGB4444    = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_XRGB, PACKEDLAYOUT_4444, 12, 2)
    PIXELFORMAT_XRGB1555    = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_XRGB, PACKEDLAYOUT_1555, 15, 2)
    PIXELFORMAT_RGB565      = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_XRGB, PACKEDLAYOUT_565, 16, 2)
    PIXELFORMAT_ARGB4444    = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_ARGB, PACKEDLAYOUT_4444, 16, 2)
    PIXELFORMAT_ARGB1555    = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_ARGB, PACKEDLAYOUT_1555, 16, 2)
    PIXELFORMAT_RGBA4444    = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_RGBA, PACKEDLAYOUT_4444, 16, 2)
    PIXELFORMAT_RGBA5551    = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_RGBA, PACKEDLAYOUT_5551, 16, 2)
    PIXELFORMAT_XBGR4444    = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_XBGR, PACKEDLAYOUT_4444, 12, 2)
    PIXELFORMAT_XBGR1555    = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_XBGR, PACKEDLAYOUT_1555, 15, 2)
    PIXELFORMAT_BGR565      = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_XBGR, PACKEDLAYOUT_565, 16, 2)
    PIXELFORMAT_ABGR4444    = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_ABGR, PACKEDLAYOUT_4444, 16, 2)
    PIXELFORMAT_ABGR1555    = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_ABGR, PACKEDLAYOUT_1555, 16, 2)
    PIXELFORMAT_BGRA4444    = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_BGRA, PACKEDLAYOUT_4444, 16, 2)
    PIXELFORMAT_BGRA5551    = define_pixelformat(PIXELTYPE_PACKED16, PACKEDORDER_BGRA, PACKEDLAYOUT_5551, 16, 2)
    PIXELFORMAT_XRGB8888    = define_pixelformat(PIXELTYPE_PACKED32, PACKEDORDER_XRGB, PACKEDLAYOUT_8888, 24, 4)
    PIXELFORMAT_XRGB2101010 = define_pixelformat(PIXELTYPE_PACKED32, PACKEDORDER_XRGB, PACKEDLAYOUT_2101010, 32, 4)
    PIXELFORMAT_RGBX8888    = define_pixelformat(PIXELTYPE_PACKED32, PACKEDORDER_RGBX, PACKEDLAYOUT_8888, 24, 4)
    PIXELFORMAT_ARGB8888    = define_pixelformat(PIXELTYPE_PACKED32, PACKEDORDER_ARGB, PACKEDLAYOUT_8888, 32, 4)
    PIXELFORMAT_ARGB2101010 = define_pixelformat(PIXELTYPE_PACKED32, PACKEDORDER_ARGB, PACKEDLAYOUT_2101010, 32, 4)
    PIXELFORMAT_RGBA8888    = define_pixelformat(PIXELTYPE_PACKED32, PACKEDORDER_RGBA, PACKEDLAYOUT_8888, 32, 4)
    PIXELFORMAT_XBGR8888    = define_pixelformat(PIXELTYPE_PACKED32, PACKEDORDER_XBGR, PACKEDLAYOUT_8888, 24, 4)
    PIXELFORMAT_XBGR2101010 = define_pixelformat(PIXELTYPE_PACKED32, PACKEDORDER_XBGR, PACKEDLAYOUT_2101010, 32, 4)
    PIXELFORMAT_BGRX8888    = define_pixelformat(PIXELTYPE_PACKED32, PACKEDORDER_BGRX, PACKEDLAYOUT_8888, 24, 4)
    PIXELFORMAT_ABGR8888    = define_pixelformat(PIXELTYPE_PACKED32, PACKEDORDER_ABGR, PACKEDLAYOUT_8888, 32, 4)
    PIXELFORMAT_ABGR2101010 = define_pixelformat(PIXELTYPE_PACKED32, PACKEDORDER_ABGR, PACKEDLAYOUT_2101010, 32, 4)
    PIXELFORMAT_BGRA8888    = define_pixelformat(PIXELTYPE_PACKED32, PACKEDORDER_BGRA, PACKEDLAYOUT_8888, 32, 4)
    PIXELFORMAT_RGB24       = define_pixelformat(PIXELTYPE_ARRAYU8, ARRAYORDER_RGB, 0, 24, 3)
    PIXELFORMAT_BGR24       = define_pixelformat(PIXELTYPE_ARRAYU8, ARRAYORDER_BGR, 0, 24, 3)
    PIXELFORMAT_RGB48       = define_pixelformat(PIXELTYPE_ARRAYU16, ARRAYORDER_RGB, 0, 48, 6)
    PIXELFORMAT_RGBA64      = define_pixelformat(PIXELTYPE_ARRAYU16, ARRAYORDER_RGBA, 0, 64, 8)
    PIXELFORMAT_ARGB64      = define_pixelformat(PIXELTYPE_ARRAYU16, ARRAYORDER_ARGB, 0, 64, 8)
    PIXELFORMAT_BGR48       = define_pixelformat(PIXELTYPE_ARRAYU16, ARRAYORDER_BGR, 0, 48, 6)
    PIXELFORMAT_BGRA64      = define_pixelformat(PIXELTYPE_ARRAYU16, ARRAYORDER_BGRA, 0, 64, 8)
    PIXELFORMAT_ABGR64      = define_pixelformat(PIXELTYPE_ARRAYU16, ARRAYORDER_ABGR, 0, 64, 8)
    PIXELFORMAT_RGB48_FLOAT = define_pixelformat(PIXELTYPE_ARRAYF16, ARRAYORDER_RGB, 0, 48, 6)
    PIXELFORMAT_RGBA64_FLOAT  = define_pixelformat(PIXELTYPE_ARRAYF16, ARRAYORDER_RGBA, 0, 64, 8)
    PIXELFORMAT_ARGB64_FLOAT  = define_pixelformat(PIXELTYPE_ARRAYF16, ARRAYORDER_ARGB, 0, 64, 8)
    PIXELFORMAT_BGR48_FLOAT   = define_pixelformat(PIXELTYPE_ARRAYF16, ARRAYORDER_BGR, 0, 48, 6)
    PIXELFORMAT_BGRA64_FLOAT  = define_pixelformat(PIXELTYPE_ARRAYF16, ARRAYORDER_BGRA, 0, 64, 8)
    PIXELFORMAT_ABGR64_FLOAT  = define_pixelformat(PIXELTYPE_ARRAYF16, ARRAYORDER_ABGR, 0, 64, 8)
    PIXELFORMAT_RGB96_FLOAT   = define_pixelformat(PIXELTYPE_ARRAYF32, ARRAYORDER_RGB, 0, 96, 12)
    PIXELFORMAT_RGBA128_FLOAT = define_pixelformat(PIXELTYPE_ARRAYF32, ARRAYORDER_RGBA, 0, 128, 16)
    PIXELFORMAT_ARGB128_FLOAT = define_pixelformat(PIXELTYPE_ARRAYF32, ARRAYORDER_ARGB, 0, 128, 16)
    PIXELFORMAT_BGR96_FLOAT   = define_pixelformat(PIXELTYPE_ARRAYF32, ARRAYORDER_BGR, 0, 96, 12)
    PIXELFORMAT_BGRA128_FLOAT = define_pixelformat(PIXELTYPE_ARRAYF32, ARRAYORDER_BGRA, 0, 128, 16)
    PIXELFORMAT_ABGR128_FLOAT = define_pixelformat(PIXELTYPE_ARRAYF32, ARRAYORDER_ABGR, 0, 128, 16)

    PIXELFORMAT_INDEX2LSB   = define_pixelformat(PIXELTYPE_INDEX2, BITMAPORDER_4321, 0, 2, 0)
    PIXELFORMAT_INDEX2MSB   = define_pixelformat(PIXELTYPE_INDEX2, BITMAPORDER_1234, 0, 2, 0)

    PIXELFORMAT_EXTERNAL_OES  = define_pixelfourcc('O', 'E', 'S', ' ')
    PIXELFORMAT_NV21          = define_pixelfourcc('N', 'V', '2', '1')
    PIXELFORMAT_NV12          = define_pixelfourcc('N', 'V', '1', '2')
    PIXELFORMAT_YV12          = define_pixelfourcc('Y', 'V', '1', '2')
    PIXELFORMAT_YUY2          = define_pixelfourcc('Y', 'U', 'Y', '2')
    PIXELFORMAT_YVYU          = define_pixelfourcc('Y', 'V', 'Y', 'U')
    PIXELFORMAT_IYUV          = define_pixelfourcc('I', 'Y', 'U', 'V')
    PIXELFORMAT_UYVY          = define_pixelfourcc('U', 'Y', 'V', 'Y')

const
  PIXELFORMAT_RGB444* = PIXELFORMAT_XRGB4444
  PIXELFORMAT_BGR444* = PIXELFORMAT_XBGR4444
  PIXELFORMAT_RGB555* = PIXELFORMAT_XRGB1555
  PIXELFORMAT_BGR555* = PIXELFORMAT_XBGR1555

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

func bits_per_pixel*(format: PixelFormatEnum): int {.inline.} =
  int format.uint32 shr 8 and 0xff

func is_fourcc(format: PixelFormatEnum): bool {.inline.} =
  (format != PIXELFORMAT_UNKNOWN) and (format.pixel_flag != 1)

#[
#define SDL_BYTESPERPIXEL(X) \
    (SDL_ISPIXELFORMAT_FOURCC(X) ? \
        ((((X) == SDL_PIXELFORMAT_YUY2) || \
          ((X) == SDL_PIXELFORMAT_UYVY) || \
          ((X) == SDL_PIXELFORMAT_YVYU)) ? 2 : 1) : (((X) >> 0) & 0xFF))

]#

func bytes_per_pixel*(format: PixelFormatEnum): int {.inline.} =
  if format.is_fourcc:
    case format
    of PIXELFORMAT_YUY2, PIXELFORMAT_UYVY, PIXELFORMAT_YVYU:
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

func define_colorspace(typ: ColorType, range: ColorRange,
                       primaries: ColorPrimaries,
                       transfer: TransferCharacteristics,
                       matrix: MatrixCoefficients,
                       chroma: ChromaLocation): uint32 =
  ##  Colorspace definition.
  (typ.uint32 shl 28) or (range.uint32 shl 24) or (chroma.uint32 shl 20) or
  (primaries.uint32 shl 10) or (transfer.uint32 shl 5) or (matrix.uint32 shl 0)

# XXX:
#func COLORSPACETYPE(x)       (SDL_ColorType)(((X) >> 28) & 0x0F)
#func COLORSPACERANGE(x)      (SDL_ColorRange)(((X) >> 24) & 0x0F)
#func COLORSPACECHROMA(x)     (SDL_ChromaLocation)(((X) >> 20) & 0x0F)
#func COLORSPACEPRIMARIES(x)  (SDL_ColorPrimaries)(((X) >> 10) & 0x1F)
#func COLORSPACETRANSFER(x)   (SDL_TransferCharacteristics)(((X) >> 5) & 0x1F)
#func COLORSPACEMATRIX(x)     (SDL_MatrixCoefficients)((X) & 0x1F)

# XXX:
#define SDL_ISCOLORSPACE_YUV_BT601(X)       (SDL_COLORSPACEMATRIX(X) == SDL_MATRIX_COEFFICIENTS_BT601 || SDL_COLORSPACEMATRIX(X) == SDL_MATRIX_COEFFICIENTS_BT470BG)
#define SDL_ISCOLORSPACE_YUV_BT709(X)       (SDL_COLORSPACEMATRIX(X) == SDL_MATRIX_COEFFICIENTS_BT709)
#define SDL_ISCOLORSPACE_LIMITED_RANGE(X)   (SDL_COLORSPACERANGE(X) == SDL_COLOR_RANGE_LIMITED)
#define SDL_ISCOLORSPACE_FULL_RANGE(X)      (SDL_COLORSPACERANGE(X) == SDL_COLOR_RANGE_LIMITED

type
  Colorspace* {.size: cint.sizeof.} = enum
    ##  The color space.
    COLORSPACE_UNKNOWN
    COLORSPACE_SCRGB          = define_colorspace(COLOR_TYPE_RGB,
                                  COLOR_RANGE_FULL,
                                  COLOR_PRIMARIES_BT709,
                                  TRANSFER_CHARACTERISTICS_LINEAR,
                                  MATRIX_COEFFICIENTS_UNSPECIFIED,
                                  CHROMA_LOCATION_NONE)
    COLORSPACE_SRGB           = define_colorspace(COLOR_TYPE_RGB,
                                  COLOR_RANGE_FULL,
                                  COLOR_PRIMARIES_BT709,
                                  TRANSFER_CHARACTERISTICS_SRGB,
                                  MATRIX_COEFFICIENTS_UNSPECIFIED,
                                  CHROMA_LOCATION_NONE)
    COLORSPACE_HDR10          = define_colorspace(COLOR_TYPE_RGB,
                                  COLOR_RANGE_FULL,
                                  COLOR_PRIMARIES_BT2020,
                                  TRANSFER_CHARACTERISTICS_PQ,
                                  MATRIX_COEFFICIENTS_UNSPECIFIED,
                                  CHROMA_LOCATION_NONE)
    COLORSPACE_BT709_LIMITED  = define_colorspace(COLOR_TYPE_YCBCR,
                                  COLOR_RANGE_LIMITED,
                                  COLOR_PRIMARIES_BT709,
                                  TRANSFER_CHARACTERISTICS_BT709,
                                  MATRIX_COEFFICIENTS_BT709,
                                  CHROMA_LOCATION_LEFT)
    COLORSPACE_BT601_LIMITED  = define_colorspace(COLOR_TYPE_YCBCR,
                                  COLOR_RANGE_LIMITED,
                                  COLOR_PRIMARIES_BT601,
                                  TRANSFER_CHARACTERISTICS_BT601,
                                  MATRIX_COEFFICIENTS_BT601,
                                  CHROMA_LOCATION_LEFT)
    COLORSPACE_BT709_FULL     = define_colorspace(COLOR_TYPE_YCBCR,
                                  COLOR_RANGE_FULL,
                                  COLOR_PRIMARIES_BT709,
                                  TRANSFER_CHARACTERISTICS_BT709,
                                  MATRIX_COEFFICIENTS_BT709,
                                  CHROMA_LOCATION_LEFT)
    COLORSPACE_BT601_FULL     = define_colorspace(COLOR_TYPE_YCBCR,
                                  COLOR_RANGE_FULL,
                                  COLOR_PRIMARIES_BT601,
                                  TRANSFER_CHARACTERISTICS_BT601,
                                  MATRIX_COEFFICIENTS_BT601,
                                  CHROMA_LOCATION_LEFT)

const
  COLORSPACE_RGB_DEFAULT* = COLORSPACE_SRGB
    ##  The default colorspace for RGB surfaces if no colorspace is specified.

  COLORSPACE_YUV_DEFAULT* = COLORSPACE_BT601_LIMITED
    ##  The default colorspace for YUV surfaces if no colorspace is specified.

type
  Color* {.final, pure.} = object
    ##  Color.
    r*                : byte
    g*                : byte
    b*                : byte
    a*                : byte

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

func init*(T: typedesc[FColor], r, g, b: float32, a: float32): T {.inline.} =
  T(r: r, g: g, b: b, a: a)

type
  Palette* {.final, pure.} = object
    ncolors*          : cint
    colors*           : ptr UncheckedArray[Color]
    version*          : uint32
    refcount          : cint

  PixelFormat* {.bycopy, final, pure.} = object
    ##  Pixel format. All attributes are read-only.
    format*           : uint32
    palette*          : ptr Palette
    bits_per_pixel*   : byte
    bytes_per_pixel*  : byte
    padding           : array[2, byte]
    rmask*            : uint32
    gmask*            : uint32
    bmask*            : uint32
    amask*            : uint32
    rloss*            : byte
    gloss*            : byte
    bloss*            : byte
    aloss*            : byte
    rshift*           : byte
    gshift*           : byte
    bshift*           : byte
    ashift*           : byte
    refcount          : cint
    next*             : ptr PixelFormat

# --------------------------------------------------------------------------- #
#   Sanity checks                                                             #
# --------------------------------------------------------------------------- #

when defined(gcc) and hostCPU == "amd64":
  when Palette.sizeof != 24:
    {.error: "invalid Palette size: " & $Palette.sizeof.}
  when PixelFormat.sizeof != 56:
    {.error: "invalid PixelFormat size: " & $PixelFormat.sizeof.}

# vim: set sts=2 et sw=2:
