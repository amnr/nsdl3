##  Test version.
#[
  SPDX-License-Identifier: NCSA
]#

{.push raises: [].}

import nsdl3

proc main() =
  # Load library.
  if not open_sdl3_library():
    echo "Failed to load SDL 3.0 library: ", last_sdl3_error()
    quit QuitFailure
  defer:
    close_sdl3_library()

  if not Init():
    echo "Failed to initialize SDL3: ", GetError()
    quit QuitFailure
  defer:
    Quit()

  let ver = GetVersion()
  echo "Version ", ver.major, '.', ver.minor, '.', ver.patch
  echo "Version ", $ver
  echo "Revision ", GetRevision()

  let sdl_version = $ver.major & '.' & $ver.minor & '.' & $ver.patch

  let title = "SDL" & $ver.major
  let message = "Nim " & NimVersion & '\n' &
                "SDL " & sdl_version

  discard ShowSimpleMessageBox(MESSAGEBOX_INFORMATION, title, message)

when isMainModule:
  main()

# vim: set sts=2 et sw=2:
