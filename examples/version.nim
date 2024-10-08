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

  let vernum = GetVersion()

  let major = vernum div 1000_000
  let minor = (vernum div 1000) mod 1000
  let patch = vernum mod 1000
  let version = $major & '.' & $minor & '.' & $patch

  echo "Version ", version
  echo "Revision ", GetRevision()


  let title = "SDL" & version
  let message = "Nim " & NimVersion & '\n' &
                "SDL " & version

  discard ShowSimpleMessageBox(MESSAGEBOX_INFORMATION, title, message)

when isMainModule:
  main()

# vim: set sts=2 et sw=2:
