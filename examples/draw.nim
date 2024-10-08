##  Draw on window.
#[
  SPDX-License-Identifier: NCSA
]#

import nsdl2

const
  WindowTitle = "Pixel Draw"
  Width = 320         # Texture width.
  Height = 240        # Texture height.
  Scale = 4           # Window pixel scale.

proc loop(renderer: Renderer, texture: Texture) =
  var
    pixels: array[Width * Height, uint32]
    event = Event()
    lmb = false

  while true:
    # Wait for events.
    assert WaitEvent event

    # Update the texture with new pixel data.
    assert UpdateTexture(texture, pixels, Width * uint32.sizeof)

    case event.typ
    of EVENT_MOUSEBUTTONDOWN:
      if event.button.button == BUTTON_LEFT:
        lmb = true
    of EVENT_MOUSEBUTTONUP:
      if event.button.button == BUTTON_LEFT:
        lmb = false
    of EVENT_MOUSEMOTION:
      if lmb:
        let x = event.motion.x div Scale
        let y = event.motion.y div Scale
        pixels[Width * y + x] = 0x00ffffff
    of EVENT_QUIT:
      return
    else:
      discard

    # Render the texture.
    assert RenderClear renderer
    assert RenderCopy(renderer, texture)
    RenderPresent renderer


proc main() =
  # Load library.
  if not open_sdl2_library():
    echo "Failed to load SDL 2.0 library: ", last_sdl2_error()
    quit QuitFailure
  defer:
    close_sdl2_library()

  # Initialize SDL.
  if not Init INIT_VIDEO:
    echo "Failed to initialize SDL 2.0: ", GetError()
    quit QuitFailure
  defer:
    Quit()

  # Create window.
  let win = CreateWindow(WindowTitle, Scale * Width, Scale * Height)
  if win == nil:
    echo "Failed to create window: ", GetError()
    quit QuitFailure
  defer:
    DestroyWindow win

  # Create window renderer.
  let renderer = CreateRenderer win
  if renderer == nil:
    echo "Failed to create renderer: ", GetError()
    quit QuitFailure
  defer:
    DestroyRenderer renderer

  # Create renderer texture.
  let texture = CreateTexture(renderer, PIXELFORMAT_ARGB8888,
                              TEXTUREACCESS_STATIC, Width, Height)
  if texture == nil:
    echo "Failed to create texture: ", GetError()
    quit QuitFailure
  defer:
    DestroyTexture texture

  loop renderer, texture

when isMainModule:
  main()

# vim: set sts=2 et sw=2:
