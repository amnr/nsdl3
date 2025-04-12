##  RWops definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  IOStatus* {.size: cint.sizeof.} = enum
    ##  IOStream status, set by a read or write operation.
    IO_STATUS_READY
    IO_STATUS_ERROR
    IO_STATUS_EOF
    IO_STATUS_NOT_READY
    IO_STATUS_READONLY
    IO_STATUS_WRITEONLY

type
  IOWhence* {.size: cint.sizeof.} = enum
    ##  Possible `whence` values for `IOStream` seeking.
    IO_SEEK_SET
    IO_SEEK_CUR
    IO_SEEK_END

# TODO: IOStreamInterface.
#[
SDL_COMPILE_TIME_ASSERT(SDL_IOStreamInterface_SIZE,
    (sizeof(void *) == 4 && sizeof(SDL_IOStreamInterface) == 28) ||
    (sizeof(void *) == 8 && sizeof(SDL_IOStreamInterface) == 56));
]#

#define SDL_PROP_IOSTREAM_WINDOWS_HANDLE_POINTER    "SDL.iostream.windows.handle"
#define SDL_PROP_IOSTREAM_STDIO_FILE_POINTER        "SDL.iostream.stdio.file"
#define SDL_PROP_IOSTREAM_FILE_DESCRIPTOR_NUMBER    "SDL.iostream.file_descriptor"
#define SDL_PROP_IOSTREAM_ANDROID_AASSET_POINTER    "SDL.iostream.android.aasset"

#define SDL_PROP_IOSTREAM_MEMORY_POINTER "SDL.iostream.memory.base"
#define SDL_PROP_IOSTREAM_MEMORY_SIZE_NUMBER  "SDL.iostream.memory.size"

#define SDL_PROP_IOSTREAM_DYNAMIC_MEMORY_POINTER    "SDL.iostream.dynamic.memory"
#define SDL_PROP_IOSTREAM_DYNAMIC_CHUNKSIZE_NUMBER  "SDL.iostream.dynamic.chunksize"


type
  IOStream* = ptr object
    ##  The read/write operation structure.

# vim: set sts=2 et sw=2:
