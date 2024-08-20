##  Keyboard keys and modifiers definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  Keycode* = distinct cint
    ##  Virtual key representation.

func `==`*(x, y: Keycode): bool {.borrow.}

const
  SDLK_UNKNOWN*               = Keycode 0x00000000
  SDLK_RETURN*                = Keycode 0x0000000d
  SDLK_ESCAPE*                = Keycode 0x0000001b
  SDLK_BACKSPACE*             = Keycode 0x00000008
  SDLK_TAB*                   = Keycode 0x00000009
  SDLK_SPACE*                 = Keycode 0x00000020
  SDLK_EXCLAIM*               = Keycode 0x00000021
  SDLK_DBLAPOSTROPHE*         = Keycode 0x00000022
  SDLK_HASH*                  = Keycode 0x00000023
  SDLK_DOLLAR*                = Keycode 0x00000024
  SDLK_PERCENT*               = Keycode 0x00000025
  SDLK_AMPERSAND*             = Keycode 0x00000026
  SDLK_APOSTROPHE*            = Keycode 0x00000027
  SDLK_LEFTPAREN*             = Keycode 0x00000028
  SDLK_RIGHTPAREN*            = Keycode 0x00000029
  SDLK_ASTERISK*              = Keycode 0x0000002a
  SDLK_PLUS*                  = Keycode 0x0000002b
  SDLK_COMMA*                 = Keycode 0x0000002c
  SDLK_MINUS*                 = Keycode 0x0000002d
  SDLK_PERIOD*                = Keycode 0x0000002e
  SDLK_SLASH*                 = Keycode 0x0000002f
  SDLK_0*                     = Keycode 0x00000030
  SDLK_1*                     = Keycode 0x00000031
  SDLK_2*                     = Keycode 0x00000032
  SDLK_3*                     = Keycode 0x00000033
  SDLK_4*                     = Keycode 0x00000034
  SDLK_5*                     = Keycode 0x00000035
  SDLK_6*                     = Keycode 0x00000036
  SDLK_7*                     = Keycode 0x00000037
  SDLK_8*                     = Keycode 0x00000038
  SDLK_9*                     = Keycode 0x00000039
  SDLK_COLON*                 = Keycode 0x0000003a
  SDLK_SEMICOLON*             = Keycode 0x0000003b
  SDLK_LESS*                  = Keycode 0x0000003c
  SDLK_EQUALS*                = Keycode 0x0000003d
  SDLK_GREATER*               = Keycode 0x0000003e
  SDLK_QUESTION*              = Keycode 0x0000003f
  SDLK_AT*                    = Keycode 0x00000040
  SDLK_LEFTBRACKET*           = Keycode 0x0000005b
  SDLK_BACKSLASH*             = Keycode 0x0000005c
  SDLK_RIGHTBRACKET*          = Keycode 0x0000005d
  SDLK_CARET*                 = Keycode 0x0000005e
  SDLK_UNDERSCORE*            = Keycode 0x0000005f
  SDLK_GRAVE*                 = Keycode 0x00000060
  SDLK_A*                     = Keycode 0x00000061
  SDLK_B*                     = Keycode 0x00000062
  SDLK_C*                     = Keycode 0x00000063
  SDLK_D*                     = Keycode 0x00000064
  SDLK_E*                     = Keycode 0x00000065
  SDLK_F*                     = Keycode 0x00000066
  SDLK_G*                     = Keycode 0x00000067
  SDLK_H*                     = Keycode 0x00000068
  SDLK_I*                     = Keycode 0x00000069
  SDLK_J*                     = Keycode 0x0000006a
  SDLK_K*                     = Keycode 0x0000006b
  SDLK_L*                     = Keycode 0x0000006c
  SDLK_M*                     = Keycode 0x0000006d
  SDLK_N*                     = Keycode 0x0000006e
  SDLK_O*                     = Keycode 0x0000006f
  SDLK_P*                     = Keycode 0x00000070
  SDLK_Q*                     = Keycode 0x00000071
  SDLK_R*                     = Keycode 0x00000072
  SDLK_S*                     = Keycode 0x00000073
  SDLK_T*                     = Keycode 0x00000074
  SDLK_U*                     = Keycode 0x00000075
  SDLK_V*                     = Keycode 0x00000076
  SDLK_W*                     = Keycode 0x00000077
  SDLK_X*                     = Keycode 0x00000078
  SDLK_Y*                     = Keycode 0x00000079
  SDLK_Z*                     = Keycode 0x0000007a
  SDLK_LEFTBRACE*             = Keycode 0x0000007b
  SDLK_PIPE*                  = Keycode 0x0000007c
  SDLK_RIGHTBRACE*            = Keycode 0x0000007d
  SDLK_TILDE*                 = Keycode 0x0000007e
  SDLK_DELETE*                = Keycode 0x0000007f
  SDLK_PLUSMINUS*             = Keycode 0x000000b1
  SDLK_CAPSLOCK*              = Keycode 0x40000039
  SDLK_F1*                    = Keycode 0x4000003a
  SDLK_F2*                    = Keycode 0x4000003b
  SDLK_F3*                    = Keycode 0x4000003c
  SDLK_F4*                    = Keycode 0x4000003d
  SDLK_F5*                    = Keycode 0x4000003e
  SDLK_F6*                    = Keycode 0x4000003f
  SDLK_F7*                    = Keycode 0x40000040
  SDLK_F8*                    = Keycode 0x40000041
  SDLK_F9*                    = Keycode 0x40000042
  SDLK_F10*                   = Keycode 0x40000043
  SDLK_F11*                   = Keycode 0x40000044
  SDLK_F12*                   = Keycode 0x40000045
  SDLK_PRINTSCREEN*           = Keycode 0x40000046
  SDLK_SCROLLLOCK*            = Keycode 0x40000047
  SDLK_PAUSE*                 = Keycode 0x40000048
  SDLK_INSERT*                = Keycode 0x40000049
  SDLK_HOME*                  = Keycode 0x4000004a
  SDLK_PAGEUP*                = Keycode 0x4000004b
  SDLK_END*                   = Keycode 0x4000004d
  SDLK_PAGEDOWN*              = Keycode 0x4000004e
  SDLK_RIGHT*                 = Keycode 0x4000004f
  SDLK_LEFT*                  = Keycode 0x40000050
  SDLK_DOWN*                  = Keycode 0x40000051
  SDLK_UP*                    = Keycode 0x40000052
  SDLK_NUMLOCKCLEAR*          = Keycode 0x40000053
  SDLK_KP_DIVIDE*             = Keycode 0x40000054
  SDLK_KP_MULTIPLY*           = Keycode 0x40000055
  SDLK_KP_MINUS*              = Keycode 0x40000056
  SDLK_KP_PLUS*               = Keycode 0x40000057
  SDLK_KP_ENTER*              = Keycode 0x40000058
  SDLK_KP_1*                  = Keycode 0x40000059
  SDLK_KP_2*                  = Keycode 0x4000005a
  SDLK_KP_3*                  = Keycode 0x4000005b
  SDLK_KP_4*                  = Keycode 0x4000005c
  SDLK_KP_5*                  = Keycode 0x4000005d
  SDLK_KP_6*                  = Keycode 0x4000005e
  SDLK_KP_7*                  = Keycode 0x4000005f
  SDLK_KP_8*                  = Keycode 0x40000060
  SDLK_KP_9*                  = Keycode 0x40000061
  SDLK_KP_0*                  = Keycode 0x40000062
  SDLK_KP_PERIOD*             = Keycode 0x40000063
  SDLK_APPLICATION*           = Keycode 0x40000065
  SDLK_POWER*                 = Keycode 0x40000066
  SDLK_KP_EQUALS*             = Keycode 0x40000067
  SDLK_F13*                   = Keycode 0x40000068
  SDLK_F14*                   = Keycode 0x40000069
  SDLK_F15*                   = Keycode 0x4000006a
  SDLK_F16*                   = Keycode 0x4000006b
  SDLK_F17*                   = Keycode 0x4000006c
  SDLK_F18*                   = Keycode 0x4000006d
  SDLK_F19*                   = Keycode 0x4000006e
  SDLK_F20*                   = Keycode 0x4000006f
  SDLK_F21*                   = Keycode 0x40000070
  SDLK_F22*                   = Keycode 0x40000071
  SDLK_F23*                   = Keycode 0x40000072
  SDLK_F24*                   = Keycode 0x40000073
  SDLK_EXECUTE*               = Keycode 0x40000074
  SDLK_HELP*                  = Keycode 0x40000075
  SDLK_MENU*                  = Keycode 0x40000076
  SDLK_SELECT*                = Keycode 0x40000077
  SDLK_STOP*                  = Keycode 0x40000078
  SDLK_AGAIN*                 = Keycode 0x40000079
  SDLK_UNDO*                  = Keycode 0x4000007a
  SDLK_CUT*                   = Keycode 0x4000007b
  SDLK_COPY*                  = Keycode 0x4000007c
  SDLK_PASTE*                 = Keycode 0x4000007d
  SDLK_FIND*                  = Keycode 0x4000007e
  SDLK_MUTE*                  = Keycode 0x4000007f
  SDLK_VOLUMEUP*              = Keycode 0x40000080
  SDLK_VOLUMEDOWN*            = Keycode 0x40000081
  SDLK_KP_COMMA*              = Keycode 0x40000085
  SDLK_KP_EQUALSAS400*        = Keycode 0x40000086
  SDLK_ALTERASE*              = Keycode 0x40000099
  SDLK_SYSREQ*                = Keycode 0x4000009a
  SDLK_CANCEL*                = Keycode 0x4000009b
  SDLK_CLEAR*                 = Keycode 0x4000009c
  SDLK_PRIOR*                 = Keycode 0x4000009d
  SDLK_RETURN2*               = Keycode 0x4000009e
  SDLK_SEPARATOR*             = Keycode 0x4000009f
  SDLK_OUT*                   = Keycode 0x400000a0
  SDLK_OPER*                  = Keycode 0x400000a1
  SDLK_CLEARAGAIN*            = Keycode 0x400000a2
  SDLK_CRSEL*                 = Keycode 0x400000a3
  SDLK_EXSEL*                 = Keycode 0x400000a4
  SDLK_KP_00*                 = Keycode 0x400000b0
  SDLK_KP_000*                = Keycode 0x400000b1
  SDLK_THOUSANDSSEPARATOR*    = Keycode 0x400000b2
  SDLK_DECIMALSEPARATOR*      = Keycode 0x400000b3
  SDLK_CURRENCYUNIT*          = Keycode 0x400000b4
  SDLK_CURRENCYSUBUNIT*       = Keycode 0x400000b5
  SDLK_KP_LEFTPAREN*          = Keycode 0x400000b6
  SDLK_KP_RIGHTPAREN*         = Keycode 0x400000b7
  SDLK_KP_LEFTBRACE*          = Keycode 0x400000b8
  SDLK_KP_RIGHTBRACE*         = Keycode 0x400000b9
  SDLK_KP_TAB*                = Keycode 0x400000ba
  SDLK_KP_BACKSPACE*          = Keycode 0x400000bb
  SDLK_KP_A*                  = Keycode 0x400000bc
  SDLK_KP_B*                  = Keycode 0x400000bd
  SDLK_KP_C*                  = Keycode 0x400000be
  SDLK_KP_D*                  = Keycode 0x400000bf
  SDLK_KP_E*                  = Keycode 0x400000c0
  SDLK_KP_F*                  = Keycode 0x400000c1
  SDLK_KP_XOR*                = Keycode 0x400000c2
  SDLK_KP_POWER*              = Keycode 0x400000c3
  SDLK_KP_PERCENT*            = Keycode 0x400000c4
  SDLK_KP_LESS*               = Keycode 0x400000c5
  SDLK_KP_GREATER*            = Keycode 0x400000c6
  SDLK_KP_AMPERSAND*          = Keycode 0x400000c7
  SDLK_KP_DBLAMPERSAND*       = Keycode 0x400000c8
  SDLK_KP_VERTICALBAR*        = Keycode 0x400000c9
  SDLK_KP_DBLVERTICALBAR*     = Keycode 0x400000ca
  SDLK_KP_COLON*              = Keycode 0x400000cb
  SDLK_KP_HASH*               = Keycode 0x400000cc
  SDLK_KP_SPACE*              = Keycode 0x400000cd
  SDLK_KP_AT*                 = Keycode 0x400000ce
  SDLK_KP_EXCLAM*             = Keycode 0x400000cf
  SDLK_KP_MEMSTORE*           = Keycode 0x400000d0
  SDLK_KP_MEMRECALL*          = Keycode 0x400000d1
  SDLK_KP_MEMCLEAR*           = Keycode 0x400000d2
  SDLK_KP_MEMADD*             = Keycode 0x400000d3
  SDLK_KP_MEMSUBTRACT*        = Keycode 0x400000d4
  SDLK_KP_MEMMULTIPLY*        = Keycode 0x400000d5
  SDLK_KP_MEMDIVIDE*          = Keycode 0x400000d6
  SDLK_KP_PLUSMINUS*          = Keycode 0x400000d7
  SDLK_KP_CLEAR*              = Keycode 0x400000d8
  SDLK_KP_CLEARENTRY*         = Keycode 0x400000d9
  SDLK_KP_BINARY*             = Keycode 0x400000da
  SDLK_KP_OCTAL*              = Keycode 0x400000db
  SDLK_KP_DECIMAL*            = Keycode 0x400000dc
  SDLK_KP_HEXADECIMAL*        = Keycode 0x400000dd
  SDLK_LCTRL*                 = Keycode 0x400000e0
  SDLK_LSHIFT*                = Keycode 0x400000e1
  SDLK_LALT*                  = Keycode 0x400000e2
  SDLK_LGUI*                  = Keycode 0x400000e3
  SDLK_RCTRL*                 = Keycode 0x400000e4
  SDLK_RSHIFT*                = Keycode 0x400000e5
  SDLK_RALT*                  = Keycode 0x400000e6
  SDLK_RGUI*                  = Keycode 0x400000e7
  SDLK_MODE*                  = Keycode 0x40000101
  SDLK_SLEEP*                 = Keycode 0x40000102
  SDLK_WAKE*                  = Keycode 0x40000103
  SDLK_CHANNEL_INCREMENT*     = Keycode 0x40000104
  SDLK_CHANNEL_DECREMENT*     = Keycode 0x40000105
  SDLK_MEDIA_PLAY*            = Keycode 0x40000106
  SDLK_MEDIA_PAUSE*           = Keycode 0x40000107
  SDLK_MEDIA_RECORD*          = Keycode 0x40000108
  SDLK_MEDIA_FAST_FORWARD*    = Keycode 0x40000109
  SDLK_MEDIA_REWIND*          = Keycode 0x4000010a
  SDLK_MEDIA_NEXT_TRACK*      = Keycode 0x4000010b
  SDLK_MEDIA_PREVIOUS_TRACK*  = Keycode 0x4000010c
  SDLK_MEDIA_STOP*            = Keycode 0x4000010d
  SDLK_MEDIA_EJECT*           = Keycode 0x4000010e
  SDLK_MEDIA_PLAY_PAUSE*      = Keycode 0x4000010f
  SDLK_MEDIA_SELECT*          = Keycode 0x40000110
  SDLK_AC_NEW*                = Keycode 0x40000111
  SDLK_AC_OPEN*               = Keycode 0x40000112
  SDLK_AC_CLOSE*              = Keycode 0x40000113
  SDLK_AC_EXIT*               = Keycode 0x40000114
  SDLK_AC_SAVE*               = Keycode 0x40000115
  SDLK_AC_PRINT*              = Keycode 0x40000116
  SDLK_AC_PROPERTIES*         = Keycode 0x40000117
  SDLK_AC_SEARCH*             = Keycode 0x40000118
  SDLK_AC_HOME*               = Keycode 0x40000119
  SDLK_AC_BACK*               = Keycode 0x4000011a
  SDLK_AC_FORWARD*            = Keycode 0x4000011b
  SDLK_AC_STOP*               = Keycode 0x4000011c
  SDLK_AC_REFRESH*            = Keycode 0x4000011d
  SDLK_AC_BOOKMARKS*          = Keycode 0x4000011e
  SDLK_SOFTLEFT*              = Keycode 0x4000011f
  SDLK_SOFTRIGHT*             = Keycode 0x40000120
  SDLK_CALL*                  = Keycode 0x40000121
  SDLK_ENDCALL*               = Keycode 0x40000122

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
  KMOD_CTRL*    = KMOD_LCTRL or KMOD_RCTRL
  KMOD_SHIFT*   = KMOD_LSHIFT or KMOD_RSHIFT
  KMOD_ALT*     = KMOD_LALT or KMOD_RALT
  KMOD_GUI*     = KMOD_LGUI or KMOD_RGUI

# vim: set sts=2 et sw=2: