##  Main definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from events import Event

type
  AppInit_func* = proc (argc: cint, argv: cstringArray): cint {.cdecl, gcsafe, raises: [].}

  AppIterate_func* = proc (): cint {.cdecl, gcsafe, raises: [].}

  AppEvent_func* = proc (event: ptr Event): cint {.cdecl, gcsafe, raises: [].}

  AppQuit_func* = proc () {.cdecl, gcsafe, raises: [].}

  Main_func* = proc (argc: cint, argv: cstringArray): cint {.cdecl, gcsafe, raises: [].}

# vim: set sts=2 et sw=2:
