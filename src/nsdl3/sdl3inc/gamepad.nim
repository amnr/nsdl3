##  Gamepad event definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  Gamepad* = ptr object
    ##  Gamepad.

  GamepadType* {.size: cint.sizeof.} = enum
    ##  Gamepad type.
    GAMEPAD_TYPE_UNKNOWN  = 0
    GAMEPAD_TYPE_STANDARD
    GAMEPAD_TYPE_XBOX360
    GAMEPAD_TYPE_XBOXONE
    GAMEPAD_TYPE_PS3
    GAMEPAD_TYPE_PS4
    GAMEPAD_TYPE_PS5
    GAMEPAD_TYPE_NINTENDO_SWITCH_PRO
    GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_LEFT
    GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_RIGHT
    GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_PAIR

const
  GAMEPAD_TYPE_MAX* = GamepadType.high.int + 1

type
  GamepadButton* {.size: cint.sizeof.} = enum   # XXX: size.
    ##  The list of buttons available on a gamepad.
    GAMEPAD_BUTTON_INVALID = -1
    GAMEPAD_BUTTON_SOUTH
    GAMEPAD_BUTTON_EAST
    GAMEPAD_BUTTON_WEST
    GAMEPAD_BUTTON_NORTH
    GAMEPAD_BUTTON_BACK
    GAMEPAD_BUTTON_GUIDE
    GAMEPAD_BUTTON_START
    GAMEPAD_BUTTON_LEFT_STICK
    GAMEPAD_BUTTON_RIGHT_STICK
    GAMEPAD_BUTTON_LEFT_SHOULDER
    GAMEPAD_BUTTON_RIGHT_SHOULDER
    GAMEPAD_BUTTON_DPAD_UP
    GAMEPAD_BUTTON_DPAD_DOWN
    GAMEPAD_BUTTON_DPAD_LEFT
    GAMEPAD_BUTTON_DPAD_RIGHT
    GAMEPAD_BUTTON_MISC1
    GAMEPAD_BUTTON_RIGHT_PADDLE1
    GAMEPAD_BUTTON_LEFT_PADDLE1
    GAMEPAD_BUTTON_RIGHT_PADDLE2
    GAMEPAD_BUTTON_LEFT_PADDLE2
    GAMEPAD_BUTTON_TOUCHPAD

const
  GAMEPAD_BUTTON_MAX* = GamepadButton.high.int + 1

type
  GamepadButtonLabel* {.size: cint.sizeof.} = enum
    ##  The set of gamepad button labels.
    GAMEPAD_BUTTON_LABEL_UNKNOWN
    GAMEPAD_BUTTON_LABEL_A
    GAMEPAD_BUTTON_LABEL_B
    GAMEPAD_BUTTON_LABEL_X
    GAMEPAD_BUTTON_LABEL_Y
    GAMEPAD_BUTTON_LABEL_CROSS
    GAMEPAD_BUTTON_LABEL_CIRCLE
    GAMEPAD_BUTTON_LABEL_SQUARE
    GAMEPAD_BUTTON_LABEL_TRIANGLE

type
  GamepadAxis* {.size: cint.sizeof.} = enum
    ##  The list of axes available on a gamepad.
    GAMEPAD_AXIS_INVALID = -1
    GAMEPAD_AXIS_LEFTX
    GAMEPAD_AXIS_LEFTY
    GAMEPAD_AXIS_RIGHTX
    GAMEPAD_AXIS_RIGHTY
    GAMEPAD_AXIS_LEFT_TRIGGER
    GAMEPAD_AXIS_RIGHT_TRIGGER

const
  GAMEPAD_AXIS_MAX* = GamepadAxis.high.int + 1

type
  GamepadBindingType* {.size: cint.sizeof.} = enum
    GAMEPAD_BINDTYPE_NONE = 0
    GAMEPAD_BINDTYPE_BUTTON
    GAMEPAD_BINDTYPE_AXIS
    GAMEPAD_BINDTYPE_HAT

type
  GamepadBinding* {.final, pure.} = object
    ##  Gamepad binding.
    input_type*   : GamepadBindingType
    input*        : GamepadBindingInputUnion
    output_type*  : GamepadBindingType
    output*       : GamepadBindingOutputUnion

  GamepadBindingInputUnion* {.final, pure, union.} = object
    button*   : cint
    axis*     : GamepadBindingInputUnionAxis
    hat*      : GamepadBindingInputUnionHat

  GamepadBindingInputUnionAxis* {.final, pure.} = object
    axis*     : cint
    axis_min* : cint
    axis_max* : cint

  GamepadBindingInputUnionHat* {.final, pure.} = object
    hat*      : cint
    hat_mask* : cint

  GamepadBindingOutputUnion* {.final, pure, union.} = object
    button*   : GamepadButton
    axis*     : GamepadBindingOutputUnionAxis

  GamepadBindingOutputUnionAxis* {.final, pure.} = object
    axis*     : GamepadAxis
    axis_min* : cint
    axis_max* : cint

# vim: set sts=2 et sw=2:
