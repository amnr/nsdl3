##  Filesystem definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

#[*
 * The type of the OS-provided default folder for a specific purpose.
 *
 * Note that the Trash folder isn't included here, because trashing files
 * usually involves extra OS-specific functionality to remember the file's
 * original location.
 *
 * The folders supported per platform are:
 *
 * |             | Windows | macOS/iOS | tvOS | Unix (XDG) | Haiku | Emscripten |
 * | ----------- | ------- | --------- | ---- | ---------- | ----- | ---------- |
 * | HOME        | X       | X         |      | X          | X     | X          |
 * | DESKTOP     | X       | X         |      | X          | X     |            |
 * | DOCUMENTS   | X       | X         |      | X          |       |            |
 * | DOWNLOADS   | Vista+  | X         |      | X          |       |            |
 * | MUSIC       | X       | X         |      | X          |       |            |
 * | PICTURES    | X       | X         |      | X          |       |            |
 * | PUBLICSHARE |         | X         |      | X          |       |            |
 * | SAVEDGAMES  | Vista+  |           |      |            |       |            |
 * | SCREENSHOTS | Vista+  |           |      |            |       |            |
 * | TEMPLATES   | X       | X         |      | X          |       |            |
 * | VIDEOS      | X       | X*        |      | X          |       |            |
 *
 * Note that on macOS/iOS, the Videos folder is called "Movies".
 *
 * \since This enum is available since SDL 3.2.0.
 *
 * \sa SDL_GetUserFolder
 ]#

type
  Folder* {.size: cint.sizeof.} = enum
    ##  OS-provided default folder.
    SDL_FOLDER_HOME
    SDL_FOLDER_DESKTOP
    SDL_FOLDER_DOCUMENTS
    SDL_FOLDER_DOWNLOADS
    SDL_FOLDER_MUSIC
    SDL_FOLDER_PICTURES
    SDL_FOLDER_PUBLICSHARE
    SDL_FOLDER_SAVEDGAMES
    SDL_FOLDER_SCREENSHOTS
    SDL_FOLDER_TEMPLATES
    SDL_FOLDER_VIDEOS
    SDL_FOLDER_COUNT

type
  PathType* {.size: cint.sizeof.} = enum
    ##  Types of filesystem entries.
    PATHTYPE_NONE
    PATHTYPE_FILE
    PATHTYPE_DIRECTORY
    PATHTYPE_OTHER

type
  PathInfo* {.final, pure.} = object
    ##  Information about a path on the filesystem.
    typ     : PathType        # type;      /**< the path type */
    #Uint64 size;            #/**< the file size in bytes */
    #SDL_Time create_time;   #/**< the time when the path was created */
    #SDL_Time modify_time;   #/**< the last time the path was modified */
    #SDL_Time access_time;   #/**< the last time the path was read */

type
  GlobFlags* = distinct uint32
    ##  Flags for path matching.

const
  GLOB_CASEINSENSITIVE*   = GlobFlags 1u32 shl 0

type
  EnumerationResult* {.size: cint.sizeof.} = enum
    ##  Possible results from an enumeration callback.
    ENUM_CONTINUE
    ENUM_SUCCESS
    ENUM_FAILURE

type
  EnumerateDirectoryCallback* = proc (
    userdata  : pointer,
    dirname   : cstring,
    fname     : cstring
  ): EnumerationResult {.cdecl, gcsafe, raises: [].}
    ##  Callback for directory enumeration.

# vim: set sts=2 et sw=2:
