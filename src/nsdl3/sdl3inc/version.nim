##  Version definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  Version* {.final, pure.} = object
    ##  SDL version.
    major*    : byte
    minor*    : byte
    patch*    : byte

# vim: set sts=2 et sw=2:
