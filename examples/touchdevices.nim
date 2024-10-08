##  List touch devices.
#[
  SPDX-License-Identifier: NCSA
]#

{.push raises: [].}

import nsdl2

proc main() =
  # Load library.
  if not open_sdl2_library():
    echo "Failed to load SDL 2.0 library: ", last_sdl2_error()
    quit QuitFailure
  defer:
    close_sdl2_library()

  # Initialize SDL.
  if not Init INIT_SENSOR:
    echo "Failed to initialize SDL 2.0: ", GetError()
    quit QuitFailure
  defer:
    Quit()

  let num_devices = GetNumTouchDevices()

  echo "Touch devices : ", num_devices

when isMainModule:
  main()

# vim: set sts=2 et sw=2:
