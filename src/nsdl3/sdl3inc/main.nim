##  Main definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from events import Event

type
  AppInitFunc* = proc (
    appstate  : ptr pointer,
    argc      : cint,
    argv      : cstringArray
  ): cint {.cdecl, gcsafe, raises: [].}

  AppIterateFunc* = proc (
    appstate  : ptr pointer
  ): cint {.cdecl, gcsafe, raises: [].}

  AppEventFunc* = proc (
    appstate  : ptr pointer,
    event     : ptr Event
  ): cint {.cdecl, gcsafe, raises: [].}

  AppQuitFunc* = proc (
    appstate  : ptr pointer
  ) {.cdecl, gcsafe, raises: [].}

  MainFunc* = proc (
    argc      : cint,
    argv      : cstringArray
  ): cint {.cdecl, gcsafe, raises: [].}

# vim: set sts=2 et sw=2:
