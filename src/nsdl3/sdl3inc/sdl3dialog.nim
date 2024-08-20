##  Dialog.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

type
  DialogFileFilter* {.final, pure.} = object
    name*     : cstring
    pattern*  : cstring

  DialogFileCallback* = proc (
    userdata  : pointer,
    filelist  : cstringArray,
    filter    : cint
  ) {.cdecl, gcsafe, raises: [].}

# vim: set sts=2 et sw=2:
