##  Random rectangles.
#[
  SPDX-License-Identifier: NCSA
]#

{.push raises: [].}

when NimMajor >= 2 or defined nimPreviewSlimSystem:
  import std/assertions
import std/random

import nsdl3

const
  WindowTitle = "Random Rectangles"
  Width       = 320     # Texture width.
  Height      = 240     # Texture height.
  Scale       = 3       # Window pixel scale.
  MaxRects    = 200
  DrawDelay   = 10

proc loop(window: Window, renderer: Renderer, texture: Texture) =
  var
    event: Event
    cnt = 0
    fill_mode = false
    force_clear = false

  # Randomize RNG for the loop.
  randomize()

  assert RenderClear renderer

  while true:
    while PollEvent event:
      case event.typ
      of EVENT_KEYDOWN:
        case event.key.key
        of SDLK_ESCAPE, SDLK_q:
          return
        of SDLK_SPACE:
          fill_mode = not fill_mode
          force_clear = true
        else:
          discard
      of EVENT_QUIT:
        return
      #of EVENT_WINDOW_CLOSE_REQUESTED:
      #  if event.window.window_id == get_window_id window:
      #    return
      else:
        discard

    assert SetRenderTarget(renderer, texture)

    if cnt >= MaxRects:
      fill_mode = not fill_mode
      force_clear = true
      cnt = 0

    if force_clear:
      assert SetRenderDrawColor(renderer, 0x00, 0x00, 0x00)
      assert RenderClear renderer
      force_clear = false

    # Set random pixel with random color.
    let
      x1 = rand Scale * Width - 1
      y1 = rand Scale * Height - 1
      x2 = rand Scale * Width - 1
      y2 = rand Scale * Height - 1
      color = rand 0x00ffffff

    let
      x = float min(x1, x2)
      y = float min(y1, y2)
      w = max(x1, x2).float - x
      h = max(y1, y2).float - y

    assert SetRenderDrawColor(renderer, byte (color shr 16) and 0xff,
                              byte (color shr 8) and 0xff,
                              byte color and 0xff)
    if fill_mode:
      assert RenderFillRect(renderer, x, y, w, h)
    else:
      assert RenderRect(renderer, x, y, w, h)
    inc cnt

    assert SetRenderTarget renderer

    # Render the texture.
    assert RenderTexture(renderer, texture)
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

  # Create window.
  let window = CreateWindow(WindowTitle, Scale * Width, Scale * Height)
  if window == nil:
    echo "Failed to create window: ", GetError()
    quit QuitFailure
  defer:
    DestroyWindow window

  # Create window renderer.
  let renderer = CreateRenderer window
  if renderer == nil:
    echo "Failed to create renderer: ", GetError()
    quit QuitFailure
  defer:
    DestroyRenderer renderer

  # Create renderer texture.
  let texture = CreateTexture(renderer, PIXELFORMAT_ARGB8888,
                              TEXTUREACCESS_TARGET,
                              Scale * Width, Scale * Height)
  if texture == nil:
    echo "Failed to create texture: ", GetError()
    quit QuitFailure
  defer:
    DestroyTexture texture

  assert SetTextureScaleMode(texture, SCALEMODE_NEAREST)

  loop window, renderer, texture

when isMainModule:
  main()

# vim: set sts=2 et sw=2:
