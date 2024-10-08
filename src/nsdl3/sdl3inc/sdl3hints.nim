##  Hints.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

import std/macros

macro gen_hint_enum_type(enum_name: string,
                          values: varargs[string]) =
  var fields: seq[NimNode] = @[]

  for val in values:
    let hname = newIdentNode "HINT_" & $val
    let hval  = newStrLitNode "SDL_" & $val
    fields.add(
      nnkEnumFieldDef.newNimNode.add(hname).add(
        nnkCommand.newNimNode.add(newIdentNode "cstring", hval)
      )
    )

  newEnum(ident $enum_name, fields, public = true, pure = false)

gen_hint_enum_type "HintName",
  "ACCELEROMETER_AS_JOYSTICK",
  "ALLOW_ALT_TAB_WHILE_GRABBED",
  "ALLOW_TOPMOST",
  "ANDROID_ALLOW_RECREATE_ACTIVITY",
  "ANDROID_BLOCK_ON_PAUSE_PAUSEAUDIO",
  "ANDROID_BLOCK_ON_PAUSE",
  "ANDROID_TRAP_BACK_BUTTON",
  "APP_ID",
  "APPLE_TV_CONTROLLER_UI_EVENTS",
  "APPLE_TV_REMOTE_ALLOW_ROTATION",
  "APP_NAME",
  "ASSERT",
  "AUDIO_ALSA_DEFAULT_DEVICE",
  "AUDIO_CATEGORY",
  "AUDIO_CHANNELS",
  "AUDIO_DEVICE_APP_NAME",
  "AUDIO_DEVICE_SAMPLE_FRAMES",
  "AUDIO_DEVICE_STREAM_NAME",
  "AUDIO_DEVICE_STREAM_ROLE",
  "AUDIO_DISK_INPUT_FILE",
  "AUDIO_DISK_OUTPUT_FILE",
  "AUDIO_DISK_TIMESCALE",
  "AUDIO_DRIVER",
  "AUDIO_DUMMY_TIMESCALE",
  "AUDIO_FORMAT",
  "AUDIO_FREQUENCY",
  "AUDIO_INCLUDE_MONITORS",
  "AUTO_UPDATE_JOYSTICKS",
  "AUTO_UPDATE_SENSORS",
  "BMP_SAVE_LEGACY_FORMAT",
  "CPU_FEATURE_MASK",
  "DIRECTINPUT_ENABLED",
  "DISPLAY_USABLE_BOUNDS",
  "EMSCRIPTEN_ASYNCIFY",
  "EMSCRIPTEN_CANVAS_SELECTOR",
  "EMSCRIPTEN_KEYBOARD_ELEMENT",
  "ENABLE_SCREEN_KEYBOARD",
  "EVDEV_DEVICES",
  "EVENT_LOGGING",
  "FILE_DIALOG_DRIVER",
  "FORCE_RAISEWINDOW",
  "FRAMEBUFFER_ACCELERATION",
  "GAMECONTROLLERCONFIG_FILE",
  "GAMECONTROLLERCONFIG",
  "GAMECONTROLLER_IGNORE_DEVICES_EXCEPT",
  "GAMECONTROLLER_IGNORE_DEVICES",
  "GAMECONTROLLER_SENSOR_FUSION",
  "GAMECONTROLLERTYPE",
  "GDK_TEXTINPUT_DEFAULT",
  "GDK_TEXTINPUT_DESCRIPTION",
  "GDK_TEXTINPUT_MAX_LENGTH",
  "GDK_TEXTINPUT_SCOPE",
  "GDK_TEXTINPUT_TITLE",
  "GPU_DRIVER",
  "HIDAPI_ENUMERATE_ONLY_CONTROLLERS",
  "HIDAPI_IGNORE_DEVICES",
  "HIDAPI_LIBUSB",
  "HIDAPI_LIBUSB_WHITELIST",
  "HIDAPI_UDEV",
  "IME_INTERNAL_EDITING",
  "IME_SHOW_UI",
  "IOS_HIDE_HOME_INDICATOR",
  "JOYSTICK_ALLOW_BACKGROUND_EVENTS",
  "JOYSTICK_ARCADESTICK_DEVICES",
  "JOYSTICK_ARCADESTICK_DEVICES_EXCLUDED",
  "JOYSTICK_BLACKLIST_DEVICES",
  "JOYSTICK_BLACKLIST_DEVICES_EXCLUDED",
  "JOYSTICK_DEVICE",
  "JOYSTICK_FLIGHTSTICK_DEVICES",
  "JOYSTICK_FLIGHTSTICK_DEVICES_EXCLUDED",
  "JOYSTICK_GAMECUBE_DEVICES",
  "JOYSTICK_GAMECUBE_DEVICES_EXCLUDED",
  "JOYSTICK_GAMECUBE_RUMBLE_BRAKE",
  "JOYSTICK_GAMEINPUT",
  "JOYSTICK_HIDAPI",
  "JOYSTICK_HIDAPI_COMBINE_JOY_CONS",
  "JOYSTICK_HIDAPI_GAMECUBE",
  "JOYSTICK_HIDAPI_JOYCON_HOME_LED",
  "JOYSTICK_HIDAPI_JOY_CONS",
  "JOYSTICK_HIDAPI_LUNA",
  "JOYSTICK_HIDAPI_NINTENDO_CLASSIC",
  "JOYSTICK_HIDAPI_PS3",
  "JOYSTICK_HIDAPI_PS3_SIXAXIS_DRIVER",
  "JOYSTICK_HIDAPI_PS4_RUMBLE",
  "JOYSTICK_HIDAPI_PS4",
  "JOYSTICK_HIDAPI_PS5_PLAYER_LED",
  "JOYSTICK_HIDAPI_PS5_RUMBLE",
  "JOYSTICK_HIDAPI_PS5",
  "JOYSTICK_HIDAPI_SHIELD",
  "JOYSTICK_HIDAPI_STADIA",
  "JOYSTICK_HIDAPI_STEAM",
  "JOYSTICK_HIDAPI_STEAM_HORI",
  "JOYSTICK_HIDAPI_STEAMDECK",
  "JOYSTICK_HIDAPI_SWITCH_HOME_LED",
  "JOYSTICK_HIDAPI_SWITCH_PLAYER_LED",
  "JOYSTICK_HIDAPI_SWITCH",
  "JOYSTICK_HIDAPI_VERTICAL_JOY_CONS",
  "JOYSTICK_HIDAPI_WII_PLAYER_LED",
  "JOYSTICK_HIDAPI_WII",
  "JOYSTICK_HIDAPI_XBOX_360_PLAYER_LED",
  "JOYSTICK_HIDAPI_XBOX_360",
  "JOYSTICK_HIDAPI_XBOX_360_WIRELESS",
  "JOYSTICK_HIDAPI_XBOX_ONE_HOME_LED",
  "JOYSTICK_HIDAPI_XBOX_ONE",
  "JOYSTICK_HIDAPI_XBOX",
  "JOYSTICK_IOKIT",
  "JOYSTICK_MFI",
  "JOYSTICK_RAWINPUT_CORRELATE_XINPUT",
  "JOYSTICK_RAWINPUT",
  "JOYSTICK_ROG_CHAKRAM",
  "JOYSTICK_THREAD",
  "JOYSTICK_THROTTLE_DEVICES",
  "JOYSTICK_THROTTLE_DEVICES_EXCLUDED",
  "JOYSTICK_WGI",
  "JOYSTICK_WHEEL_DEVICES",
  "JOYSTICK_WHEEL_DEVICES_EXCLUDED",
  "JOYSTICK_ZERO_CENTERED_DEVICES",
  "KMSDRM_DEVICE_INDEX",
  "KMSDRM_REQUIRE_DRM_MASTER",
  "LINUX_DIGITAL_HATS",
  "LINUX_HAT_DEADZONES",
  "LINUX_JOYSTICK_CLASSIC",
  "LINUX_JOYSTICK_DEADZONES",
  "LOGGING",
  "MAC_BACKGROUND_APP",
  "MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK",
  "MAC_OPENGL_ASYNC_DISPATCH",
  "MAC_SCROLL_MOMENTUM",
  "MAIN_CALLBACK_RATE",
  "MUTE_CONSOLE_KEYBOARD",
  "MOUSE_AUTO_CAPTURE",
  "MOUSE_DOUBLE_CLICK_RADIUS",
  "MOUSE_DOUBLE_CLICK_TIME",
  "MOUSE_FOCUS_CLICKTHROUGH",
  "MOUSE_NORMAL_SPEED_SCALE",
  "MOUSE_RELATIVE_MODE_CENTER",
  "MOUSE_RELATIVE_MODE_WARP",
  "MOUSE_RELATIVE_SPEED_SCALE",
  "MOUSE_RELATIVE_SYSTEM_SCALE",
  "MOUSE_RELATIVE_WARP_MOTION",
  "MOUSE_TOUCH_EVENTS",
  "NO_SIGNAL_HANDLERS",
  "OPENGL_ES_DRIVER",
  "OPENGL_LIBRARY",
  "ORIENTATIONS",
  "PEN_DELAY_MOUSE_BUTTON",
  "POLL_SENTINEL",
  "PREFERRED_LOCALES",
  "PS2_DYNAMIC_VSYNC",
  "QTWAYLAND_CONTENT_ORIENTATION",
  "QTWAYLAND_WINDOW_FLAGS",
  "QUIT_ON_LAST_WINDOW_CLOSE",
  "RENDER_DIRECT3D11_DEBUG",
  "RENDER_DIRECT3D_THREADSAFE",
  "RENDER_DRIVER",
  "RENDER_GPU_DEBUG",
  "RENDER_GPU_LOW_POWER",
  "RENDER_LINE_METHOD",
  "RENDER_METAL_PREFER_LOW_POWER_DEVICE",
  "RENDER_OPENGL_SHADERS",
  "RENDER_SCALE_QUALITY",
  "RENDER_VSYNC",
  "RETURN_KEY_HIDES_IME",
  "ROG_GAMEPAD_MICE",
  "ROG_GAMEPAD_MICE_EXCLUDED",
  "RPI_VIDEO_LAYER",
  "SCREENSAVER_INHIBIT_ACTIVITY_NAME",
  "SHUTDOWN_DBUS_ON_QUIT",
  "STORAGE_TITLE_DRIVER",
  "STORAGE_USER_DRIVER",
  "THREAD_FORCE_REALTIME_TIME_CRITICAL",
  "THREAD_PRIORITY_POLICY",
  "THREAD_STACK_SIZE",
  "TIMER_RESOLUTION",
  "TOUCH_MOUSE_EVENTS",
  "TRACKPAD_IS_TOUCH_ONLY",
  "TV_REMOTE_AS_JOYSTICK",
  "VIDEO_ALLOW_SCREENSAVER",
  "VIDEO_DOUBLE_BUFFER",
  "VIDEO_DRIVER",
  "VIDEO_DUMMY_SAVE_FRAMES",
  "VIDEO_EGL_ALLOW_GETDISPLAY_FALLBACK",
  "VIDEO_EXTERNAL_CONTEXT",
  "VIDEO_FORCE_EGL",
  "VIDEO_MAC_FULLSCREEN_SPACES",
  "VIDEO_MINIMIZE_ON_FOCUS_LOSS",
  "VIDEO_OFFSCREEN_SAVE_FRAMES",
  "VIDEO_SYNC_WINDOW_OPERATIONS",
  "VIDEO_WAYLAND_ALLOW_LIBDECOR",
  "VIDEO_WAYLAND_EMULATE_MOUSE_WARP",
  "VIDEO_WAYLAND_MODE_EMULATION",
  "VIDEO_WAYLAND_MODE_SCALING",
  "VIDEO_WAYLAND_PREFER_LIBDECOR",
  "VIDEO_WAYLAND_SCALE_TO_DISPLAY",
  "VIDEO_WIN_D3DCOMPILER",
  "VIDEO_X11_NET_WM_BYPASS_COMPOSITOR",
  "VIDEO_X11_NET_WM_PING",
  "VIDEO_X11_NODIRECTCOLOR",
  "VIDEO_X11_SCALING_FACTOR",
  "VIDEO_X11_VISUALID",
  "VIDEO_X11_WINDOW_VISUALID",
  "VIDEO_X11_XRANDR",
  "VITA_ENABLE_BACK_TOUCH",
  "VITA_ENABLE_FRONT_TOUCH",
  "VITA_MODULE_PATH",
  "VITA_PVR_INIT",
  "VITA_PVR_OPENGL",
  "VITA_RESOLUTION",
  "VITA_TOUCH_MOUSE_DEVICE",
  "VULKAN_DISPLAY",
  "VULKAN_LIBRARY",
  "WAVE_CHUNK_LIMIT",
  "WAVE_FACT_CHUNK",
  "WAVE_RIFF_CHUNK_SIZE",
  "WAVE_TRUNCATION",
  "WINDOW_ACTIVATE_WHEN_RAISED",
  "WINDOW_ACTIVATE_WHEN_SHOWN",
  "WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN",
  "WINDOWS_CLOSE_ON_ALT_F4",
  "WINDOWS_ENABLE_MENU_MNEMONICS",
  "WINDOWS_ENABLE_MESSAGELOOP",
  "WINDOWS_FORCE_SEMAPHORE_KERNEL",
  "WINDOWS_GAMEINPUT",
  "WINDOWS_INTRESOURCE_ICON",
  "WINDOWS_INTRESOURCE_ICON_SMALL",
  "WINDOWS_NO_CLOSE_ON_ALT_F4",
  "WINDOWS_RAW_KEYBOARD",
  "WINDOWS_USE_D3D9EX",
  "WINRT_HANDLE_BACK_BUTTON",
  "X11_FORCE_OVERRIDE_REDIRECT",
  "X11_WINDOW_TYPE",
  "X11_XCB_LIBRARY",
  "XINPUT_ENABLED"

type
  HintPriority* {.size: cint.sizeof.} = enum    # XXX: size.
    ##  Hint priorities.
    HINT_DEFAULT
    HINT_NORMAL
    HINT_OVERRIDE

  HintCallback* = proc (userdata: pointer, name: HintName,
                        old_value, new_value: cstring) {.cdecl, gcsafe, raises: [].}

# vim: set sts=2 et sw=2:
