##  Keyboard keys and modifiers definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

import scancode

const SDLK_SCANCODE_MASK = 1'u32 shl 30

type
  Keycode* = distinct cint
    ##  Virtual key representation.

func `==`*(x, y: Keycode): bool {.borrow.}

func scancode_to_keycode(x: Scancode): Keycode {.compiletime.} =
  Keycode x.uint32 or SDLK_SCANCODE_MASK

const
  SDLK_UNKNOWN*             = Keycode 0

  SDLK_RETURN*              = Keycode '\r'
  SDLK_ESCAPE*              = Keycode '\x1b'
  SDLK_BACKSPACE*           = Keycode '\b'
  SDLK_TAB*                 = Keycode '\t'
  SDLK_SPACE*               = Keycode ' '
  SDLK_EXCLAIM*             = Keycode '!'
  SDLK_QUOTEDBL*            = Keycode '"'
  SDLK_HASH*                = Keycode '#'
  SDLK_PERCENT*             = Keycode '%'
  SDLK_DOLLAR*              = Keycode '$'
  SDLK_AMPERSAND*           = Keycode '&'
  SDLK_QUOTE*               = Keycode '\''
  SDLK_LEFTPAREN*           = Keycode '('
  SDLK_RIGHTPAREN*          = Keycode ')'
  SDLK_ASTERISK*            = Keycode '*'
  SDLK_PLUS*                = Keycode '+'
  SDLK_COMMA*               = Keycode ','
  SDLK_MINUS*               = Keycode '-'
  SDLK_PERIOD*              = Keycode '.'
  SDLK_SLASH*               = Keycode '/'
  SDLK_0*                   = Keycode '0'
  SDLK_1*                   = Keycode '1'
  SDLK_2*                   = Keycode '2'
  SDLK_3*                   = Keycode '3'
  SDLK_4*                   = Keycode '4'
  SDLK_5*                   = Keycode '5'
  SDLK_6*                   = Keycode '6'
  SDLK_7*                   = Keycode '7'
  SDLK_8*                   = Keycode '8'
  SDLK_9*                   = Keycode '9'
  SDLK_COLON*               = Keycode ':'
  SDLK_SEMICOLON*           = Keycode ';'
  SDLK_LESS*                = Keycode '<'
  SDLK_EQUALS*              = Keycode '='
  SDLK_GREATER*             = Keycode '>'
  SDLK_QUESTION*            = Keycode '?'
  SDLK_AT*                  = Keycode '@'

  # Skip uppercase letters.

  SDLK_LEFTBRACKET*         = Keycode '['
  SDLK_BACKSLASH*           = Keycode '\\'
  SDLK_RIGHTBRACKET*        = Keycode ']'
  SDLK_CARET*               = Keycode '^'
  SDLK_UNDERSCORE*          = Keycode '_'
  SDLK_BACKQUOTE*           = Keycode '`'
  SDLK_a*                   = Keycode 'a'
  SDLK_b*                   = Keycode 'b'
  SDLK_c*                   = Keycode 'c'
  SDLK_d*                   = Keycode 'd'
  SDLK_e*                   = Keycode 'e'
  SDLK_f*                   = Keycode 'f'
  SDLK_g*                   = Keycode 'g'
  SDLK_h*                   = Keycode 'h'
  SDLK_i*                   = Keycode 'i'
  SDLK_j*                   = Keycode 'j'
  SDLK_k*                   = Keycode 'k'
  SDLK_l*                   = Keycode 'l'
  SDLK_m*                   = Keycode 'm'
  SDLK_n*                   = Keycode 'n'
  SDLK_o*                   = Keycode 'o'
  SDLK_p*                   = Keycode 'p'
  SDLK_q*                   = Keycode 'q'
  SDLK_r*                   = Keycode 'r'
  SDLK_s*                   = Keycode 's'
  SDLK_t*                   = Keycode 't'
  SDLK_u*                   = Keycode 'u'
  SDLK_v*                   = Keycode 'v'
  SDLK_w*                   = Keycode 'w'
  SDLK_x*                   = Keycode 'x'
  SDLK_y*                   = Keycode 'y'
  SDLK_z*                   = Keycode 'z'

  SDLK_CAPSLOCK*            = scancode_to_keycode SCANCODE_CAPSLOCK

  SDLK_F1*                  = scancode_to_keycode SCANCODE_F1
  SDLK_F2*                  = scancode_to_keycode SCANCODE_F2
  SDLK_F3*                  = scancode_to_keycode SCANCODE_F3
  SDLK_F4*                  = scancode_to_keycode SCANCODE_F4
  SDLK_F5*                  = scancode_to_keycode SCANCODE_F5
  SDLK_F6*                  = scancode_to_keycode SCANCODE_F6
  SDLK_F7*                  = scancode_to_keycode SCANCODE_F7
  SDLK_F8*                  = scancode_to_keycode SCANCODE_F8
  SDLK_F9*                  = scancode_to_keycode SCANCODE_F9
  SDLK_F10*                 = scancode_to_keycode SCANCODE_F10
  SDLK_F11*                 = scancode_to_keycode SCANCODE_F11
  SDLK_F12*                 = scancode_to_keycode SCANCODE_F12

  SDLK_PRINTSCREEN*         = scancode_to_keycode SCANCODE_PRINTSCREEN
  SDLK_SCROLLLOCK*          = scancode_to_keycode SCANCODE_SCROLLLOCK
  SDLK_PAUSE*               = scancode_to_keycode SCANCODE_PAUSE
  SDLK_INSERT*              = scancode_to_keycode SCANCODE_INSERT
  SDLK_HOME*                = scancode_to_keycode SCANCODE_HOME
  SDLK_PAGEUP*              = scancode_to_keycode SCANCODE_PAGEUP
  SDLK_DELETE*              = Keycode '\x7f'
  SDLK_END*                 = scancode_to_keycode SCANCODE_END
  SDLK_PAGEDOWN*            = scancode_to_keycode SCANCODE_PAGEDOWN
  SDLK_RIGHT*               = scancode_to_keycode SCANCODE_RIGHT
  SDLK_LEFT*                = scancode_to_keycode SCANCODE_LEFT
  SDLK_DOWN*                = scancode_to_keycode SCANCODE_DOWN
  SDLK_UP*                  = scancode_to_keycode SCANCODE_UP

  SDLK_NUMLOCKCLEAR*        = scancode_to_keycode SCANCODE_NUMLOCKCLEAR
  SDLK_KP_DIVIDE*           = scancode_to_keycode SCANCODE_KP_DIVIDE
  SDLK_KP_MULTIPLY*         = scancode_to_keycode SCANCODE_KP_MULTIPLY
  SDLK_KP_MINUS*            = scancode_to_keycode SCANCODE_KP_MINUS
  SDLK_KP_PLUS*             = scancode_to_keycode SCANCODE_KP_PLUS
  SDLK_KP_ENTER*            = scancode_to_keycode SCANCODE_KP_ENTER
  SDLK_KP_1*                = scancode_to_keycode SCANCODE_KP_1
  SDLK_KP_2*                = scancode_to_keycode SCANCODE_KP_2
  SDLK_KP_3*                = scancode_to_keycode SCANCODE_KP_3
  SDLK_KP_4*                = scancode_to_keycode SCANCODE_KP_4
  SDLK_KP_5*                = scancode_to_keycode SCANCODE_KP_5
  SDLK_KP_6*                = scancode_to_keycode SCANCODE_KP_6
  SDLK_KP_7*                = scancode_to_keycode SCANCODE_KP_7
  SDLK_KP_8*                = scancode_to_keycode SCANCODE_KP_8
  SDLK_KP_9*                = scancode_to_keycode SCANCODE_KP_9
  SDLK_KP_0*                = scancode_to_keycode SCANCODE_KP_0
  SDLK_KP_PERIOD*           = scancode_to_keycode SCANCODE_KP_PERIOD

  SDLK_APPLICATION*         = scancode_to_keycode SCANCODE_APPLICATION
  SDLK_POWER*               = scancode_to_keycode SCANCODE_POWER
  SDLK_KP_EQUALS*           = scancode_to_keycode SCANCODE_KP_EQUALS
  SDLK_F13*                 = scancode_to_keycode SCANCODE_F13
  SDLK_F14*                 = scancode_to_keycode SCANCODE_F14
  SDLK_F15*                 = scancode_to_keycode SCANCODE_F15
  SDLK_F16*                 = scancode_to_keycode SCANCODE_F16
  SDLK_F17*                 = scancode_to_keycode SCANCODE_F17
  SDLK_F18*                 = scancode_to_keycode SCANCODE_F18
  SDLK_F19*                 = scancode_to_keycode SCANCODE_F19
  SDLK_F20*                 = scancode_to_keycode SCANCODE_F20
  SDLK_F21*                 = scancode_to_keycode SCANCODE_F21
  SDLK_F22*                 = scancode_to_keycode SCANCODE_F22
  SDLK_F23*                 = scancode_to_keycode SCANCODE_F23
  SDLK_F24*                 = scancode_to_keycode SCANCODE_F24
  SDLK_EXECUTE*             = scancode_to_keycode SCANCODE_EXECUTE
  SDLK_HELP*                = scancode_to_keycode SCANCODE_HELP
  SDLK_MENU*                = scancode_to_keycode SCANCODE_MENU
  SDLK_SELECT*              = scancode_to_keycode SCANCODE_SELECT
  SDLK_STOP*                = scancode_to_keycode SCANCODE_STOP
  SDLK_AGAIN*               = scancode_to_keycode SCANCODE_AGAIN
  SDLK_UNDO*                = scancode_to_keycode SCANCODE_UNDO
  SDLK_CUT*                 = scancode_to_keycode SCANCODE_CUT
  SDLK_COPY*                = scancode_to_keycode SCANCODE_COPY
  SDLK_PASTE*               = scancode_to_keycode SCANCODE_PASTE
  SDLK_FIND*                = scancode_to_keycode SCANCODE_FIND
  SDLK_MUTE*                = scancode_to_keycode SCANCODE_MUTE
  SDLK_VOLUMEUP*            = scancode_to_keycode SCANCODE_VOLUMEUP
  SDLK_VOLUMEDOWN*          = scancode_to_keycode SCANCODE_VOLUMEDOWN
  SDLK_KP_COMMA*            = scancode_to_keycode SCANCODE_KP_COMMA
  SDLK_KP_EQUALSAS400*      = scancode_to_keycode SCANCODE_KP_EQUALSAS400

  SDLK_ALTERASE*            = scancode_to_keycode SCANCODE_ALTERASE
  SDLK_SYSREQ*              = scancode_to_keycode SCANCODE_SYSREQ
  SDLK_CANCEL*              = scancode_to_keycode SCANCODE_CANCEL
  SDLK_CLEAR*               = scancode_to_keycode SCANCODE_CLEAR
  SDLK_PRIOR*               = scancode_to_keycode SCANCODE_PRIOR
  SDLK_RETURN2*             = scancode_to_keycode SCANCODE_RETURN2
  SDLK_SEPARATOR*           = scancode_to_keycode SCANCODE_SEPARATOR
  SDLK_OUT*                 = scancode_to_keycode SCANCODE_OUT
  SDLK_OPER*                = scancode_to_keycode SCANCODE_OPER
  SDLK_CLEARAGAIN*          = scancode_to_keycode SCANCODE_CLEARAGAIN
  SDLK_CRSEL*               = scancode_to_keycode SCANCODE_CRSEL
  SDLK_EXSEL*               = scancode_to_keycode SCANCODE_EXSEL

  SDLK_KP_00*               = scancode_to_keycode SCANCODE_KP_00
  SDLK_KP_000*              = scancode_to_keycode SCANCODE_KP_000
  SDLK_THOUSANDSSEPARATOR*  = scancode_to_keycode SCANCODE_THOUSANDSSEPARATOR
  SDLK_DECIMALSEPARATOR*    = scancode_to_keycode SCANCODE_DECIMALSEPARATOR
  SDLK_CURRENCYUNIT*        = scancode_to_keycode SCANCODE_CURRENCYUNIT
  SDLK_CURRENCYSUBUNIT*     = scancode_to_keycode SCANCODE_CURRENCYSUBUNIT
  SDLK_KP_LEFTPAREN*        = scancode_to_keycode SCANCODE_KP_LEFTPAREN
  SDLK_KP_RIGHTPAREN*       = scancode_to_keycode SCANCODE_KP_RIGHTPAREN
  SDLK_KP_LEFTBRACE*        = scancode_to_keycode SCANCODE_KP_LEFTBRACE
  SDLK_KP_RIGHTBRACE*       = scancode_to_keycode SCANCODE_KP_RIGHTBRACE
  SDLK_KP_TAB*              = scancode_to_keycode SCANCODE_KP_TAB
  SDLK_KP_BACKSPACE*        = scancode_to_keycode SCANCODE_KP_BACKSPACE
  SDLK_KP_A*                = scancode_to_keycode SCANCODE_KP_A
  SDLK_KP_B*                = scancode_to_keycode SCANCODE_KP_B
  SDLK_KP_C*                = scancode_to_keycode SCANCODE_KP_C
  SDLK_KP_D*                = scancode_to_keycode SCANCODE_KP_D
  SDLK_KP_E*                = scancode_to_keycode SCANCODE_KP_E
  SDLK_KP_F*                = scancode_to_keycode SCANCODE_KP_F
  SDLK_KP_XOR*              = scancode_to_keycode SCANCODE_KP_XOR
  SDLK_KP_POWER*            = scancode_to_keycode SCANCODE_KP_POWER
  SDLK_KP_PERCENT*          = scancode_to_keycode SCANCODE_KP_PERCENT
  SDLK_KP_LESS*             = scancode_to_keycode SCANCODE_KP_LESS
  SDLK_KP_GREATER*          = scancode_to_keycode SCANCODE_KP_GREATER
  SDLK_KP_AMPERSAND*        = scancode_to_keycode SCANCODE_KP_AMPERSAND
  SDLK_KP_DBLAMPERSAND*     = scancode_to_keycode SCANCODE_KP_DBLAMPERSAND
  SDLK_KP_VERTICALBAR*      = scancode_to_keycode SCANCODE_KP_VERTICALBAR
  SDLK_KP_DBLVERTICALBAR*   = scancode_to_keycode SCANCODE_KP_DBLVERTICALBAR
  SDLK_KP_COLON*            = scancode_to_keycode SCANCODE_KP_COLON
  SDLK_KP_HASH*             = scancode_to_keycode SCANCODE_KP_HASH
  SDLK_KP_SPACE*            = scancode_to_keycode SCANCODE_KP_SPACE
  SDLK_KP_AT*               = scancode_to_keycode SCANCODE_KP_AT
  SDLK_KP_EXCLAM*           = scancode_to_keycode SCANCODE_KP_EXCLAM
  SDLK_KP_MEMSTORE*         = scancode_to_keycode SCANCODE_KP_MEMSTORE
  SDLK_KP_MEMRECALL*        = scancode_to_keycode SCANCODE_KP_MEMRECALL
  SDLK_KP_MEMCLEAR*         = scancode_to_keycode SCANCODE_KP_MEMCLEAR
  SDLK_KP_MEMADD*           = scancode_to_keycode SCANCODE_KP_MEMADD
  SDLK_KP_MEMSUBTRACT*      = scancode_to_keycode SCANCODE_KP_MEMSUBTRACT
  SDLK_KP_MEMMULTIPLY*      = scancode_to_keycode SCANCODE_KP_MEMMULTIPLY
  SDLK_KP_MEMDIVIDE*        = scancode_to_keycode SCANCODE_KP_MEMDIVIDE
  SDLK_KP_PLUSMINUS*        = scancode_to_keycode SCANCODE_KP_PLUSMINUS
  SDLK_KP_CLEAR*            = scancode_to_keycode SCANCODE_KP_CLEAR
  SDLK_KP_CLEARENTRY*       = scancode_to_keycode SCANCODE_KP_CLEARENTRY
  SDLK_KP_BINARY*           = scancode_to_keycode SCANCODE_KP_BINARY
  SDLK_KP_OCTAL*            = scancode_to_keycode SCANCODE_KP_OCTAL
  SDLK_KP_DECIMAL*          = scancode_to_keycode SCANCODE_KP_DECIMAL
  SDLK_KP_HEXADECIMAL*      = scancode_to_keycode SCANCODE_KP_HEXADECIMAL

  SDLK_LCTRL*               = scancode_to_keycode SCANCODE_LCTRL
  SDLK_LSHIFT*              = scancode_to_keycode SCANCODE_LSHIFT
  SDLK_LALT*                = scancode_to_keycode SCANCODE_LALT
  SDLK_LGUI*                = scancode_to_keycode SCANCODE_LGUI
  SDLK_RCTRL*               = scancode_to_keycode SCANCODE_RCTRL
  SDLK_RSHIFT*              = scancode_to_keycode SCANCODE_RSHIFT
  SDLK_RALT*                = scancode_to_keycode SCANCODE_RALT
  SDLK_RGUI*                = scancode_to_keycode SCANCODE_RGUI

  SDLK_MODE*                = scancode_to_keycode SCANCODE_MODE

  SDLK_AUDIONEXT*           = scancode_to_keycode SCANCODE_AUDIONEXT
  SDLK_AUDIOPREV*           = scancode_to_keycode SCANCODE_AUDIOPREV
  SDLK_AUDIOSTOP*           = scancode_to_keycode SCANCODE_AUDIOSTOP
  SDLK_AUDIOPLAY*           = scancode_to_keycode SCANCODE_AUDIOPLAY
  SDLK_AUDIOMUTE*           = scancode_to_keycode SCANCODE_AUDIOMUTE
  SDLK_MEDIASELECT*         = scancode_to_keycode SCANCODE_MEDIASELECT
  SDLK_WWW*                 = scancode_to_keycode SCANCODE_WWW
  SDLK_MAIL*                = scancode_to_keycode SCANCODE_MAIL
  SDLK_CALCULATOR*          = scancode_to_keycode SCANCODE_CALCULATOR
  SDLK_COMPUTER*            = scancode_to_keycode SCANCODE_COMPUTER
  SDLK_AC_SEARCH*           = scancode_to_keycode SCANCODE_AC_SEARCH
  SDLK_AC_HOME*             = scancode_to_keycode SCANCODE_AC_HOME
  SDLK_AC_BACK*             = scancode_to_keycode SCANCODE_AC_BACK
  SDLK_AC_FORWARD*          = scancode_to_keycode SCANCODE_AC_FORWARD
  SDLK_AC_STOP*             = scancode_to_keycode SCANCODE_AC_STOP
  SDLK_AC_REFRESH*          = scancode_to_keycode SCANCODE_AC_REFRESH
  SDLK_AC_BOOKMARKS*        = scancode_to_keycode SCANCODE_AC_BOOKMARKS

  SDLK_BRIGHTNESSDOWN*      = scancode_to_keycode SCANCODE_BRIGHTNESSDOWN
  SDLK_BRIGHTNESSUP*        = scancode_to_keycode SCANCODE_BRIGHTNESSUP
  SDLK_DISPLAYSWITCH*       = scancode_to_keycode SCANCODE_DISPLAYSWITCH
  SDLK_KBDILLUMTOGGLE*      = scancode_to_keycode SCANCODE_KBDILLUMTOGGLE
  SDLK_KBDILLUMDOWN*        = scancode_to_keycode SCANCODE_KBDILLUMDOWN
  SDLK_KBDILLUMUP*          = scancode_to_keycode SCANCODE_KBDILLUMUP
  SDLK_EJECT*               = scancode_to_keycode SCANCODE_EJECT
  SDLK_SLEEP*               = scancode_to_keycode SCANCODE_SLEEP
  SDLK_APP1*                = scancode_to_keycode SCANCODE_APP1
  SDLK_APP2*                = scancode_to_keycode SCANCODE_APP2

  SDLK_AUDIOREWIND*         = scancode_to_keycode SCANCODE_AUDIOREWIND
  SDLK_AUDIOFASTFORWARD*    = scancode_to_keycode SCANCODE_AUDIOFASTFORWARD

  SDLK_SOFTLEFT*            = scancode_to_keycode SCANCODE_SOFTLEFT
  SDLK_SOFTRIGHT*           = scancode_to_keycode SCANCODE_SOFTRIGHT
  SDLK_CALL*                = scancode_to_keycode SCANCODE_CALL
  SDLK_ENDCALL*             = scancode_to_keycode SCANCODE_ENDCALL

type
  Keymod* = distinct uint16
    ##  Valid key mods.

func `==`*(x, y: Keymod): bool {.borrow.}
func `and`*(a, b: Keymod): Keymod {.borrow.}
func `or`(a, b: Keymod): Keymod {.borrow.}

const
  KMOD_NONE*    = Keymod 0x0000
  KMOD_LSHIFT*  = Keymod 0x0001
  KMOD_RSHIFT*  = Keymod 0x0002
  KMOD_LCTRL*   = Keymod 0x0040
  KMOD_RCTRL*   = Keymod 0x0080
  KMOD_LALT*    = Keymod 0x0100
  KMOD_RALT*    = Keymod 0x0200
  KMOD_LGUI*    = Keymod 0x0400
  KMOD_RGUI*    = Keymod 0x0800
  KMOD_NUM*     = Keymod 0x1000
  KMOD_CAPS*    = Keymod 0x2000
  KMOD_MODE*    = Keymod 0x4000
  KMOD_SCROLL*  = Keymod 0x8000

const
  KMOD_CTRL*    = KMOD_LCTRL or KMOD_RCTRL
  KMOD_SHIFT*   = KMOD_LSHIFT or KMOD_RSHIFT
  KMOD_ALT*     = KMOD_LALT or KMOD_RALT
  KMOD_GUI*     = KMOD_LGUI or KMOD_RGUI

const
  KMOD_RESERVED*  = KMOD_SCROLL     ##  SDL2 compat.

# vim: set sts=2 et sw=2:
