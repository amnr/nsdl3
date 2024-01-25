##  Init definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  SdlBool* = distinct cuint

type
  InitFlags* = distinct uint32
    ##  Window flags.

func `or`*(a, b: InitFlags): InitFlags {.borrow.}

const
  INIT_NONE*      = InitFlags 0x0000_0000   ##  Nim specific.
  INIT_TIMER*     = InitFlags 0x0000_0001
  INIT_AUDIO*     = InitFlags 0x0000_0010
  INIT_VIDEO*     = InitFlags 0x0000_0020   ##  Implies `INIT_EVENTS`.
  INIT_JOYSTICK*  = InitFlags 0x0000_0200   ##  Implies `INIT_EVENTS`.
  INIT_HAPTIC*    = InitFlags 0x0000_1000
  INIT_GAMEPAD*   = InitFlags 0x0000_2000   ##  Implies `INIT_JOYSTICK`.
  INIT_EVENTS*    = InitFlags 0x0000_4000
  INIT_SENSOR*    = InitFlags 0x0000_8000

# vim: set sts=2 et sw=2:
