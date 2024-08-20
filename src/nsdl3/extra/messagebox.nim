##  Message box utils.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

import ../../nsdl3

{.push inline.}

proc show_error_message_box*(window: Window,
                             title, message: string): bool {.inline.} =
  ShowSimpleMessageBox MESSAGEBOX_ERROR, title, message, window

proc show_info_message_box*(window: Window,
                            title, message: string): bool {.inline.} =
  ShowSimpleMessageBox MESSAGEBOX_INFORMATION, title, message, window

proc show_warning_message_box*(window: Window,
                               title, message: string): bool {.inline.} =
  ShowSimpleMessageBox MESSAGEBOX_WARNING, title, message, window

{.pop.}   # inline.

# vim: set sts=2 et sw=2:
