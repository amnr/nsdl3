##  Display information about all connected joysticks.
#[
  SPDX-License-Identifier: NCSA
]#

{.push raises: [].}

import std/enumerate
import std/strformat

import nsdl3

proc main() =
  # Load library.
  if not open_sdl3_library():
    echo "Failed to load SDL 3.0 library: ", last_sdl3_error()
    quit QuitFailure
  defer:
    close_sdl3_library()

  # Initialize SDL.
  if not Init INIT_JOYSTICK:
    echo "Failed to initialize SDL 3.0: ", GetError()
    quit QuitFailure
  defer:
    Quit()

  let joysticks = GetJoysticks()

  if joysticks.len == 0:
    echo "No joysticks found."
    return

  for i, joy_id in enumerate joysticks:
    echo "Joystick #", i, ':'
    let joy = OpenJoystick joy_id
    if joy == nil:
      echo "Failed to open joystick #", i
      continue
    defer:
      CloseJoystick joy

    #let guid = joy.get_guid_string

    #echo "  type . . : ", joy.get_type
    echo "  name . . : ", GetJoystickName joy
    echo "  path . . : ", GetJoystickPath joy
    #echo "  serial . : ", joy.get_serial
    #echo "  GUID . . : ", joy.get_guid_string
    #echo "  GUID . . : ", guid[0..7], '-', guid[8..11], '-', guid[12..15],
    #                      '-', guid[16..19], '-', guid[20..^1]
    try:
      echo &"  USB  . . : {GetJoystickVendor joy:04x}:{GetJoystickProduct joy:04x}"
    except ValueError:
      discard
    echo "  details  : ", GetNumJoystickAxes joy, " axes, ",
         GetNumJoystickButtons joy, " buttons, ",
         GetNumJoystickHats joy, " hats"
    echo "  features : ",
         " rumble: ", JoystickHasRumble joy,
         " rumble triggers: ", JoystickHasRumbleTriggers joy

when isMainModule:
  main()

# vim: set sts=2 et sw=2:
