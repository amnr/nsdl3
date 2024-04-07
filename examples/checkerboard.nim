##  Checkerboard.
#[
  SPDX-License-Identifier: NCSA
]#

{.push raises: [].}

when NimMajor >= 2 or defined nimPreviewSlimSystem:
  import std/assertions

import nsdl3

const
  win_width   = 800
  win_height  = 600

proc draw_checkerboard(texture: Texture) =
  var format: PixelFormatEnum
  var access, width, height: int
  assert QueryTexture(texture, format, access, width, height)
  echo format, ' ', access, ' ', width, " x ", height

  var buf = newSeqUninitialized[byte](width * height * uint32.sizeof)

  const components = [0x99'u8, 0x66'u8]

  var pos = 0
  for y in 0 ..< height:
    for x in 0 ..< width:
      let comp = components[((x xor y) div 8) and 1]
      buf[pos + 0] = comp
      buf[pos + 1] = comp
      buf[pos + 2] = comp
      buf[pos + 3] = comp
      pos += 4

  let pitch = width * uint32.sizeof
  assert UpdateTexture(texture, buf[0].addr, pitch)

proc main_test() =
  #var lib = loadSdl2()
  #defer:
  #  lib.close

  ## Initialize SDL2.
  #lib.init SDL_INIT_VIDEO
  #defer:
  #  lib.quit

  # Create the window screen.
  let win = CreateWindow("Checkerboard", win_width, win_height)
  if win == nil:
    echo "Failed to create window: ", GetError()
    quit QuitFailure
  defer:
    DestroyWindow win

  let renderer = CreateRenderer win
  if renderer == nil:
    echo "Failed to create renderer: ", GetError()
    quit QuitFailure
  defer:
    DestroyRenderer renderer

  #var info: RendererInfo
  #renderer.get_renderer_info info
  #echo info

  let texture = CreateTexture(renderer, PIXELFORMAT_RGBA8888, TEXTUREACCESS_STATIC, win_width, win_height)
  if texture == nil:
    echo "Failed to create texture: ", GetError()
    quit QuitFailure
  defer:
    DestroyTexture texture

  draw_checkerboard texture

  discard RenderClear renderer
  discard RenderTexture(renderer, texture)
  RenderPresent renderer

  # Wait for events.
  var event: Event
  while true:
    if PollEvent event:
      # echo event
      case event.typ
      of EVENT_KEY_DOWN:
        case event.key.keysym.sym
        of SDLK_ESCAPE, SDLK_q:
          break
        else:
          discard
      of EVENT_QUIT:
        break
      else:
        discard
    else:
      Delay 20

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

  main_test()

when isMainModule:
  main()

# vim: set sts=2 et sw=2:
