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

type
  FileDialogType* {.size: cint.sizeof.} = enum
    ##  Dialog types.
    FILEDIALOG_OPENFILE
    FILEDIALOG_SAVEFILE
    FILEDIALOG_OPENFOLDER

const
  PROP_FILE_DIALOG_FILTERS_POINTER* = cstring "SDL.filedialog.filters"
  PROP_FILE_DIALOG_NFILTERS_NUMBER* = cstring "SDL.filedialog.nfilters"
  PROP_FILE_DIALOG_WINDOW_POINTER*  = cstring "SDL.filedialog.window"
  PROP_FILE_DIALOG_LOCATION_STRING* = cstring "SDL.filedialog.location"
  PROP_FILE_DIALOG_MANY_BOOLEAN*    = cstring "SDL.filedialog.many"
  PROP_FILE_DIALOG_TITLE_STRING*    = cstring "SDL.filedialog.title"
  PROP_FILE_DIALOG_ACCEPT_STRING*   = cstring "SDL.filedialog.accept"
  PROP_FILE_DIALOG_CANCEL_STRING*   = cstring "SDL.filedialog.cancel"

# vim: set sts=2 et sw=2:
