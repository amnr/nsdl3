##  Properties.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  PropertiesID* = distinct uint32
    ##  Properties ID.

func `==`*(a, b: PropertiesID): bool {.borrow.}

type
  PropertyType* {.size: cint.sizeof.} = enum
    ##  Property type.
    PROPERTY_TYPE_INVALID
    PROPERTY_TYPE_POINTER
    PROPERTY_TYPE_STRING
    PROPERTY_TYPE_NUMBER
    PROPERTY_TYPE_FLOAT
    PROPERTY_TYPE_BOOLEAN

# XXX: typedef void (SDLCALL *SDL_CleanupPropertyCallback)(void *userdata, void *value);

type
  EnumeratePropertiesCallback* = proc (
    userdata  : pointer,
    props     : PropertiesID,
    name      : cstring
  ) {.cdecl, raises: [].}

# vim: set sts=2 et sw=2:
