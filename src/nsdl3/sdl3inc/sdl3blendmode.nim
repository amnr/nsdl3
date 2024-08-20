##  Blend modes.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  BlendMode* = distinct cint
    ##  Blend mode.

func `or`*(a, b: BlendMode): BlendMode {.borrow.}

const
  BLENDMODE_NONE*     = BlendMode 0x00000000
  BLENDMODE_BLEND*    = BlendMode 0x00000001
  BLENDMODE_ADD*      = BlendMode 0x00000002
  BLENDMODE_MOD*      = BlendMode 0x00000004
  BLENDMODE_MUL*      = BlendMode 0x00000008
  BLENDMODE_INVALID*  = BlendMode 0x7fffffff

type
  BlendOperation* {.size: cint.sizeof.} = enum
    ##  Blend operation.
    BLENDOPERATION_ADD            = 0x1
    BLENDOPERATION_SUBTRACT       = 0x2
    BLENDOPERATION_REV_SUBTRACT   = 0x3
    BLENDOPERATION_MINIMUM        = 0x4
    BLENDOPERATION_MAXIMUM        = 0x5

type
  BlendFactor* {.size: cint.sizeof.} = enum
    ##  Blend factor.
    BLENDFACTOR_ZERO                = 0x1
    BLENDFACTOR_ONE                 = 0x2
    BLENDFACTOR_SRC_COLOR           = 0x3
    BLENDFACTOR_ONE_MINUS_SRC_COLOR = 0x4
    BLENDFACTOR_SRC_ALPHA           = 0x5
    BLENDFACTOR_ONE_MINUS_SRC_ALPHA = 0x6
    BLENDFACTOR_DST_COLOR           = 0x7
    BLENDFACTOR_ONE_MINUS_DST_COLOR = 0x8
    BLENDFACTOR_DST_ALPHA           = 0x9
    BLENDFACTOR_ONE_MINUS_DST_ALPHA = 0xa

# vim: set sts=2 et sw=2:
