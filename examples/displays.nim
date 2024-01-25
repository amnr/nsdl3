##  Displays.
#[
  SPDX-License-Identifier: NCSA
]#

{.push raises: [].}

import std/strformat

import nsdl3

proc list_displays() {.raises: ValueError.} =
  # if (SDL_InitSubSystem(SDL_INIT_VIDEO) == 0) {
  for disp_id in GetDisplays():
    let name = GetDisplayName disp_id

    # SDL_Log("Display %" SDL_PRIu32 ": %s\n", instance_id, name ? name : "Unknown");
    let outname = if name != "": name else: "Unknown"
    echo &"Display {disp_id.uint32}: {outname}"
  # SDL_QuitSubSystem(SDL_INIT_VIDEO);

proc list_fullscreen_display_modes() {.raises: ValueError.} =
  let display = GetPrimaryDisplay()
  var i = 0
  for mode in GetFullscreenDisplayModes display:
    # SDL_Log("Display %" SDL_PRIu32 " mode %d: %dx%d@%gx %gHz\n",
    #         display, i, mode->w, mode->h, mode->pixel_density, mode->refresh_rate);
    echo &"Display {display.uint32} mode {i}: {mode.w}x{mode.h}@{mode.pixel_density:g}x {mode.refresh_rate:g}Hz"
    inc i

proc main() =
  # Load library.
  if not open_sdl3_library():
    echo "Failed to load SDL 3.0 library: ", last_sdl3_error()
    quit QuitFailure
  defer:
    close_sdl3_library()

  if not Init INIT_VIDEO:
    echo "Failed to initialize SDL3: ", GetError()
    quit QuitFailure
  defer:
    Quit()

  try:
    list_displays()
  except ValueError as e:
    echo "ValueError: ", e.msg

  try:
    list_fullscreen_display_modes()
  except ValueError as e:
    echo "ValueError: ", e.msg

when isMainModule:
  main()

# vim: set sts=2 et sw=2:
