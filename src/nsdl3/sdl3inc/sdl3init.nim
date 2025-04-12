##  Init definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  cbool* = distinct byte

type
  InitFlags* = distinct uint32
    ##  Window flags.

func `or`*(a, b: InitFlags): InitFlags {.borrow.}

const
  INIT_NONE*      = InitFlags 0x0000_0000   ##  Nim specific.
  INIT_AUDIO*     = InitFlags 0x0000_0010   ##  Implies `INIT_EVENTS`.
  INIT_VIDEO*     = InitFlags 0x0000_0020   ##  Implies `INIT_EVENTS`.
  INIT_JOYSTICK*  = InitFlags 0x0000_0200   ##  Implies `INIT_EVENTS`.
  INIT_HAPTIC*    = InitFlags 0x0000_1000
  INIT_GAMEPAD*   = InitFlags 0x0000_2000   ##  Implies `INIT_JOYSTICK`.
  INIT_EVENTS*    = InitFlags 0x0000_4000
  INIT_SENSOR*    = InitFlags 0x0000_8000   ##  Implies `INIT_EVENTS`.
  INIT_CAMERA*    = InitFlags 0x0001_0000   ##  Implies `INIT_EVENTS`.

type
  AppResult* {.size: cint.sizeof.} = enum
    ##  Return values for optional main callbacks.
    APP_CONTINUE
    APP_SUCCESS
    APP_FAILURE

type
  AppInit_func* = proc (appstate: ptr pointer, argc: cint, argv: cstringArray): AppResult {.cdecl.}
  AppIterate_func* = proc (appstate: pointer): AppResult {.cdecl.}
  # XXX: AppEvent_func* = proc (appstate: pointer, event: ptr Event): AppResult {.cdecl.}
  AppQuit_func* = proc (appstate: pointer, res: AppResult) {.cdecl.}

type
  MainThreadCallback* = proc (userdata: pointer) {.cdecl.}

type
  AppMetadataProperty* = enum
    PROP_APP_METADATA_NAME_STRING       = cstring"SDL.app.metadata.name"
    PROP_APP_METADATA_VERSION_STRING    = cstring"SDL.app.metadata.version"
    PROP_APP_METADATA_IDENTIFIER_STRING = cstring"SDL.app.metadata.identifier"
    PROP_APP_METADATA_CREATOR_STRING    = cstring"SDL.app.metadata.creator"
    PROP_APP_METADATA_COPYRIGHT_STRING  = cstring"SDL.app.metadata.copyright"
    PROP_APP_METADATA_URL_STRING        = cstring"SDL.app.metadata.url"
    PROP_APP_METADATA_TYPE_STRING       = cstring"SDL.app.metadata.type"

# vim: set sts=2 et sw=2:
