##  Random pixels.
#[
  SPDX-License-Identifier: NCSA
]#

{.push raises: [].}

import std/random

import nsdl3

const
  WindowTitle = "Random Pixels"
  Width       = 320     # Texture width.
  Height      = 240     # Texture height.
  Scale       = 3       # Window pixel scale.
  MaxPixels   = 1000
  DrawDelay   = 10

proc loop(renderer: Renderer, texture: Texture) =
  var
    surface: SurfacePtr = nil
    event: Event
    cnt = 0

  # Randomize RNG for the loop.
  randomize()

  while true:
    while PollEvent event:
      case event.typ
      of EVENT_KEY_DOWN:
        case event.key.key
        of SDLK_ESCAPE, SDLK_q:
          return
        else:
          discard
      of EVENT_QUIT:
        return
      else:
        discard

    if cnt < MaxPixels:
      # Set random pixel with random color.
      let
        x = rand Width - 1
        y = rand Height - 1
        r = byte rand 0xff
        g = byte rand 0xff
        b = byte rand 0xff

      if LockTextureToSurface(texture, surface):
        #  pixels[(pitch div 4) * y + x] = uint32 color
        discard WriteSurfacePixel(surface, x, y, r, g, b, 0xff)
        UnlockTexture texture
      inc cnt
    else:
      # Clear the pixmap if max number of pixels were drawn.
      assert SetRenderDrawColor(renderer, 0x00, 0x00, 0x00)
      assert RenderClear renderer
      cnt = 0

    # Update the texture with new pixel data.
    # discard UpdateTexture(texture, pixels[0].addr, Width * uint32.sizeof)

    # Render the texture.
    discard RenderClear renderer
    discard RenderTexture(renderer, texture)
    RenderPresent renderer

    Delay DrawDelay

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
                              # TEXTUREACCESS_STATIC, Width, Height)
                              TEXTUREACCESS_STREAMING, Width, Height)
  if texture == nil:
    echo "Failed to create texture: ", GetError()
    quit QuitFailure
  defer:
    DestroyTexture texture

  assert SetTextureScaleMode(texture, SCALEMODE_NEAREST)

  loop renderer, texture

when isMainModule:
  main()

# vim: set sts=2 et sw=2:
