##  Keyboard scancodes definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  Scancode* = distinct cint
    ##  Keyboard scancode.

const
  SCANCODE_UNKNOWN*               = Scancode 0

  SCANCODE_A*                     = Scancode 4
  SCANCODE_B*                     = Scancode 5
  SCANCODE_C*                     = Scancode 6
  SCANCODE_D*                     = Scancode 7
  SCANCODE_E*                     = Scancode 8
  SCANCODE_F*                     = Scancode 9
  SCANCODE_G*                     = Scancode 10
  SCANCODE_H*                     = Scancode 11
  SCANCODE_I*                     = Scancode 12
  SCANCODE_J*                     = Scancode 13
  SCANCODE_K*                     = Scancode 14
  SCANCODE_L*                     = Scancode 15
  SCANCODE_M*                     = Scancode 16
  SCANCODE_N*                     = Scancode 17
  SCANCODE_O*                     = Scancode 18
  SCANCODE_P*                     = Scancode 19
  SCANCODE_Q*                     = Scancode 20
  SCANCODE_R*                     = Scancode 21
  SCANCODE_S*                     = Scancode 22
  SCANCODE_T*                     = Scancode 23
  SCANCODE_U*                     = Scancode 24
  SCANCODE_V*                     = Scancode 25
  SCANCODE_W*                     = Scancode 26
  SCANCODE_X*                     = Scancode 27
  SCANCODE_Y*                     = Scancode 28
  SCANCODE_Z*                     = Scancode 29

  SCANCODE_1*                     = Scancode 30
  SCANCODE_2*                     = Scancode 31
  SCANCODE_3*                     = Scancode 32
  SCANCODE_4*                     = Scancode 33
  SCANCODE_5*                     = Scancode 34
  SCANCODE_6*                     = Scancode 35
  SCANCODE_7*                     = Scancode 36
  SCANCODE_8*                     = Scancode 37
  SCANCODE_9*                     = Scancode 38
  SCANCODE_0*                     = Scancode 39

  SCANCODE_RETURN*                = Scancode 40
  SCANCODE_ESCAPE*                = Scancode 41
  SCANCODE_BACKSPACE*             = Scancode 42
  SCANCODE_TAB*                   = Scancode 43
  SCANCODE_SPACE*                 = Scancode 44

  SCANCODE_MINUS*                 = Scancode 45
  SCANCODE_EQUALS*                = Scancode 46
  SCANCODE_LEFTBRACKET*           = Scancode 47
  SCANCODE_RIGHTBRACKET*          = Scancode 48
  SCANCODE_BACKSLASH*             = Scancode 49
  SCANCODE_NONUSHASH*             = Scancode 50
  SCANCODE_SEMICOLON*             = Scancode 51
  SCANCODE_APOSTROPHE*            = Scancode 52
  SCANCODE_GRAVE*                 = Scancode 53
  SCANCODE_COMMA*                 = Scancode 54
  SCANCODE_PERIOD*                = Scancode 55
  SCANCODE_SLASH*                 = Scancode 56

  SCANCODE_CAPSLOCK*              = Scancode 57

  SCANCODE_F1*                    = Scancode 58
  SCANCODE_F2*                    = Scancode 59
  SCANCODE_F3*                    = Scancode 60
  SCANCODE_F4*                    = Scancode 61
  SCANCODE_F5*                    = Scancode 62
  SCANCODE_F6*                    = Scancode 63
  SCANCODE_F7*                    = Scancode 64
  SCANCODE_F8*                    = Scancode 65
  SCANCODE_F9*                    = Scancode 66
  SCANCODE_F10*                   = Scancode 67
  SCANCODE_F11*                   = Scancode 68
  SCANCODE_F12*                   = Scancode 69

  SCANCODE_PRINTSCREEN*           = Scancode 70
  SCANCODE_SCROLLLOCK*            = Scancode 71
  SCANCODE_PAUSE*                 = Scancode 72
  SCANCODE_INSERT*                = Scancode 73
  SCANCODE_HOME*                  = Scancode 74
  SCANCODE_PAGEUP*                = Scancode 75
  SCANCODE_DELETE*                = Scancode 76
  SCANCODE_END*                   = Scancode 77
  SCANCODE_PAGEDOWN*              = Scancode 78
  SCANCODE_RIGHT*                 = Scancode 79
  SCANCODE_LEFT*                  = Scancode 80
  SCANCODE_DOWN*                  = Scancode 81
  SCANCODE_UP*                    = Scancode 82

  SCANCODE_NUMLOCKCLEAR*          = Scancode 83

  SCANCODE_KP_DIVIDE*             = Scancode 84
  SCANCODE_KP_MULTIPLY*           = Scancode 85
  SCANCODE_KP_MINUS*              = Scancode 86
  SCANCODE_KP_PLUS*               = Scancode 87
  SCANCODE_KP_ENTER*              = Scancode 88
  SCANCODE_KP_1*                  = Scancode 89
  SCANCODE_KP_2*                  = Scancode 90
  SCANCODE_KP_3*                  = Scancode 91
  SCANCODE_KP_4*                  = Scancode 92
  SCANCODE_KP_5*                  = Scancode 93
  SCANCODE_KP_6*                  = Scancode 94
  SCANCODE_KP_7*                  = Scancode 95
  SCANCODE_KP_8*                  = Scancode 96
  SCANCODE_KP_9*                  = Scancode 97
  SCANCODE_KP_0*                  = Scancode 98
  SCANCODE_KP_PERIOD*             = Scancode 99

  SCANCODE_NONUSBACKSLASH*        = Scancode 100
  SCANCODE_APPLICATION*           = Scancode 101
  SCANCODE_POWER*                 = Scancode 102
  SCANCODE_KP_EQUALS*             = Scancode 103
  SCANCODE_F13*                   = Scancode 104
  SCANCODE_F14*                   = Scancode 105
  SCANCODE_F15*                   = Scancode 106
  SCANCODE_F16*                   = Scancode 107
  SCANCODE_F17*                   = Scancode 108
  SCANCODE_F18*                   = Scancode 109
  SCANCODE_F19*                   = Scancode 110
  SCANCODE_F20*                   = Scancode 111
  SCANCODE_F21*                   = Scancode 112
  SCANCODE_F22*                   = Scancode 113
  SCANCODE_F23*                   = Scancode 114
  SCANCODE_F24*                   = Scancode 115
  SCANCODE_EXECUTE*               = Scancode 116
  SCANCODE_HELP*                  = Scancode 117
  SCANCODE_MENU*                  = Scancode 118
  SCANCODE_SELECT*                = Scancode 119
  SCANCODE_STOP*                  = Scancode 120
  SCANCODE_AGAIN*                 = Scancode 121   ##  Redo.
  SCANCODE_UNDO*                  = Scancode 122
  SCANCODE_CUT*                   = Scancode 123
  SCANCODE_COPY*                  = Scancode 124
  SCANCODE_PASTE*                 = Scancode 125
  SCANCODE_FIND*                  = Scancode 126
  SCANCODE_MUTE*                  = Scancode 127
  SCANCODE_VOLUMEUP*              = Scancode 128
  SCANCODE_VOLUMEDOWN*            = Scancode 129

  SCANCODE_KP_COMMA*              = Scancode 133
  SCANCODE_KP_EQUALSAS400*        = Scancode 134

  SCANCODE_INTERNATIONAL1*        = Scancode 135
  SCANCODE_INTERNATIONAL2*        = Scancode 136
  SCANCODE_INTERNATIONAL3*        = Scancode 137   ##  Yen.
  SCANCODE_INTERNATIONAL4*        = Scancode 138
  SCANCODE_INTERNATIONAL5*        = Scancode 139
  SCANCODE_INTERNATIONAL6*        = Scancode 140
  SCANCODE_INTERNATIONAL7*        = Scancode 141
  SCANCODE_INTERNATIONAL8*        = Scancode 142
  SCANCODE_INTERNATIONAL9*        = Scancode 143
  SCANCODE_LANG1*                 = Scancode 144   ##  Hangul/English toggle.
  SCANCODE_LANG2*                 = Scancode 145   ##  Hanja conversion.
  SCANCODE_LANG3*                 = Scancode 146   ##  Katakana.
  SCANCODE_LANG4*                 = Scancode 147   ##  Hiragana.
  SCANCODE_LANG5*                 = Scancode 148   ##  Zenkaku/Hankaku.
  SCANCODE_LANG6*                 = Scancode 149   ##  Reserved.
  SCANCODE_LANG7*                 = Scancode 150   ##  Reserved.
  SCANCODE_LANG8*                 = Scancode 151   ##  Reserved.
  SCANCODE_LANG9*                 = Scancode 152   ##  Reserved.

  SCANCODE_ALTERASE*              = Scancode 153   ##  Erase-Eaze.
  SCANCODE_SYSREQ*                = Scancode 154
  SCANCODE_CANCEL*                = Scancode 155
  SCANCODE_CLEAR*                 = Scancode 156
  SCANCODE_PRIOR*                 = Scancode 157
  SCANCODE_RETURN2*               = Scancode 158
  SCANCODE_SEPARATOR*             = Scancode 159
  SCANCODE_OUT*                   = Scancode 160
  SCANCODE_OPER*                  = Scancode 161
  SCANCODE_CLEARAGAIN*            = Scancode 162
  SCANCODE_CRSEL*                 = Scancode 163
  SCANCODE_EXSEL*                 = Scancode 164

  SCANCODE_KP_00*                 = Scancode 176
  SCANCODE_KP_000*                = Scancode 177
  SCANCODE_THOUSANDSSEPARATOR*    = Scancode 178
  SCANCODE_DECIMALSEPARATOR*      = Scancode 179
  SCANCODE_CURRENCYUNIT*          = Scancode 180
  SCANCODE_CURRENCYSUBUNIT*       = Scancode 181
  SCANCODE_KP_LEFTPAREN*          = Scancode 182
  SCANCODE_KP_RIGHTPAREN*         = Scancode 183
  SCANCODE_KP_LEFTBRACE*          = Scancode 184
  SCANCODE_KP_RIGHTBRACE*         = Scancode 185
  SCANCODE_KP_TAB*                = Scancode 186
  SCANCODE_KP_BACKSPACE*          = Scancode 187
  SCANCODE_KP_A*                  = Scancode 188
  SCANCODE_KP_B*                  = Scancode 189
  SCANCODE_KP_C*                  = Scancode 190
  SCANCODE_KP_D*                  = Scancode 191
  SCANCODE_KP_E*                  = Scancode 192
  SCANCODE_KP_F*                  = Scancode 193
  SCANCODE_KP_XOR*                = Scancode 194
  SCANCODE_KP_POWER*              = Scancode 195
  SCANCODE_KP_PERCENT*            = Scancode 196
  SCANCODE_KP_LESS*               = Scancode 197
  SCANCODE_KP_GREATER*            = Scancode 198
  SCANCODE_KP_AMPERSAND*          = Scancode 199
  SCANCODE_KP_DBLAMPERSAND*       = Scancode 200
  SCANCODE_KP_VERTICALBAR*        = Scancode 201
  SCANCODE_KP_DBLVERTICALBAR*     = Scancode 202
  SCANCODE_KP_COLON*              = Scancode 203
  SCANCODE_KP_HASH*               = Scancode 204
  SCANCODE_KP_SPACE*              = Scancode 205
  SCANCODE_KP_AT*                 = Scancode 206
  SCANCODE_KP_EXCLAM*             = Scancode 207
  SCANCODE_KP_MEMSTORE*           = Scancode 208
  SCANCODE_KP_MEMRECALL*          = Scancode 209
  SCANCODE_KP_MEMCLEAR*           = Scancode 210
  SCANCODE_KP_MEMADD*             = Scancode 211
  SCANCODE_KP_MEMSUBTRACT*        = Scancode 212
  SCANCODE_KP_MEMMULTIPLY*        = Scancode 213
  SCANCODE_KP_MEMDIVIDE*          = Scancode 214
  SCANCODE_KP_PLUSMINUS*          = Scancode 215
  SCANCODE_KP_CLEAR*              = Scancode 216
  SCANCODE_KP_CLEARENTRY*         = Scancode 217
  SCANCODE_KP_BINARY*             = Scancode 218
  SCANCODE_KP_OCTAL*              = Scancode 219
  SCANCODE_KP_DECIMAL*            = Scancode 220
  SCANCODE_KP_HEXADECIMAL*        = Scancode 221

  SCANCODE_LCTRL*                 = Scancode 224
  SCANCODE_LSHIFT*                = Scancode 225
  SCANCODE_LALT*                  = Scancode 226   ##  Alt, option.
  SCANCODE_LGUI*                  = Scancode 227   ##  Windows, ⌘ (apple), meta.
  SCANCODE_RCTRL*                 = Scancode 228
  SCANCODE_RSHIFT*                = Scancode 229
  SCANCODE_RALT*                  = Scancode 230   ##  Alt gr, option.
  SCANCODE_RGUI*                  = Scancode 231   ##  Windows, ⌘ (apple), meta.

  SCANCODE_MODE*                  = Scancode 257

  # Values mapped from usage page 0x0c (USB consumer page).

  SCANCODE_SLEEP*                 = Scancode 258
  SCANCODE_WAKE*                  = Scancode 259

  SCANCODE_CHANNEL_INCREMENT*     = Scancode 260
  SCANCODE_CHANNEL_DECREMENT*     = Scancode 261

  SCANCODE_MEDIA_PLAY*            = Scancode 262
  SCANCODE_MEDIA_PAUSE*           = Scancode 263
  SCANCODE_MEDIA_RECORD*          = Scancode 264
  SCANCODE_MEDIA_FAST_FORWARD*    = Scancode 265
  SCANCODE_MEDIA_REWIND*          = Scancode 266
  SCANCODE_MEDIA_NEXT_TRACK*      = Scancode 267
  SCANCODE_MEDIA_PREVIOUS_TRACK*  = Scancode 268
  SCANCODE_MEDIA_STOP*            = Scancode 269
  SCANCODE_MEDIA_EJECT*           = Scancode 270
  SCANCODE_MEDIA_PLAY_PAUSE*      = Scancode 271
  SCANCODE_MEDIA_SELECT*          = Scancode 272

  SCANCODE_AC_NEW*                = Scancode 273
  SCANCODE_AC_OPEN*               = Scancode 274
  SCANCODE_AC_CLOSE*              = Scancode 275
  SCANCODE_AC_EXIT*               = Scancode 276
  SCANCODE_AC_SAVE*               = Scancode 277
  SCANCODE_AC_PRINT*              = Scancode 278
  SCANCODE_AC_PROPERTIES*         = Scancode 279

  SCANCODE_AC_SEARCH*             = Scancode 280
  SCANCODE_AC_HOME*               = Scancode 281
  SCANCODE_AC_BACK*               = Scancode 282
  SCANCODE_AC_FORWARD*            = Scancode 283
  SCANCODE_AC_STOP*               = Scancode 284
  SCANCODE_AC_REFRESH*            = Scancode 285
  SCANCODE_AC_BOOKMARKS*          = Scancode 286

  # Mobile keys.
  SCANCODE_SOFTLEFT*              = Scancode 287
  SCANCODE_SOFTRIGHT*             = Scancode 288
  SCANCODE_CALL*                  = Scancode 289
  SCANCODE_ENDCALL*               = Scancode 290

  SCANCODE_RESERVED*              = Scancode 400

const
  NUM_SCANCODES*  = 512

# vim: set sts=2 et sw=2:
