##  Clipboard.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  ClipboardDataCallback* = proc (
    userdata  : pointer,
    mime_type : cstring,
    size      : csize_t
  ): pointer {.cdecl, raises: [].}
    ##  Callback function that will be called when data for the specified
    ##  mime-type is requested by the OS.
    ##
    ##  The callback function is called with NULL as the mime_type when the clipboard
    ##  is cleared or new data is set. The clipboard is automatically cleared in SDL_Quit().

  ClipboardCleanupCallback* = proc (userdata: pointer) {.cdecl, raises: [].}
    ##  Callback function that will be called when the clipboard is cleared,
    ##  or new data is set.

# vim: set sts=2 et sw=2:
