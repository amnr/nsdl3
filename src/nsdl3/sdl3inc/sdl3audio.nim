##  Audio definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  AudioFormat* = distinct uint16
    ##  Audio format.

func `==`*(a, b: AudioFormat): bool {.borrow.}

type
  AudioFormatFlags* = distinct cint
    ##  Audio format flags.

func `or`*(x, y: AudioFormatFlags): AudioFormatFlags {.borrow.}

const
  AUDIO_MASK_BITSIZE*   = 0xff
  AUDIO_MASK_FLOAT*     = 1 shl 8
  AUDIO_MASK_ENDIAN*    = 1 shl 12
  AUDIO_MASK_SIGNED*    = 1 shl 15

func audio_bitsize*(x: uint16): uint16 {.inline.} = x and AUDIO_MASK_BITSIZE
func audio_bytesize*(x: uint16): uint16 {.inline.} = audio_bitsize(x) div 8
func audio_isfloat*(x: uint16): bool {.inline.} = (x and AUDIO_MASK_FLOAT) != 0
func audio_isbigendian*(x: uint16): bool {.inline.} = (x and AUDIO_MASK_ENDIAN) != 0
func audio_islittleendian*(x: uint16): bool {.inline.} = not audio_isbigendian x
func audio_issigned*(x: uint16): bool {.inline.} = (x and AUDIO_MASK_SIGNED) != 0
func audio_isint*(x: uint16): bool {.inline.} = not audio_isfloat(x)
func audio_isunsigned*(x: uint16): bool {.inline.} = not audio_issigned(x)

const
  AUDIO_U8*     = AudioFormat 0x0008  ##  Unsigned 8-bit samples.
  AUDIO_S8*     = AudioFormat 0x8008  ##  Signed 8-bit samples.
  AUDIO_S16LE*  = AudioFormat 0x8010  ##  Signed 16-bit samples (little endian).
  AUDIO_S16BE*  = AudioFormat 0x9010  ##  Signed 16-bit samples (big endian).
  AUDIO_S16*    = AUDIO_S16LE

  AUDIO_S32LE*  = AudioFormat 0x8020  ##  32-bit integer samples (little endian).
  AUDIO_S32BE*  = AudioFormat 0x9020  ##  32-bit integer samples (big endian).
  AUDIO_S32*    = AUDIO_S32LE

  AUDIO_F32LE*  = AudioFormat 0x8120  ##  32-bit floating point samples (little endian).
  AUDIO_F32BE*  = AudioFormat 0x9120  ##  32-bit floating point samples (end endian).
  AUDIO_F32*    = AUDIO_F32LE

when cpuEndian == littleEndian:
  const
    AUDIO_S16SYS* = AUDIO_S16LE
    AUDIO_S32SYS* = AUDIO_S32LE
    AUDIO_F32SYS* = AUDIO_F32LE
else:
  const
    AUDIO_S16SYS* = AUDIO_S16BE
    AUDIO_S32SYS* = AUDIO_S32BE
    AUDIO_F32SYS* = AUDIO_F32BE

type
  AudioDeviceID* = distinct uint32
    ##  Audio Device instance IDs.

const
  AUDIO_DEVICE_DEFAULT_OUTPUT*    = AudioDeviceID 0xffffffff
  AUDIO_DEVICE_DEFAULT_CAPTURE*   = AudioDeviceID 0xfffffffe

type
  AudioSpec* {.final, pure.} = object
    format*     : AudioFormat   ##  Audio data format.
    channels*   : cint          ##  Number of channels.
    freq*       : cint          ##  Sample rate (sample frames per second).

func audio_framesize*(spec: AudioSpec): uint16 {.inline.} =
  audio_bytesize(spec.format.uint16 * spec.channels.uint16)

type
  AudioStream* = ptr object
    ##  Audio stream.

type
  AudioStreamCallback* = proc (userdata: pointer, stream: AudioStream,
                               additional_amount: cint,
                               total_amount: cint) {.cdecl, gcsafe, raises: [].}

  AudioPostmixCallback* = proc (userdata: pointer, spec: ptr AudioSpec,
                                buffer: ptr cfloat,
                                buflen: cint) {.cdecl, gcsafe, raises: [].}

# vim: set sts=2 et sw=2:
