# High level SDL 3.0 shared library wrapper for Nim

**nsdl3** is a high level **SDL 3.0** shared library wrapper for Nim.

## Features

- Tries to hide as many C types from the user as possible.
- Replaces generic C types with Nim distinct ones.
- Does not require **SDL 3.0** library headers during build process.
- The executable is not linked again a specific **SDL 3.0** library version.
- Loads **SDL 3.0** library only when you need it (via `dynlib` module).
- Single external dependency: [dlutils](https://github.com/amnr/dlutils).

> **_WARNING:_** Keep in mind SDL3 API is not yet stable.

> **_NOTE:_** Not everything is implemented yet.

> **_NOTE:_** This is a mirror of my local git repository.

## API

Original C `SDL_` prefix is dropped:

- `SDL_INIT_VIDEO` becomes `INIT_VIDEO`
- `SDL_GetTicks` becomes `GetTicks`
- etc.

Refer to the [documentation](https://amnr.github.io/nsdl3/) for the complete
list of changes.

## Installation

```sh
git clone https://github.com/amnr/nsdl3/
cd nsdl3
nimble install
```

## Configuration

You can disable functions you don't use.
All function groups are enabled by default.

| Group       | Define              | Functions Defined In        |
| ----------- | ------------------- | --------------------------- |
| Audio       | `sdl3.audio=0`      | ``<SDL3/SDL_audio.h>``      |
| Blend Mode  | `sdl3.blendmode=0`  | ``<SDL3/SDL_blendmode.h>``  |
| Clipboard   | `sdl3.clipboard=0`  | ``<SDL3/SDL_clipboard.h>``  |
| Gamepad     | `sdl3.gamepad=0`    | ``<SDL3/SDL_gamepad.h>``    |
| Gesture     | `sdl3.gesture=0`    | ``<SDL3/SDL_gesture.h>``    |
| Haptic      | `sdl3.haptic=0`     | ``<SDL3/SDL_haptic.h>``     |
| HID API     | `sdl3.hidapi=0`     | ``<SDL3/SDL_hidapi.h>``     |
| Hints       | `sdl3.hints=0`      | ``<SDL3/SDL_hints.h>``      |
| Joystick    | `sdl3.joystick=0`   | ``<SDL3/SDL_joystick.h>``   |
| Keyboard    | `sdl3.keyboard=0`   | ``<SDL3/SDL_keyboard.h>``   |
| Message Box | `sdl3.messagebox=0` | ``<SDL3/SDL_messagebox.h>`` |
| Mouse       | `sdl3.mouse=0`      | ``<SDL3/SDL_mouse.h>``      |
| Pen         | `sdl3.pen=0`        | ``<SDL3/SDL_pen.h>``        |
| Properties  | `sdl3.mouse=0`      | ``<SDL3/SDL_mouse.h>``      |
| Sensor      | `sdl3.properties=0` | ``<SDL3/SDL_properties.h>`` |
| Touch       | `sdl3.touch=0`      | ``<SDL3/SDL_touch.h>``      |
| Vulkan      | `sdl3.vulkan=0`     | ``<SDL3/SDL_vulkan.h>``     |

For example if you don't need audio functions compile with:

```sh
nim c -d=sdl3.audio=0 file(s)
```

## Basic Usage

```nim
import nsdl3

proc main() =
  # Load all symbols from SDL3 shared library.
  # This must be the first proc called.
  if not open_sdl3_library():
    echo "Failed to load SDL3 library: ", last_sdl3_error()
    quit QuitFailure
  defer:
    close_sdl3_library()

  # Initialize the library.
  if not Init INIT_VIDEO:
    echo "Error initializing SDL3: ", GetError()
    quit QuitFailure
  defer:
    Quit()

  # Create the window.
  let window = CreateWindow("Test Window", 640, 480)
  if window == nil:
    echo "Error creating window: ", GetError()
    quit QuitFailure
  defer:
    DestroyWindow window

  # Create window renderer.
  let renderer = CreateRenderer window
  if renderer == nil:
    echo "Error creating renderer: ", GetError()
    quit QuitFailure
  defer:
    DestroyRenderer renderer

  # Clear the window.
  discard RenderClear renderer
  RenderPresent renderer

  # Basic event loop.
  var event: Event
  while true:
    while PollEvent event:
      case event.typ
      of EVENT_QUIT:
        return
      else:
       discard
    Delay 100

when isMainModule:
  main()
```

You can find more examples [here](examples/).

## Author

- [Amun](https://github.com/amnr/)

## License

`nlibsdl2` is released under:

- [**MIT**](LICENSE-MIT.txt) &mdash; Nim license
- [**NCSA**](LICENSE-NCSA.txt) &mdash; author's license of choice
- [**Zlib**](LICENSE-Zlib.txt) &mdash; SDL 3.0 license

Pick the one you prefer (or all).
