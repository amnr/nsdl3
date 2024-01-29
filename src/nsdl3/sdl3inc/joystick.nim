##  Joystick event definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  Joystick* = ptr object
    ##  Joystick.

  JoystickGUID* {.final, pure.} = object
    ##  Joystick GUID.
    data*:  array[16, byte]

  JoystickID* = distinct uint32
    ##  Joystick unique ID.
    ##
    ##  The ID starts at 1. Invalid ID has value 0.

func `==`*(a: JoystickID, b: uint32): bool {.borrow.}

type
  JoystickType* {.size: cint.sizeof.} = enum
    ##  Joystick type.
    JOYSTICK_TYPE_UNKNOWN
    JOYSTICK_TYPE_GAMEPAD
    JOYSTICK_TYPE_WHEEL
    JOYSTICK_TYPE_ARCADE_STICK
    JOYSTICK_TYPE_FLIGHT_STICK
    JOYSTICK_TYPE_DANCE_PAD
    JOYSTICK_TYPE_GUITAR
    JOYSTICK_TYPE_DRUM_KIT
    JOYSTICK_TYPE_ARCADE_PAD
    JOYSTICK_TYPE_THROTTLE

  JoystickPowerLevel* {.size: cint.sizeof.} = enum
    ##  Joystick power level.
    JOYSTICK_POWER_UNKNOWN  = -1
    JOYSTICK_POWER_EMPTY    ##  <= 5%.
    JOYSTICK_POWER_LOW      ##  <= 20%.
    JOYSTICK_POWER_MEDIUM   ##  <= 70%.
    JOYSTICK_POWER_FULL     ##  <= 100%.
    JOYSTICK_POWER_WIRED
    JOYSTICK_POWER_MAX

const
  JOYSTICK_AXIS_MAX*  = 32767
  JOYSTICK_AXIS_MIN*  = -32768

  IPHONE_MAX_GFORCE*  = cfloat 5.0

type
  VirtualJoystickDesc* {.final, pure.} = object
    ##  Extended virtual joystick description.
    version*      : uint16    ##  `VIRTUAL_JOYSTICK_DESC_VERSION`.
    `type`*       : uint16    ##  `JoystickType`.
    naxes*        : uint16    ##  The number of axes.
    nbuttons*     : uint16    ##  The number of buttons.
    nhats*        : uint16    ##  The number of hats.
    vendor_id*    : uint16    ##  USB vendor ID.
    product_id*   : uint16    ##  USB product ID.
    padding       : uint16
    button_mask*  : uint32    ##  Valid buttons mask.
    axis_mask*    : uint32    ##  Valid axes mask.
    name*         : cstring   ##  Joystick name.

    userdata        : pointer     ##  User data pointer.
    Update          : proc (userdata: pointer) {.cdecl, gcsafe, raises: [].}
    SetPlayerIndex  : proc (userdata: pointer, player_index: cint) {.cdecl, gcsafe, raises: [].}
    Rumble          : proc (userdata: pointer, low_frequency_rumble, high_frequency_rumble: uint16): cint {.cdecl, gcsafe, raises: [].}
    RumbleTriggers  : proc (userdata: pointer, left_rumble, right_rumble: uint16): cint {.cdecl, gcsafe, raises: [].}
    SetLED          : proc (userdata: pointer, red, green, blue: byte): cint {.cdecl, gcsafe, raises: [].}
    SendEffect      : proc (userdata: pointer, data: pointer, size: cint): cint {.cdecl, gcsafe, raises: [].}

const
  VIRTUAL_JOYSTICK_DESC_VERSION*  = 1

const
  # XXX: make distinct type.
  PROP_JOYSTICK_CAP_MONO_LED_BOOLEAN*       = cstring"SDL.joystick.cap.mono_led"
  PROP_JOYSTICK_CAP_RGB_LED_BOOLEAN*        = cstring"SDL.joystick.cap.rgb_led"
  PROP_JOYSTICK_CAP_PLAYER_LED_BOOLEAN*     = cstring"SDL.joystick.cap.player_led"
  PROP_JOYSTICK_CAP_RUMBLE_BOOLEAN*         = cstring"SDL.joystick.cap.rumble"
  PROP_JOYSTICK_CAP_TRIGGER_RUMBLE_BOOLEAN* = cstring"SDL.joystick.cap.trigger_rumble"

type
  Hat* = distinct byte
    ##  Hat positions.

func `==`*(a, b: Hat): bool {.borrow.}
func `and`*(a, b: Hat): Hat {.borrow.}
func `or`(a, b: Hat): Hat {.borrow.}

const
  HAT_CENTERED*   = Hat 0x00
  HAT_UP*         = Hat 0x01
  HAT_RIGHT*      = Hat 0x02
  HAT_DOWN*       = Hat 0x04
  HAT_LEFT*       = Hat 0x08
  HAT_RIGHTUP*    = HAT_RIGHT or HAT_UP
  HAT_RIGHTDOWN*  = HAT_RIGHT or HAT_DOWN
  HAT_LEFTUP*     = HAT_LEFT or HAT_UP
  HAT_LEFTDOWN*   = HAT_LEFT or HAT_DOWN

# vim: set sts=2 et sw=2:
