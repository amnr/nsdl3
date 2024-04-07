##  Random lines.
#[
  SPDX-License-Identifier: NCSA
]#

{.push raises: [].}

when NimMajor >= 2 or defined nimPreviewSlimSystem:
  import std/assertions
import std/random

import nsdl3

const
  WindowTitle = "Random Lines"
  Width       = 320     # Texture width.
  Height      = 240     # Texture height.
  Scale       = 3       # Window pixel scale.
  MaxLines    = 100
  DrawDelay   = 10

proc loop(renderer: Renderer, texture: Texture) =
  var
    event: Event
    cnt = 0
    force_clear = false

  # Randomize RNG for the loop.
  randomize()

  RenderPresent renderer

  assert RenderClear renderer

  while true:
    while PollEvent event:
      case event.typ
      of EVENT_KEYDOWN:
        case event.key.keysym.sym
        of SDLK_ESCAPE, SDLK_q:
          return
        of SDLK_SPACE:
          # assert renderer.set_draw_color(0x00, 0x00, 0x00)
          # assert RenderClear renderer
          force_clear = true
        else:
          discard
      of EVENT_QUIT:
        return
      else:
        discard

    assert SetRenderTarget(renderer, texture)

    if cnt >= MaxLines:
      force_clear = true
      cnt = 0

    if force_clear:
      assert SetRenderDrawColor(renderer, 0x00, 0x00, 0x00)
      assert RenderClear renderer
      force_clear = false

    # Set random pixel with random color.
    let
      x1 = float rand Width - 1
      y1 = float rand Height - 1
      x2 = float rand Width - 1
      y2 = float rand Height - 1
      color = rand 0x00ffffff

    assert SetRenderDrawColor(renderer, byte (color shr 16) and 0xff,
                              byte (color shr 8) and 0xff,
                              byte color and 0xff)
    assert RenderLine(renderer, x1, y1, x2, y2)
    inc cnt

    assert SetRenderTarget renderer

    # Render the texture.
    assert RenderCopy(renderer, texture)
    RenderPresent renderer

    Delay DrawDelay

proc main() =
  # Load library.
  if not open_sdl3_library():
    echo "Failed to load SDL 3.0 library: ", last_sdl3_error()
    quit QuitFailure
  defer:
    close_sdl3_library()

  # Initialize SDL.
  if not Init INIT_VIDEO:
    echo "Failed to initialize SDL3: ", GetError()
    quit QuitFailure
  defer:
    Quit()

  echo "Press <space> to clear the window."
  echo "Press <q> or <escape> to exit."

  # discard set_hint(HINT_VIDEO_DOUBLE_BUFFER, "0")

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
                              TEXTUREACCESS_TARGET, Width, Height)
  if texture == nil:
    echo "Failed to create texture: ", GetError()
    quit QuitFailure
  defer:
    DestroyTexture texture

  assert SetTextureScaleMode(texture, SCALEMODE_NEAREST)

  # SDL_TEXTUREACCESS_TARGET
  # SDL_SetRenderTarget(SDL_Renderer *renderer,SDL_Texture  *texture)

  loop renderer, texture

when isMainModule:
  main()

# vim: set sts=2 et sw=2:
