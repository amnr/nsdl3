##  Event definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from sdl3audio import AudioDeviceID
from sdl3camera import CameraDeviceID
from sdl3init import SdlBool
from sdl3joystick import Hat, JoystickID
from sdl3keyboard import KeyboardID
from sdl3keycode import Keycode, Keymod
from sdl3mouse import MouseButtonFlags, MouseID, MouseWheelDirection
from sdl3pen import PenAxis, PenID, PenInputFlags, PEN_NUM_AXES
from sdl3power import PowerState
from sdl3scancode import Scancode
from sdl3sensor import SensorID
from sdl3touch import FingerID, TouchID
from sdl3video import DisplayID, WindowID

# General keyboard/mouse state definitions.
const
  RELEASED* = 0
  PRESSED*  = 1

type
  EventType* {.pure, size: uint32.sizeof.} = enum
    ##  Event types.
    EVENT_FIRST                 = 0

    # Application events.
    EVENT_QUIT                  = 0x100

    # iOS event types.
    EVENT_TERMINATING
    EVENT_LOW_MEMORY
    EVENT_WILL_ENTER_BACKGROUND
    EVENT_DID_ENTER_BACKGROUND
    EVENT_WILL_ENTER_FOREGROUND
    EVENT_DID_ENTER_FOREGROUND
    EVENT_LOCALE_CHANGED
    EVENT_SYSTEM_THEME_CHANGED

    # Display events.
    EVENT_DISPLAY_ORIENTATION   = 0x151
    EVENT_DISPLAY_ADDED
    EVENT_DISPLAY_REMOVED
    EVENT_DISPLAY_MOVED
    EVENT_DISPLAY_DESKTOP_MODE_CHANGED
    EVENT_DISPLAY_CURRENT_MODE_CHANGED
    EVENT_DISPLAY_CONTENT_SCALE_CHANGED

    # Window events.
    EVENT_WINDOW_SHOWN          = 0x202
    EVENT_WINDOW_HIDDEN
    EVENT_WINDOW_EXPOSED
    EVENT_WINDOW_MOVED
    EVENT_WINDOW_RESIZED
    EVENT_WINDOW_PIXEL_SIZE_CHANGED
    EVENT_WINDOW_METAL_VIEW_RESIZED
    EVENT_WINDOW_MINIMIZED
    EVENT_WINDOW_MAXIMIZED
    EVENT_WINDOW_RESTORED
    EVENT_WINDOW_MOUSE_ENTER
    EVENT_WINDOW_MOUSE_LEAVE
    EVENT_WINDOW_FOCUS_GAINED
    EVENT_WINDOW_FOCUS_LOST
    EVENT_WINDOW_CLOSE_REQUESTED
    EVENT_WINDOW_HIT_TEST
    EVENT_WINDOW_ICCPROF_CHANGED
    EVENT_WINDOW_DISPLAY_CHANGED
    EVENT_WINDOW_DISPLAY_SCALE_CHANGED
    EVENT_WINDOW_SAFE_AREA_CHANGED
    EVENT_WINDOW_OCCLUDED
    EVENT_WINDOW_ENTER_FULLSCREEN
    EVENT_WINDOW_LEAVE_FULLSCREEN
    EVENT_WINDOW_DESTROYED
    EVENT_WINDOW_HDR_STATE_CHANGED

    # Keyboard events.
    EVENT_KEY_DOWN              = 0x300
    EVENT_KEY_UP
    EVENT_TEXT_EDITING
    EVENT_TEXT_INPUT
    EVENT_KEYMAP_CHANGED
    EVENT_KEYBOARD_ADDED
    EVENT_KEYBOARD_REMOVED
    EVENT_TEXT_EDITING_CANDIDATES

    # Mouse events.
    EVENT_MOUSE_MOTION          = 0x400
    EVENT_MOUSE_BUTTON_DOWN
    EVENT_MOUSE_BUTTON_UP
    EVENT_MOUSE_WHEEL
    EVENT_MOUSE_ADDED
    EVENT_MOUSE_REMOVED

    # Joystick events.
    EVENT_JOYSTICK_AXIS_MOTION  = 0x600
    EVENT_JOYSTICK_BALL_MOTION
    EVENT_JOYSTICK_HAT_MOTION
    EVENT_JOYSTICK_BUTTON_DOWN
    EVENT_JOYSTICK_BUTTON_UP
    EVENT_JOYSTICK_ADDED
    EVENT_JOYSTICK_REMOVED
    EVENT_JOYSTICK_BATTERY_UPDATED
    EVENT_JOYSTICK_UPDATE_COMPLETE

    # Gamepad events.
    EVENT_GAMEPAD_AXIS_MOTION   = 0x650
    EVENT_GAMEPAD_BUTTON_DOWN
    EVENT_GAMEPAD_BUTTON_UP
    EVENT_GAMEPAD_ADDED
    EVENT_GAMEPAD_REMOVED
    EVENT_GAMEPAD_REMAPPED
    EVENT_GAMEPAD_TOUCHPAD_DOWN
    EVENT_GAMEPAD_TOUCHPAD_MOTION
    EVENT_GAMEPAD_TOUCHPAD_UP
    EVENT_GAMEPAD_SENSOR_UPDATE
    EVENT_GAMEPAD_UPDATE_COMPLETE
    EVENT_GAMEPAD_STEAM_HANDLE_UPDATED

    # Touch events.
    EVENT_FINGER_DOWN           = 0x700
    EVENT_FINGER_UP,
    EVENT_FINGER_MOTION

    # Clipboard events.
    EVENT_CLIPBOARD_UPDATE      = 0x900

    # Drag and drop events.
    EVENT_DROP_FILE             = 0x1000
    EVENT_DROP_TEXT
    EVENT_DROP_BEGIN
    EVENT_DROP_COMPLETE
    EVENT_DROP_POSITION

    # Audio hotplug events.
    EVENT_AUDIO_DEVICE_ADDED    = 0x1100
    EVENT_AUDIO_DEVICE_REMOVED
    EVENT_AUDIO_DEVICE_FORMAT_CHANGED

    # Sensor events.
    EVENT_SENSOR_UPDATE         = 0x1200

    # Pressure-sensitive pen events.
    EVENT_PEN_PROXIMITY_IN      = 0x1300
    EVENT_PEN_PROXIMITY_OUT
    EVENT_PEN_DOWN
    EVENT_PEN_UP
    EVENT_PEN_BUTTON_DOWN
    EVENT_PEN_BUTTON_UP
    EVENT_PEN_MOTION
    EVENT_PEN_AXIS

    # Camera hotplug events.
    EVENT_CAMERA_DEVICE_ADDED   = 0x1400
    EVENT_CAMERA_DEVICE_REMOVED
    EVENT_CAMERA_DEVICE_APPROVED
    EVENT_CAMERA_DEVICE_DENIED

    # Render events.
    EVENT_RENDER_TARGETS_RESET  = 0x2000
    EVENT_RENDER_DEVICE_RESET

    # Internal events.
    EVENT_POLL_SENTINEL         = 0x7f00

    # User defined events. To be registered with `register_events()`.
    # Nim exclusive defines. 10 custom user events ought to be enough for anyone.
    EVENT_USER                  = 0x8000
    EVENT_USER1                 = 0x8001
    EVENT_USER2                 = 0x8002
    EVENT_USER3                 = 0x8003
    EVENT_USER4                 = 0x8004
    EVENT_USER5                 = 0x8005
    EVENT_USER6                 = 0x8006
    EVENT_USER7                 = 0x8007
    EVENT_USER8                 = 0x8008

    EVENT_LAST                  = 0xffff

const
  EVENT_DISPLAY_FIRST*  = EVENT_DISPLAY_ORIENTATION
  EVENT_DISPLAY_LAST*   = EVENT_DISPLAY_CONTENT_SCALE_CHANGED

  EVENT_WINDOW_FIRST*   = EVENT_WINDOW_SHOWN
  EVENT_WINDOW_LAST*    = EVENT_WINDOW_HDR_STATE_CHANGED

type
  CommonEvent* {.final, pure.} = object
    ##  Common event.
    typ*          : EventType
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).

  DisplayEvent* {.final, pure.} = object
    ##  Display state change event.
    typ*          : EventType   ##  `EVENT_DISPLAYEVENT_*`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    display_id*   : DisplayID   ##  Associated display.
    data1*        : int32       ##  Event dependent data.
    data2*        : int32       ##  Event dependent data.

  WindowEvent* {.final, pure.} = object
    ##  Window state change event.
    typ*          : EventType   ##  `EVENT_WINDOW_*`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  Associated window.
    data1*        : int32       ##  Event dependent data.
    data2*        : int32       ##  Event dependent data.

  KeyboardDeviceEvent* {.final, pure.} = object
    ##  Keyboard device event.
    typ*          : EventType   ##  `EVENT_KEYBOARD_ADDED` or `EVENT_KEYBOARD_REMOVED`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : KeyboardID  ##  Keyboard ID.

  KeyboardEvent* {.final, pure.} = object
    ##  Keyboard button event.
    typ*          : EventType   ##  `EVENT_KEY_DOWN` or `EVENT_KEY_UP`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  Window with keyboard focus (if any).
    which*        : KeyboardID  ##  Keyboard ID.
    scancode*     : Scancode
    key*          : Keycode
    `mod`*        : Keymod
    raw*          : uint16
    state*        : byte        ##  `PRESSED` or `RELEASED`.
    repeat*       : byte        ##  Non-zero if key repeat.

  TextEditingEvent* {.final, pure.} = object
    ##  Keyboard text editing event.
    ##
    ##  .. note:: This event should be cleaned up with `cleanup_event()` after processing.
    typ*          : EventType   ##  `EVENT_TEXT_EDITING`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  Window with keyboard focus (if any).
    text*         : cstring     ##  The editing text.
    start*        : int32       ##  Selected editing text start cursor.
    length*       : int32       ##  Selected editing text length.

  TextEditingCandidatesEvent* {.final, pure.} = object
    ##  Keyboard IME candidates input event.
    typ*                : EventType     ##  `EVENT_TEXT_INPUT`.
    reserved            : uint32
    timestamp*          : uint64        ##  Timestamp (ns).
    window_id*          : WindowID      ##  Window with keyboard focus (if any).
    candidates*         : cstringArray  ##  The list of candidates or `nil`.
    num_candidates*     : int32
    selected_candidate* : int32
    horizontal*         : SdlBool

  TextInputEvent* {.final, pure.} = object
    ##  Keyboard text input event.
    ##
    ##  .. note:: This event should be cleaned up with `cleanup_event()` after processing.
    typ*          : EventType   ##  `EVENT_TEXT_INPUT`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  Window with keyboard focus (if any).
    text*         : cstring     ##  The input text.

  MouseDeviceEvent* {.final, pure.} = object
    ##  Mouse device event.
    typ*          : EventType   ##  `EVENT_MOUSE_ADDED` or `EVENT_MOUSE_REMOVED`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : MouseID     ##  Mouse instance ID.

  MouseMotionEvent* {.final, pure.} = object
    ##  Mouse motion event.
    typ*          : EventType   ##  `EVENT_MOUSE_MOTION`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  Window with mouse focus (if any).
    which*        : MouseID     ##  Mouse instance ID or `TOUCH_MOUSEID`.
    state*        : MouseButtonFlags      ##  Button state.
    x*            : cfloat      ##  X position.
    y*            : cfloat      ##  Y position.
    xrel*         : cfloat      ##  Relative motion (X direction).
    yrel*         : cfloat      ##  Relative motion (Y direction).

  MouseButtonEvent* {.final, pure.} = object
    ##  Mouse button event.
    typ*          : EventType   ##  `EVENT_MOUSE_BUTTON_DOWN` or `EVENT_MOUSE_BUTTON_UP`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  Window with mouse focus (if any).
    which*        : MouseID     ##  Mouse instance ID or `SDL_TOUCH_MOUSEID`.
    button*       : byte        ##  Mouse button index.
    state*        : byte        ##  `PRESSED` or `RELEASED`.
    clicks*       : byte        ##  Single click (1), double click (2), etc.
    padding       : byte
    x*            : cfloat      ##  X position.
    y*            : cfloat      ##  Y position.

  MouseWheelEvent* {.final, pure.} = object
    ##  Mouse wheel event.
    typ*          : EventType   ##  `EVENT_MOUSE_WHEEL`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  Window with mouse focus (if any).
    which*        : MouseID     ##  Mouse instance ID or `SDL_TOUCH_MOUSEID`.
    x*            : cfloat      ##  Horizontal scroll amount. Positive to the
                                ##  right. Negative to the left.
    y*            : cfloat      ##  Vertical scroll amount. Positive to the
                                ##  user, negative toward the user.
    direction*    : MouseWheelDirection   ##  Direction (`MOUSEWHEEL_*`).
    mouse_x*      : cfloat      ##  X position.
    mouse_y*      : cfloat      ##  Y position.

  JoyAxisEvent* {.final, pure.} = object
    ##  Joystick axis motion event.
    typ*          : EventType   ##  `EVENT_JOYSTICK_AXIS_MOTION`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : JoystickID  ##  Joystick ID.
    axis*         : byte        ##  Joystick axis index.
    padding1      : byte
    padding2      : byte
    padding3      : byte
    value*        : int16       ##  Axis value (range: -32768 to 32767).
    padding4      : uint16

  JoyBallEvent* {.final, pure.} = object
    ##  Joystick trackball motion event.
    typ*          : EventType   ##  `EVENT_JOYBALLMOTION`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : JoystickID  ##  Joystick ID.
    ball*         : byte        ##  Joystick trackball index.
    padding1      : byte
    padding2      : byte
    padding3      : byte
    xrel*         : int16       ##  Relative motion (X direction).
    yrel*         : int16       ##  Relative motion (Y direction).

  JoyHatEvent* {.final, pure.} = object
    ##  Joystick hat position change event.
    typ*          : EventType   ##  `EVENT_JOYSTICK_HAT_MOTION`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : JoystickID  ##  Joystick ID.
    hat*          : Hat         ##  Joystick hat index.
    value*        : byte        ##  Hat position.
    padding1      : byte
    padding2      : byte

  JoyButtonEvent* {.final, pure.} = object
    ##  Joystick button event.
    typ*          : EventType   ##  `EVENT_JOYSTICK_BUTTON_DOWN` or `EVENT_JOYSTICK_BUTTON_UP`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : JoystickID  ##  Joystick ID.
    button*       : byte        ##  Joystick button index.
    state*        : byte        ##  `PRESSED` or `RELEASED`.
    padding1      : byte
    padding2      : byte

  JoyDeviceEvent* {.final, pure.} = object
    ##  Joystick device event.
    typ*          : EventType   ##  `EVENT_JOYSTICK_ADDED`, `EVENT_JOYSTICK_REMOVED` or `EVENT_JOYSTICK_UPDATE_COMPLETE`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : JoystickID  ##  Joystick ID.

  JoyBatteryEvent* {.final, pure.} = object
    ##  Joystick battery event.
    typ*          : EventType   ##  `EVENT_JOYSTICK_BATTERY_UPDATED`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : JoystickID  ##  Joystick ID.
    state*        : PowerState  ##  Joystick battery state.
    percent*      : cint        ##  Joystick battery percent charge remaining.

  GamepadAxisEvent* {.final, pure.} = object
    ##  Gamepad axis motion event.
    typ*          : EventType   ##  `EVENT_GAMEPAD_AXIS_MOTION`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : JoystickID  ##  Joystick ID.
    axis*         : byte        ##  Controller axis (`GameControllerAxis`).
    padding1      : byte
    padding2      : byte
    padding3      : byte
    value*        : int16       ##  Axis value (range: -32768 to 32767).
    padding4      : uint16

  GamepadButtonEvent* {.final, pure.} = object
    ##  Gamepad button event.
    typ*          : EventType   ##  `EVENT_GAMEPAD_BUTTON_DOWN` or `EVENT_GAMEPAD_BUTTON_UP`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : JoystickID  ##  Joystick ID.
    button*       : byte        ##  Joystick button (`GameControllerButton`).
    state*        : byte        ##  `PRESSED` or `RELEASED`.
    padding1      : byte
    padding2      : byte

  GamepadDeviceEvent* {.final, pure.} = object
    ##  Gamepad device event.
    typ*          : EventType   ##  `EVENT_GAMEPAD_ADDED`,
                                ##  `EVENT_GAMEPAD_REMOVED`
                                ##  `EVENT_GAMEPAD_REMAPPED`,
                                ##  `EVENT_GAMEPAD_UPDATE_COMPLETE`
                                ##  or `EVENT_GAMEPAD_STEAM_HANDLE_UPDATED`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : JoystickID  ##  Joystick instance ID.

  GamepadTouchpadEvent* {.final, pure.} = object
    ##  Gamepad touchpad event.
    typ*          : EventType   ##  `EVENT_GAMEPAD_TOUCHPAD_DOWN`,
                                ##  `EVENT_GAMEPAD_TOUCHPAD_MOTION`
                                ##  or `EVENT_GAMEPAD_TOUCHPAD_UP`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : JoystickID  ##  Joystick ID.
    touchpad*     : int32       ##  Touchpad index.
    finger*       : int32       ##  Finger index.
    x*            : cfloat      ##  Normalized, range 0 - 1; 0 is left.
    y*            : cfloat      ##  Normalized, range 0 - 1; 0 is top.
    pressure*     : cfloat      ##  Normalized, range 0 - 1.

  GamepadSensorEvent* {.final, pure.} = object
    ##  Gamepad sensor event.
    typ*          : EventType   ##  `EVENT_GAMEPAD_SENSOR_UPDATE`.
    reserved      : uint32
    timestamp*    : uint64      ##  In ms, populated using GetTicks().
    which*        : JoystickID  ##  Joystick ID.
    sensor*       : int32       ##  Sensor type (`SensorType`).
    data*         : array[3, cfloat]  ##  Sensor values (up to 3).
    sensor_timestamp* : uint64

  AudioDeviceEvent* {.final, pure.} = object
    ##  Audio device event.
    typ*          : EventType       ##  `EVENT_AUDIO_DEVICE_ADDED`, `EVENT_AUDIO_DEVICE_REMOVED` or `EVENT_AUDIO_DEVICE_FORMAT_CHANGED`.
    reserved      : uint32
    timestamp*    : uint64          ##  Timestamp (ns).
    which*        : AudioDeviceID   ##  Audio device index for the `ADDED` event.
                                    ##  (valid until next `get_num_audio_devices()
                                    ##  call) or `AudioDeviceID` for the `REMOVED` event.
    recording*    : byte            ##  Playback device (0) or recording device (non-zero).
    padding1      : byte
    padding2      : byte
    padding3      : byte

  CameraDeviceEvent* {.final, pure.} = object
    ##  Camera device event.
    typ*          : EventType       ##  `EVENT_CAMERA_DEVICE_ADDED`, `EVENT_CAMERA_DEVICE_REMOVED`, `EVENT_CAMERA_DEVICE_APPROVED` or `EVENT_CAMERA_DEVICE_DENIED`.
    reserved      : uint32
    timestamp*    : uint64          ##  Timestamp (ns).
    which*        : CameraDeviceID  ##  Camera device index for the `ADDED`, `REMOVED` or `CHANGING` event.

  TouchFingerEvent* {.final, pure.} = object
    ##  Touch finger event.
    typ*          : EventType   ##  `EVENT_FINGER_MOTION`, `EVENT_FINGER_DOWN` or `EVENT_FINGER_UP`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    touch_id*     : TouchID     ##  Touch ID.
    finger_id*    : FingerID
    x*            : cfloat      ##  Normalized, range 0 - 1.
    y*            : cfloat      ##  Normalized, range 0 - 1.
    dx*           : cfloat      ##  Normalized, range -1 - 1.
    dy*           : cfloat      ##  Normalized, range -1 - 1.
    pressure*     : cfloat      ##  Normalized, range 0 - 1.
    window_id*    : WindowID    ##  Window underneath the finger (if any).

  PenProximityEvent* {.final, pure.} = object
    ##  Pressure-sensitive pen proximity event.
    typ*          : EventType   ##  `EVENT_PEN_PROXIMITY_IN` or ``SDL_EVENT_PROXIMITY_OUT`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  The window with mouse focus, if any.
    which*        : PenID       ##  The pen instance id.

  PenMotionEvent* {.final, pure.} = object
    ##  Pressure-sensitive pen motion event.
    typ*          : EventType   ##  `EVENT_PEN_MOTION`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  The window with pen focus, if any.
    which*        : PenID       ##  The pen instance id.
    pen_state*    : PenInputFlags   ##  Complete pen input state at time of event.
    x*            : cfloat      ##  X position.
    y*            : cfloat      ##  Y position.

  PenTouchEvent* {.final, pure.} = object
    ##  Pressure-sensitive pen touched event.
    typ*          : EventType   ##  `EVENT_PEN_DOWN` or `EVENT_PEN_UP`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  The window with pen focus, if any.
    which*        : PenID       ##  The pen instance id.
    pen_state*    : PenInputFlags   ##  Complete pen input state at time of event.
    x*            : cfloat      ##  X position.
    y*            : cfloat      ##  Y position.
    eraser*       : byte        ##  Non-zero if eraser end is used.
    state*        : byte        ##  `PRESSED` or `RELEASED`.

  PenButtonEvent* {.final, pure.} = object
    ##  Pressure-sensitive pen button event.
    typ*          : EventType   ##  `EVENT_PEN_BUTTON_DOWN` or `EVENT_PEN_BUTTON_UP`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  The window with pen focus, if any.
    which*        : PenID       ##  The pen instance id.
    pen_state*    : PenInputFlags   ##  Complete pen input state at time of event.
    x*            : cfloat      ##  X position.
    y*            : cfloat      ##  Y position.
    button*       : byte        ##  The pen button index (first button is 1).
    state*        : byte        ##  `PRESSED` or `RELEASED`.

  PenAxisEvent* {.final, pure.} = object
    ##  Pressure-sensitive pen pressure / angle event.
    typ*          : EventType   ##  `EVENT_PEN_AXIS`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  The window with pen focus, if any.
    which*        : PenID       ##  The pen instance id.
    pen_state*    : PenInputFlags   ##  Complete pen input state at time of event.
    x*            : cfloat      ##  X position.
    y*            : cfloat      ##  Y position.
    axis*         : PenAxis     ##  Axis that has changed.
    value*        : cfloat      ##  New value of axis.

  DropEvent* {.final, pure.} = object
    ##  An event used to drop text or request a file open by the system.
    ##
    ##  .. note:: This event should be cleaned up with `cleanup_event()` after processing.
    typ*          : EventType   ##  `EVENT_DROP_BEGIN`, `EVENT_DROP_FILE`,
                                ##  `EVENT_DROP_TEXT` or `EVENT_DROP_COMPLETE`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  Window ID file was dropped on (if any).
    x*            : cfloat      ##  X position.
    y*            : cfloat      ##  Y position.
    source*       : cstring     ##  The source app that sent this drop event, or `nil` if that isn't available.
    dest*         : cstring     ##  The text for `EVENT_DROP_TEXT` and the file name for `EVENT_DROP_FILE`, `nil` for other events.

  ClipboardEvent* {.final, pure.} = object
    ##  Clipboard contents have changed.
    typ*          : EventType   ##  `EVENT_CLIPBOARD_UPDATE`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).

  SensorEvent* {.final, pure.} = object
    ##  Sensor event.
    typ*          : EventType   ##  `EVENT_SENSOR_UPDATE`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    which*        : SensorID    ##  Sensor ID.
    data*         : array[6, cfloat]  ##  Sensor values (up to 6).
                                ##  Query additional values with
                                ##  `sensor_get_data()`.
    sensor_timestamp* : uint64

  QuitEvent* {.final, pure.} = object
    ##  The "quit requested" event.
    typ*          : EventType   ##  `EVENT_QUIT`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).

  UserEvent* {.final, pure.} = object
    ##  A user-defined event type.
    typ*          : EventType   ##  `EVENT_USER` through `EVENT_USER8`.
    reserved      : uint32
    timestamp*    : uint64      ##  Timestamp (ns).
    window_id*    : WindowID    ##  Associated window (if any).
    code*         : int32       ##  User defined code.
    data1*        : pointer     ##  User defined data pointer.
    data2*        : pointer     ##  User defined data pointer.

type
  Event* {.bycopy, final, pure, union.} = object
    ##  Event.
    typ*          : EventType                 ##  Event type.
    common*       : CommonEvent               ##  Common event.
    display*      : DisplayEvent              ##  Display event.
    window*       : WindowEvent               ##  Window event.
    kdevice*      : KeyboardDeviceEvent       ##  Keyboard device change event.
    key*          : KeyboardEvent             ##  Keyboard event.
    edit*         : TextEditingEvent          ##  Text editing event.
    edit_candidates*  : TextEditingCandidatesEvent  ##  Text editing candidates event.
    text*         : TextInputEvent            ##  Text input event.
    mdevice*      : MouseDeviceEvent          ##  Mouse device change event.
    motion*       : MouseMotionEvent          ##  Mouse motion event.
    button*       : MouseButtonEvent          ##  Mouse button event.
    wheel*        : MouseWheelEvent           ##  Mouse wheel event.
    jdevice*      : JoyDeviceEvent            ##  Joystick device change event.
    jaxis*        : JoyAxisEvent              ##  Joystick axis event.
    jball*        : JoyBallEvent              ##  Joystick ball event.
    jhat*         : JoyHatEvent               ##  Joystick hat event.
    jbutton*      : JoyButtonEvent            ##  Joystick button event.
    jbattery*     : JoyBatteryEvent           ##  Joystick battery event.
    gdevice*      : GamepadDeviceEvent        ##  Gamepad device event.
    gaxis*        : GamepadAxisEvent          ##  Gamepad axis event.
    gbutton*      : GamepadButtonEvent        ##  Gamepad button event.
    gtouchpad*    : GamepadTouchpadEvent      ##  Gamepad touchpad event.
    gsensor*      : GamepadSensorEvent        ##  Gamepad sensor event.
    adevice*      : AudioDeviceEvent          ##  Audio device event.
    cdevice*      : CameraDeviceEvent         ##  Camera device event.
    sensor*       : SensorEvent               ##  Sensor event.
    quit*         : QuitEvent                 ##  Quit request event.
    user*         : UserEvent                 ##  Custom event.
    tfinger*      : TouchFingerEvent          ##  Touch finger event.
    pproximity*   : PenProximityEvent         ##  Pen proximity event.
    ptouch*       : PenTouchEvent             ##  Pen tip touching event.
    pmotion*      : PenMotionEvent            ##  Pen motion event.
    pbutton*      : PenButtonEvent            ##  Pen button event.
    paxis*        : PenAxisEvent              ##  Pen axis event.
    drop*         : DropEvent                 ##  Drag and drop event.
    clipboard*    : ClipboardEvent            ##  Clipboard change event.
    padding       : array[128, byte]    # See `SDL_events.h` for details.

# Let's make sure we haven't broken binary compatibility.
when Event.sizeof != Event.padding.sizeof:
  {.error: "invalid Event size".}

type
  EventAction* {.size: cint.sizeof.} = enum
    ##  Event action.
    ADDEVENT
    PEEKEVENT
    GETEVENT

type
  EventFilter* = proc (userdata : pointer,
                       event    : ptr Event): SdlBool {.cdecl, raises: [].}
    ##  A function pointer used for callbacks that watch the event queue.

# ============================================================================ #
# ==  Nim specific                                                          == #
# ============================================================================ #

# Calling default `$` and repr on union in Nim results with:
# SIGSEGV: Illegal storage access. (Attempt to read from nil?)

when defined release:
  func `$`*(event: ptr Event): string {.error: "do not `$` unions in Nim".}
  func repr*(event: Event): string {.error: "do not repr unions in Nim".}
else:
  func `$`*(event: Event): string = "(typ: " & $event.typ & ", ...)"
  func repr*(event: Event): string = "[typ = " & $event.typ & ", ...]"

func repr*(event: ptr Event): string {.error: "do not repr unions in Nim".}

# --------------------------------------------------------------------------- #
#   Sanity checks                                                             #
# --------------------------------------------------------------------------- #

when hostCPU == "amd64" and defined gcc:
  when Event.sizeof != 128:
    {.error: "invalid Event size: " & $Event.sizeof.}

  when CommonEvent.sizeof != 16:
    {.error: "invalid CommonEvent size: " & $CommonEvent.sizeof.}
  when WindowEvent.sizeof != 32:
    {.error: "invalid WindowEvent size: " & $WindowEvent.sizeof.}
  # XXX:
  # when KeyboardEvent.sizeof != 40:
  #   {.error: "invalid KeyboardEvent size: " & $KeyboardEvent.sizeof.}
  when TextEditingEvent.sizeof != 40:
    {.error: "invalid TextEditingEvent size: " & $TextEditingEvent.sizeof.}
  when TextInputEvent.sizeof != 32:
    {.error: "invalid TextInputEvent size: " & $TextInputEvent.sizeof.}
  when MouseMotionEvent.sizeof != 48:
    {.error: "invalid MouseMotionEvent size: " & $MouseMotionEvent.sizeof.}
  when MouseButtonEvent.sizeof != 40:
    {.error: "invalid MouseButtonEvent size: " & $MouseButtonEvent.sizeof.}
  when MouseWheelEvent.sizeof != 48:
    {.error: "invalid MouseWheelEvent size: " & $MouseWheelEvent.sizeof.}
  when JoyAxisEvent.sizeof != 32:
    {.error: "invalid JoyAxisEvent size: " & $JoyAxisEvent.sizeof.}
  when JoyHatEvent.sizeof != 24:
    {.error: "invalid JoyHatEvent size: " & $JoyHatEvent.sizeof.}
  when JoyButtonEvent.sizeof != 24:
    {.error: "invalid JoyButtonEvent size: " & $JoyButtonEvent.sizeof.}
  when JoyDeviceEvent.sizeof != 24:
    {.error: "invalid JoyDeviceEvent size: " & $JoyDeviceEvent.sizeof.}
  # when JoyBatteryEvent.sizeof != 24:
  #   {.error: "invalid JoyBatteryEvent size: " & $JoyBatteryEvent.sizeof.}
  when GamepadAxisEvent.sizeof != 32:
    {.error: "invalid GamepadAxisEvent size: " & $GamepadAxisEvent.sizeof.}
  when GamepadButtonEvent.sizeof != 24:
    {.error: "invalid GamepadButtonEvent size: " & $GamepadButtonEvent.sizeof.}
  when GamepadDeviceEvent.sizeof != 24:
    {.error: "invalid GamepadDeviceEvent size: " & $GamepadDeviceEvent.sizeof.}
  when GamepadTouchpadEvent.sizeof != 40:
    {.error: "invalid GamepadTouchpadEvent size: " & $GamepadTouchpadEvent.sizeof.}
  when GamepadSensorEvent.sizeof != 48:
    {.error: "invalid GamepadSensorEvent size: " & $GamepadSensorEvent.sizeof.}
  when AudioDeviceEvent.sizeof != 24:
    {.error: "invalid AudioDeviceEvent size: " & $AudioDeviceEvent.sizeof.}
  when TouchFingerEvent.sizeof != 56:
    {.error: "invalid TouchFingerEvent size: " & $TouchFingerEvent.sizeof.}
  # when PenTipEvent.sizeof != 64:
  #   {.error: "invalid PenTipEvent size: " & $PenTipEvent.sizeof.}
  # when PenMotionEvent.sizeof != 64:
  #   {.error: "invalid PenMotionEvent size: " & $PenMotionEvent.sizeof.}
  # when PenButtonEvent.sizeof != 64:
  #   {.error: "invalid PenButtonEvent size: " & $PenButtonEvent.sizeof.}
  when DropEvent.sizeof != 48:
    {.error: "invalid DropEvent size: " & $DropEvent.sizeof.}
  when ClipboardEvent.sizeof != 16:
    {.error: "invalid ClipboardEvent size: " & $ClipboardEvent.sizeof.}
  when SensorEvent.sizeof != 56:
    {.error: "invalid SensorEvent size: " & $SensorEvent.sizeof.}
  when QuitEvent.sizeof != 16:
    {.error: "invalid QuitEvent size: " & $QuitEvent.sizeof.}
  when UserEvent.sizeof != 40:
    {.error: "invalid UserEvent size: " & $UserEvent.sizeof.}

# vim: set sts=2 et sw=2:
