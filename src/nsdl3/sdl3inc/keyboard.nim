##  Keyboard event definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  KeyboardID* = distinct uint32
    ##  Keyboard ID.

type
  TextInputType* {.size: cint.sizeof.} = enum
    ##  Text input type.
    TEXTINPUT_TYPE_TEXT
    TEXTINPUT_TYPE_TEXT_NAME
    TEXTINPUT_TYPE_TEXT_EMAIL
    TEXTINPUT_TYPE_TEXT_USERNAME
    TEXTINPUT_TYPE_TEXT_PASSWORD_HIDDEN
    TEXTINPUT_TYPE_TEXT_PASSWORD_VISIBLE
    TEXTINPUT_TYPE_NUMBER
    TEXTINPUT_TYPE_NUMBER_PASSWORD_HIDDEN
    TEXTINPUT_TYPE_NUMBER_PASSWORD_VISIBLE

  Capitalization* {.size: cint.sizeof.} = enum
    ##  Auto capitalization type.
    CAPITALIZE_NONE
    CAPITALIZE_SENTENCES
    CAPITALIZE_WORDS
    CAPITALIZE_LETTERS

  PropTextInput* = enum
    ##  Text input property.
    PROP_TEXTINPUT_TYPE_NUMBER              = cstring"SDL.textinput.type"
    PROP_TEXTINPUT_CAPITALIZATION_NUMBER    = cstring"SDL.textinput.capitalization"
    PROP_TEXTINPUT_AUTOCORRECT_BOOLEAN      = cstring"SDL.textinput.autocorrect"
    PROP_TEXTINPUT_MULTILINE_BOOLEAN        = cstring"SDL.textinput.multiline"
    PROP_TEXTINPUT_ANDROID_INPUTTYPE_NUMBER = cstring"SDL.textinput.android.inputtype"

# vim: set sts=2 et sw=2:
