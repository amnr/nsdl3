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
    PIXELFORMAT_RGB48       = define_pixelformat(PIXELTYPE_ARRAYU16, ARRAYORDER_RGB, 0, 48, 3)
    PIXELFORMAT_RGBA64      = define_pixelformat(PIXELTYPE_ARRAYU16, ARRAYORDER_RGBA, 0, 64, 4)
    PIXELFORMAT_ARGB64      = define_pixelformat(PIXELTYPE_ARRAYU16, ARRAYORDER_ARGB, 0, 64, 4)
    PIXELFORMAT_BGR48       = define_pixelformat(PIXELTYPE_ARRAYU16, ARRAYORDER_BGR, 0, 48, 3)
    PIXELFORMAT_BGRA64      = define_pixelformat(PIXELTYPE_ARRAYU16, ARRAYORDER_BGRA, 0, 64, 4)
    PIXELFORMAT_ABGR64      = define_pixelformat(PIXELTYPE_ARRAYU16, ARRAYORDER_ABGR, 0, 64, 4)
    PIXELFORMAT_RGB48_FLOAT = define_pixelformat(PIXELTYPE_ARRAYF16, ARRAYORDER_RGB, 0, 48, 3)
    PIXELFORMAT_RGBA64_FLOAT  = define_pixelformat(PIXELTYPE_ARRAYF16, ARRAYORDER_RGBA, 0, 64, 4)
    PIXELFORMAT_ARGB64_FLOAT  = define_pixelformat(PIXELTYPE_ARRAYF16, ARRAYORDER_ARGB, 0, 64, 4)
    PIXELFORMAT_BGR48_FLOAT   = define_pixelformat(PIXELTYPE_ARRAYF16, ARRAYORDER_BGR, 0, 48, 3)
    PIXELFORMAT_BGRA64_FLOAT  = define_pixelformat(PIXELTYPE_ARRAYF16, ARRAYORDER_BGRA, 0, 64, 4)
    PIXELFORMAT_ABGR64_FLOAT  = define_pixelformat(PIXELTYPE_ARRAYF16, ARRAYORDER_ABGR, 0, 64, 4)
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

#define SDL_PIXELORDER(X)   (((X) >> 20) & 0x0F)

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
  format.is_fourcc.not and (
    (format.pixel_type == PACKEDORDER_ARGB.uint32) or
    (format.pixel_type == PACKEDORDER_RGBA.uint32) or
    (format.pixel_type == PACKEDORDER_ABGR.uint32) or
    (format.pixel_type == PACKEDORDER_BGRA.uint32)
  )

func is_10bit*(format: PixelFormatEnum): bool {.inline.} =
  (format.pixel_type == PIXELTYPE_PACKED32.uint32) and
  (format.pixel_layout == PACKEDLAYOUT_2101010.uint32)

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
