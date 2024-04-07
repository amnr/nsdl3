##  High level SDL 3.0 shared library wrapper for Nim.
##
##  Documentation below comes from SDL 3.0 library documentation.
##
##  Usage
##  -----
##
##  ```nim
##  # Load all symbols from SDL 3.0 shared library.
##  # This must be the first proc called.
##  if not open_sdl3_library():
##    echo "Failed to load SDL 3.0 library: ", last_sdl3_error()
##    quit QuitFailure
##  defer:
##    close_sdl3_library()
##
##  # Initialize SDL 3.0.
##  if not Init INIT_VIDEO:
##    echo "Failed to initialize SDL 3.0: ", GetError()
##    quit QuitFailure
##  defer:
##    Quit()
##
##  # SDL 3.0 calls follow…
##  ```
##
##  Configuration
##  -------------
##
##  You can disable functions you don't use.
##  All function groups are enabled by default.
##
##  | Group       | Define              | Functions Defined In        |
##  | ----------- | ------------------- | --------------------------- |
##  | Audio       | `sdl3.audio=0`      | ``<SDL3/SDL_audio.h>``      |
##  | Blend Mode  | `sdl3.blendmode=0`  | ``<SDL3/SDL_blendmode.h>``  |
##  | Clipboard   | `sdl3.clipboard=0`  | ``<SDL3/SDL_clipboard.h>``  |
##  | Gamepad     | `sdl3.gamepad=0`    | ``<SDL3/SDL_gamepad.h>``    |
##  | Gesture     | `sdl3.gesture=0`    | ``<SDL3/SDL_gesture.h>``    |
##  | Haptic      | `sdl3.haptic=0`     | ``<SDL3/SDL_haptic.h>``     |
##  | HID API     | `sdl3.hidapi=0`     | ``<SDL3/SDL_hidapi.h>``     |
##  | Hints       | `sdl3.hints=0`      | ``<SDL3/SDL_hints.h>``      |
##  | Joystick    | `sdl3.joystick=0`   | ``<SDL3/SDL_joystick.h>``   |
##  | Keyboard    | `sdl3.keyboard=0`   | ``<SDL3/SDL_keyboard.h>``   |
##  | Message Box | `sdl3.messagebox=0` | ``<SDL3/SDL_messagebox.h>`` |
##  | Mouse       | `sdl3.mouse=0`      | ``<SDL3/SDL_mouse.h>``      |
##  | Pen         | `sdl3.pen=0`        | ``<SDL3/SDL_pen.h>``        |
##  | Properties  | `sdl3.mouse=0`      | ``<SDL3/SDL_mouse.h>``      |
##  | Sensor      | `sdl3.properties=0` | ``<SDL3/SDL_properties.h>`` |
##  | Touch       | `sdl3.touch=0`      | ``<SDL3/SDL_touch.h>``      |
##  | Vulkan      | `sdl3.vulkan=0`     | ``<SDL3/SDL_vulkan.h>``     |
##
##  For example if you don't need audio functions compile with:
##
##  ```sh
##  nim c -d=sdl3.audio=0 file(s)
##  ```
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

when NimMajor >= 2 and defined nimPreviewSlimSystem:
  from std/assertions import assert

import nsdl3/config
import nsdl3/libsdl3
import nsdl3/utils

when use_audio:
  import nsdl3/sdl3inc/audio
when use_blendmode:
  import nsdl3/sdl3inc/blendmode
import nsdl3/sdl3inc/events
when use_hints:
  import nsdl3/sdl3inc/hints
import nsdl3/sdl3inc/init
when use_joystick:
  import nsdl3/sdl3inc/joystick
import nsdl3/sdl3inc/keycode
import nsdl3/sdl3inc/log
when use_messagebox:
  import nsdl3/sdl3inc/messagebox
when use_mouse:
  import nsdl3/sdl3inc/mouse
import nsdl3/sdl3inc/pixels
import nsdl3/sdl3inc/properties
import nsdl3/sdl3inc/rect
import nsdl3/sdl3inc/render
# import nsdl3/sdl3inc/rwops
import nsdl3/sdl3inc/surface
import nsdl3/sdl3inc/timer
import nsdl3/sdl3inc/version
import nsdl3/sdl3inc/video

export open_sdl3_library, close_sdl3_library, last_sdl3_error

when use_audio:
  export audio
export events
when use_hints:
  export hints
export init
export keycode
export log
when use_messagebox:
  export messagebox
when use_mouse:
  export mouse
export pixels
export rect
export render
export surface
export timer
export video

when not declared newSeqUninit:
  template newSeqUninit*[T: SomeNumber](len: Natural): seq[T] =
      newSeqUninitialized[T] len

# =========================================================================== #
# ==  SDL3 library functions                                               == #
# =========================================================================== #

converter from_sdl_bool(b: SdlBool): bool =
  b.int != 0

converter to_sdl_bool(b: bool): SdlBool =
  b.SdlBool

proc c_free(mem: pointer) {.header: "<stdlib.h>", importc: "free", nodecl.}

# --------------------------------------------------------------------------- #
# <SDL3/SDL.h>                                                                #
# --------------------------------------------------------------------------- #

proc Init*(flags: InitFlags = INIT_VIDEO): bool =
  ##  Initialize SDL3 library.
  assert SDL_Init != nil, "did you forget to call open_sdl3_library?"
  ensure_zero "SDL_Init":
    SDL_Init flags

proc InitSubSystem*(flags: InitFlags): bool =
  ##  Initialize SDL3 subsystem.
  ensure_zero "SDL_InitSubSystem":
    SDL_InitSubSystem flags

proc Quit*() =
  ##  Clean up all initialized subsystems.
  SDL_Quit()

proc QuitSubSystem*(flags: InitFlags) {.inline.} =
  ##  ```c
  ##  void SDL_QuitSubSystem(Uint32 flags)
  ##  ```
  SDL_QuitSubSystem flags

proc WasInit*(flags: InitFlags = INIT_NONE): InitFlags {.inline.} =
  ##  ```c
  ##  Uint32 SDL_WasInit(Uint32 flags)
  ##  ```
  SDL_WasInit flags

# --------------------------------------------------------------------------- #
# <SDL3/SDL_audio.h>                                                          #
# --------------------------------------------------------------------------- #

when use_audio:
  # int SDL_BindAudioStream(SDL_AudioDeviceID devid, SDL_AudioStream *stream)
  # int SDL_BindAudioStreams(SDL_AudioDeviceID devid, SDL_AudioStream **streams,
  #     int num_streams)
  # int SDL_ClearAudioStream(SDL_AudioStream *stream)
  # void SDL_CloseAudioDevice(SDL_AudioDeviceID devid)
  # int SDL_ConvertAudioSamples(const SDL_AudioSpec *src_spec,
  #     const Uint8 *src_data, int src_len, const SDL_AudioSpec *dst_spec,
  #     Uint8 **dst_data, int *dst_len)

  proc CreateAudioStream*(src_spec: AudioSpec,
                          dst_spec: AudioSpec): AudioStream =
    ##  ```c
    ##  SDL_AudioStream *SDL_CreateAudioStream(const SDL_AudioSpec *src_spec,
    ##                                         const SDL_AudioSpec *dst_spec)
    ##  ```
    ensure_not_nil "SDL_CreateAudioStream":
      when NimMajor >= 2:
        SDL_CreateAudioStream src_spec.addr, dst_spec.addr
      else:
        SDL_CreateAudioStream src_spec.unsafeAddr, dst_spec.unsafeAddr

  proc DestroyAudioStream*(stream: AudioStream) {.inline.} =
    ##  ```c
    ##  void SDL_DestroyAudioStream(SDL_AudioStream *stream)
    ##  ```
    SDL_DestroyAudioStream stream

  proc FlushAudioStream*(stream: AudioStream): bool =
    ##  ```c
    ##  int SDL_FlushAudioStream(SDL_AudioStream *stream)
    ##  ```
    ensure_zero "SDL_FlushAudioStream":
      SDL_FlushAudioStream stream

  # SDL_AudioDeviceID *SDL_GetAudioCaptureDevices(int *count)
  # int SDL_GetAudioDeviceFormat(SDL_AudioDeviceID devid, SDL_AudioSpec *spec,
  #     int *sample_frames)

  proc GetAudioDeviceName*(devid: AudioDeviceID): string =
    ##  ```c
    ##    char *SDL_GetAudioDeviceName(SDL_AudioDeviceID devid)
    ##  ```
    let name = SDL_GetAudioDeviceName devid
    result = $name
    c_free name

  proc GetAudioDriver*(index: int): string =
    ##  ```c
    ##  const char *SDL_GetAudioDriver(int index)
    ##  ```
    let name = SDL_GetAudioDriver index.cint
    if name == nil:
      log_error "SDL_GetAudioDriver failed: " & $SDL_GetError()
      return ""
    $name

  proc GetAudioOutputDevices*(): seq[AudioDeviceID] =
    ##  ```c
    ##    SDL_AudioDeviceID *SDL_GetAudioOutputDevices(int *count)
    ##  ```
    var count: cint = 0

    let devices = SDL_GetAudioOutputDevices count.addr
    if devices == nil:
      return @[]

    result = newSeqOfCap[AudioDeviceID] count
    for i in 0 ..< count:
      result.add devices[i]

    c_free devices

  proc GetAudioStreamAvailable*(stream: AudioStream): bool =
    ##  ```c
    ##    int SDL_GetAudioStreamAvailable(SDL_AudioStream *stream)
    ##  ```
    ensure_zero "SDL_GetAudioStreamAvailable":
      SDL_GetAudioStreamAvailable stream

  # int SDL_GetAudioStreamData(SDL_AudioStream *stream, void *buf, int len)

  proc GetAudioStreamDevice*(stream: AudioStream): AudioDeviceID =
    ##  ```c
    ##  SDL_AudioDeviceID SDL_GetAudioStreamDevice(SDL_AudioStream *stream)
    ##  ```
    SDL_GetAudioStreamDevice stream     # XXX: TODO: returns 0 if invalid/not bound.

  # int SDL_GetAudioStreamFormat(SDL_AudioStream *stream,
  #     SDL_AudioSpec *src_spec, SDL_AudioSpec *dst_spec)

  # float SDL_GetAudioStreamFrequencyRatio(SDL_AudioStream *stream)

  # SDL_PropertiesID SDL_GetAudioStreamProperties(SDL_AudioStream *stream)

  proc GetCurrentAudioDriver*(): string {.inline.} =
    ##  ```c
    ##    const char *SDL_GetCurrentAudioDriver(void)
    ##  ```
    $SDL_GetCurrentAudioDriver()

  proc GetNumAudioDrivers*(): int {.inline.} =
    ##  ```c
    ##  int SDL_GetNumAudioDrivers(void)
    ##  ```
    SDL_GetNumAudioDrivers()

  # int SDL_GetSilenceValueForFormat(SDL_AudioFormat format)
  # SDL_bool SDL_AudioDevicePaused(SDL_AudioDeviceID dev)
  # int SDL_GetAudioStreamQueued(SDL_AudioStream *stream)
  # int SDL_LoadWAV(const char *path, SDL_AudioSpec *spec, Uint8 ** audio_buf,
  #     Uint32 *audio_len)
  # int SDL_LoadWAV_RW(SDL_RWops *src, SDL_bool freesrc, SDL_AudioSpec *spec,
  #     Uint8 ** audio_buf, Uint32 *audio_len)
  # int SDL_LockAudioStream(SDL_AudioStream *stream)
  # int SDL_MixAudioFormat(Uint8 *dst, const Uint8 *src, SDL_AudioFormat format,
  #     Uint32 len, int volume)
  # SDL_AudioDeviceID SDL_OpenAudioDevice(SDL_AudioDeviceID devid,
  #     const SDL_AudioSpec *spec)

  proc OpenAudioDeviceStream*(devid: AudioDeviceID, spec: AudioSpec,
                              callback: AudioStreamCallback,
                              userdata: pointer = nil): AudioStream =
    ##  ```c
    ##  SDL_AudioStream *
    ##  SDL_OpenAudioDeviceStream(SDL_AudioDeviceID devid,
    ##                            const SDL_AudioSpec *spec,
    ##                            SDL_AudioStreamCallback callback,
    ##                            void *userdata)
    ##  ```
    ensure_not_nil "SDL_OpenAudioDeviceStream":
      when NimMajor >= 2:
        SDL_OpenAudioDeviceStream devid, spec.addr, callback, userdata
      else:
        SDL_OpenAudioDeviceStream devid, spec.unsafeAddr, callback, userdata

  proc PauseAudioDevice*(dev: AudioDeviceID): bool =
    ##  ```c
    ##    int SDL_PauseAudioDevice(SDL_AudioDeviceID dev)
    ##  ```
    ensure_zero "SDL_PauseAudioDevice":
      SDL_PauseAudioDevice dev

  proc PutAudioStreamData*(stream: AudioStream, buf: pointer,
                           buflen: int): bool =
    ##  ```c
    ##  int SDL_PutAudioStreamData(SDL_AudioStream *stream, const void *buf,
    ##                             int len)
    ##  ```
    ensure_zero "SDL_PutAudioStreamData":
      SDL_PutAudioStreamData stream, buf, buflen.cint

  proc ResumeAudioDevice*(dev: AudioDeviceID): bool =
    ##  ```c
    ##    int SDL_ResumeAudioDevice(SDL_AudioDeviceID dev)
    ##  ```
    ensure_zero "SDL_ResumeAudioDevice":
      SDL_ResumeAudioDevice dev

  # int SDL_SetAudioPostmixCallback(SDL_AudioDeviceID devid,
  #     SDL_AudioPostmixCallback callback, void *userdata)
  # int SDL_SetAudioStreamFormat(SDL_AudioStream *stream,
  #     const SDL_AudioSpec *src_spec, const SDL_AudioSpec *dst_spec)
  # int SDL_SetAudioStreamFrequencyRatio(SDL_AudioStream *stream, float ratio)
  # int SDL_SetAudioStreamGetCallback(SDL_AudioStream *stream,
  #     SDL_AudioStreamCallback callback, void *userdata)
  # int SDL_SetAudioStreamPutCallback(SDL_AudioStream *stream,
  #     SDL_AudioStreamCallback callback, void *userdata)
  # void SDL_UnbindAudioStream(SDL_AudioStream *stream)
  # void SDL_UnbindAudioStreams(SDL_AudioStream **streams, int num_streams)
  # int SDL_UnlockAudioStream(SDL_AudioStream *stream)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_blendmode.h>                                                      #
# --------------------------------------------------------------------------- #

when use_blendmode:
  proc ComposeCustomBlendMode*(src_color_factor: BlendFactor,
                               dst_color_factor: BlendFactor,
                               color_operation: BlendOperation,
                               src_alpha_factor: BlendFactor,
                               dst_alpha_factor: BlendFactor,
                               alpha_operation: BlendOperation): BlendMode =
    ##  Compose a custom blend mode for renderers.
    ##
    ##  ```c
    ##  SDL_BlendMode
    ##  SDL_ComposeCustomBlendMode(SDL_BlendFactor srcColorFactor,
    ##                             SDL_BlendFactor dstColorFactor,
    ##                             SDL_BlendOperation colorOperation,
    ##                             SDL_BlendFactor srcAlphaFactor,
    ##                             SDL_BlendFactor dstAlphaFactor,
    ##                             SDL_BlendOperation alphaOperation)
    ##  ```
    SDL_ComposeCustomBlendMode src_color_factor, dst_color_factor,
                               color_operation, src_alpha_factor,
                               dst_alpha_factor, alpha_operation

# --------------------------------------------------------------------------- #
# <SDL3/SDL_clipboard.h>                                                      #
# --------------------------------------------------------------------------- #

when use_clipboard:

  proc ClearClipboardData*(): bool =
    ##  ```c
    ##  int SDL_ClearClipboardData(void)
    ##  ```
    ensure_zero "SDL_ClearClipboardData":
      SDL_ClearClipboardData()

  proc GetClipboardData*(mime_type: string): seq[byte] =
    ##  ```c
    ##  void *SDL_GetClipboardData(const char *mime_type, size_t *size)
    ##  ```
    var size: csize_t = 0
    let data = SDL_GetClipboardData(mime_type.cstring, size.addr)
    if data == nil:
      log_error "SDL_GetClipboardData failed: ", $SDL_GetError()
      return @[]
    result = newSeqUninit[byte] size
    copyMem result[0].addr, data, size
    # XXX: TODO: free data?

  # char * SDL_GetClipboardText(void)
  # char * SDL_GetPrimarySelectionText(void)

  proc HasClipboardData*(mime_type: string): bool =
    ##  Query whether there is data in the clipboard for the provided mime
    ##  type.
    ##
    ##  ```c
    ##  SDL_bool SDL_HasClipboardData(const char *mime_type)
    ##  ```
    SDL_HasClipboardData mime_type.cstring

  # SDL_bool SDL_HasClipboardText(void)
  # SDL_bool SDL_HasPrimarySelectionText(void)
  # int SDL_SetClipboardData(SDL_ClipboardDataCallback callback,
  #     SDL_ClipboardCleanupCallback cleanup, void *userdata,
  #     const char **mime_types, size_t num_mime_types)
  # int SDL_SetClipboardText(const char *text)
  # int SDL_SetPrimarySelectionText(const char *text)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_error.h>                                                          #
# --------------------------------------------------------------------------- #

proc ClearError*() {.inline.} =
  ##  ```c
  ##  void SDL_ClearError(void)
  ##  ```
  SDL_ClearError()

# int SDL_Error(SDL_errorcode code)

proc GetError*(): string {.inline.} =
  ##  ```c
  ##  const char *SDL_GetError(void)
  ##  ```
  assert SDL_GetError != nil
  $SDL_GetError()

# int SDL_SetError(const char *fmt, ...)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_events.h>                                                         #
# --------------------------------------------------------------------------- #

# XXX: file removed
#proc free_drop_event_file*(event: var Event) =
#  ##  Free memory allocated for `EVENT_DROP_FILE` or `EVENT_DROP_TEXT`.
#  if event.typ == EVENT_DROP_FILE or event.typ == EVENT_DROP_TEXT:
#    if event.drop.file != nil:
#      sdl3_free event.drop.file
#      event.drop.file = nil       # Just in case.
# XXX:

# int SDL_AddEventWatch(SDL_EventFilter filter, void *userdata)
# void *SDL_AllocateEventMemory(size_t size)
# void SDL_DelEventWatch(SDL_EventFilter filter, void *userdata)
# SDL_bool SDL_EventEnabled(Uint32 type)
# void SDL_FilterEvents(SDL_EventFilter filter, void *userdata)
# void SDL_FlushEvent(Uint32 type)
# void SDL_FlushEvents(Uint32 minType, Uint32 maxType)
# SDL_bool SDL_GetEventFilter(SDL_EventFilter *filter, void **userdata)
# SDL_bool SDL_HasEvent(Uint32 type)
# SDL_bool SDL_HasEvents(Uint32 minType, Uint32 maxType)

proc PeepEvents*(events: var openArray[Event], numevents: int,
                 action: EventAction, min_type: EventType,
                 max_type: EventType): int =
  ##  ```c
  ##  int SDL_PeepEvents(SDL_Event *events, int numevents,
  ##                     SDL_eventaction action, Uint32 minType,
  ##                     Uint32 maxType)
  ##  ```
  let num_events = cint min(numevents, events.len)
  result = SDL_PeepEvents(events[0].addr, num_events, action,
                                  min_type, max_type)
  if result < 0:
    log_error "SDL_PeepEvents failed: ", $SDL_GetError()

proc PeepEvents*(events: var openArray[Event], action: EventAction,
                 min_type: EventType, max_type: EventType): int {.inline.} =
  PeepEvents events, action, min_type, max_type

proc PollEvent*(): bool {.inline.} =
  ##  ```c
  ##  int SDL_PollEvent(SDL_Event *event)
  ##  ```
  SDL_PollEvent nil

proc PollEvent*(event: var Event): bool {.inline.} =
  ##  ```c
  ##  int SDL_PollEvent(SDL_Event *event)
  ##  ```
  SDL_PollEvent event.addr

proc PumpEvents*() {.inline.} =
  ##  ```c
  ##  void SDL_PumpEvents(void)
  ##  ```
  SDL_PumpEvents()

proc PushEvent*(event: var Event): bool {.inline.} =
  ##  ```c
  ##  int SDL_PushEvent(SDL_Event *event)
  ##  ```
  SDL_PushEvent(event.addr) != 0

# Uint32 SDL_RegisterEvents(int numevents)

proc SetEventEnabled*(typ: EventType, state: bool) {.inline.} =
  ##  Set the state of processing events by type.
  ##
  ##  ```c
  ##  void SDL_SetEventEnabled(Uint32 type, SDL_bool enabled)
  ##  ```
  SDL_SetEventEnabled(typ.uint32, state)

# void SDL_SetEventFilter(SDL_EventFilter filter, void *userdata)

proc WaitEvent*(): bool {.inline.} =
  ##  ```c
  ##  int SDL_WaitEvent(SDL_Event *event)
  ##  ```
  SDL_WaitEvent nil

proc WaitEvent*(event: var Event): bool {.inline.} =
  ##  ```c
  ##  int SDL_WaitEvent(SDL_Event *event)
  ##  ```
  SDL_WaitEvent event.addr

proc WaitEventTimeout*(timeout: int32): bool {.inline.} =
  ##  ```c
  ##  int SDL_WaitEventTimeout(SDL_Event *event, Sint32 timeoutMS)
  ##  ```
  SDL_WaitEventTimeout nil, timeout

proc WaitEventTimeout*(event: var Event, timeout: int32): bool {.inline.} =
  ##  ```c
  ##  int SDL_WaitEventTimeout(SDL_Event *event, Sint32 timeoutMS)
  ##  ```
  SDL_WaitEventTimeout event.addr, timeout

# XXX
# proc event_state*(typ: EventType, state: bool): bool {.deprecated.} # : "use set_event_enabled instead".}

# --------------------------------------------------------------------------- #
# <SDL3/SDL_gamepad.h>                                                        #
# --------------------------------------------------------------------------- #

# TODO.

# --------------------------------------------------------------------------- #
# <SDL3/SDL_haptic.h>                                                         #
# --------------------------------------------------------------------------- #

# TODO.

# --------------------------------------------------------------------------- #
# <SDL3/SDL_hidapi.h>                                                         #
# --------------------------------------------------------------------------- #

# TODO.

# --------------------------------------------------------------------------- #
# <SDL3/SDL_hints.h>                                                          #
# --------------------------------------------------------------------------- #

when use_hints:
  # int SDL_AddHintCallback(const char *name, SDL_HintCallback callback,
  #     void *userdata)
  # void SDL_ClearHints(void)
  # void SDL_DelHintCallback(const char *name, SDL_HintCallback callback,
  #     void *userdata)

  proc GetHint*(name: HintName): string {.inline.} =
    ##  ```c
    ##  const char * SDL_GetHint(const char *name)
    ##  ```
    $SDL_GetHint name

  # SDL_bool SDL_GetHintBoolean(const char *name, SDL_bool default_value)
  # SDL_bool SDL_ResetHint(const char *name)
  # void SDL_ResetHints(void)

  proc SetHint*(name: HintName, value: string): bool {.inline.} =
    ##  ```c
    ##  SDL_bool SDL_SetHint(const char *name, const char *value)
    ##  ```
    SDL_SetHint(cstring $name, value.cstring)

  # SDL_bool SDL_SetHintWithPriority(const char *name, const char *value,
  #     SDL_HintPriority priority)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_init.h>                                                           #
# --------------------------------------------------------------------------- #

# int SDL_Init(Uint32 flags)
# int SDL_InitSubSystem(Uint32 flags)
# void SDL_Quit(void)
# void SDL_QuitSubSystem(Uint32 flags)
# Uint32 SDL_WasInit(Uint32 flags)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_joystick.h>                                                       #
# --------------------------------------------------------------------------- #

when use_joystick:

  proc CloseJoystick*(joystick: Joystick) {.inline.} =
    ##  `SDL_CloseJoystick`
    SDL_CloseJoystick joystick

  proc GetJoystickGUID*(joystick: Joystick): JoystickGUID {.inline.} =
    ##  `SDL_GetJoystickGUID`
    SDL_GetJoystickGUID joystick

  proc JoystickHasRumble*(joystick: Joystick): bool {.deprecated: "use GetJoystickCaps instead".} =
    assert false    # XXX

  proc JoystickHasRumbleTriggers*(joystick: Joystick): bool {.deprecated: "use GetJoystickCaps instead".} =
    assert false    # XXX

  proc GetJoystickName*(joystick: Joystick): string {.inline.} =
    ##  `SDL_GetJoystickName`
    $SDL_GetJoystickName joystick

  proc GetJoystickPath*(joystick: Joystick): string {.inline.} =
    ##  `SDL_GetJoystickPath`
    $SDL_GetJoystickPath joystick

  proc GetJoystickProduct*(joystick: Joystick): uint16 {.inline.} =
    ##  `SDL_GetJoystickProduct`
    SDL_GetJoystickProduct joystick

  # XXX: no joysticks vs error
  proc GetJoysticks*(): seq[JoystickID] =
    ##  `SDL_GetJoysticks`
    result = @[]
    var count: cint = 0
    let joysticks = SDL_GetJoysticks count.addr
    if joysticks == nil:
      log_error "SDL_GetJoysticks failed: " & $SDL_GetError()
      return
    var i = 0
    while joysticks[i] != 0:
      result.add joysticks[i]
      i += 1

  proc GetJoystickVendor*(joystick: Joystick): uint16 {.inline.} =
    ##  `SDL_GetJoystickVendor`
    SDL_GetJoystickVendor joystick

  proc GetNumJoystickAxes*(joystick: Joystick): int =
    ##  `SDL_GetNumJoystickAxes`
    ensure_natural "SDL_GetNumJoystickAxes":
      SDL_GetNumJoystickAxes joystick

  proc JoystickNumAxes*(joystick: Joystick): int {.deprecated: "Use GetNumJoystickAxes instead".} =
    GetNumJoystickAxes joystick

  proc GetNumJoystickButtons*(joystick: Joystick): int =
    ##  `SDL_GetNumJoystickButtons`
    ensure_natural "SDL_GetNumJoystickButtons":
      SDL_GetNumJoystickButtons joystick

  proc JoystickNumButtons*(joystick: Joystick): int {.deprecated: "Use GetNumJoystickButtons instead".} =
    GetNumJoystickButtons joystick

  proc GetNumJoystickHats*(joystick: Joystick): int =
    ##  `SDL_GetNumJoystickHats`
    ensure_natural "SDL_GetNumJoystickHats":
      SDL_GetNumJoystickHats joystick

  proc JoystickNumHats*(joystick: Joystick): int {.deprecated: "Use GetNumJoystickHats instead".} =
    GetNumJoystickHats joystick

  proc OpenJoystick*(instance_id: JoystickID): Joystick =    # XXX: open?
    ##  `SDL_OpenJoystick`
    ensure_not_nil "SDL_OpenJoystick":
      SDL_OpenJoystick instance_id

  proc UpdateJoysticks*() {.inline.} =
    ##  ```c
    ##  void SDL_UpdateJoysticks(void)
    ##  ```
    SDL_UpdateJoysticks()

  # void SDL_LockJoysticks(void) SDL_ACQUIRE(SDL_joystick_lock)
  # void SDL_UnlockJoysticks(void) SDL_RELEASE(SDL_joystick_lock)
  # const char *SDL_GetJoystickInstanceName(SDL_JoystickID instance_id)
  # const char *SDL_GetJoystickInstancePath(SDL_JoystickID instance_id)
  # int SDL_GetJoystickInstancePlayerIndex(SDL_JoystickID instance_id)
  # SDL_JoystickGUID SDL_GetJoystickInstanceGUID(SDL_JoystickID instance_id)
  # Uint16 SDL_GetJoystickInstanceVendor(SDL_JoystickID instance_id)
  # Uint16 SDL_GetJoystickInstanceProduct(SDL_JoystickID instance_id)
  # Uint16 SDL_GetJoystickInstanceProductVersion(SDL_JoystickID instance_id)
  # SDL_JoystickType SDL_GetJoystickInstanceType(SDL_JoystickID instance_id)
  # SDL_Joystick *SDL_GetJoystickFromInstanceID(SDL_JoystickID instance_id)
  # SDL_Joystick *SDL_GetJoystickFromPlayerIndex(int player_index)
  # SDL_JoystickID SDL_AttachVirtualJoystick(SDL_JoystickType type,
  # SDL_JoystickID SDL_AttachVirtualJoystickEx(const SDL_VirtualJoystickDesc *desc)
  # int SDL_DetachVirtualJoystick(SDL_JoystickID instance_id)
  # SDL_bool SDL_IsJoystickVirtual(SDL_JoystickID instance_id)
  # int SDL_SetJoystickVirtualAxis(joystick: Joystick, int axis, Sint16 value)
  # int SDL_SetJoystickVirtualButton(joystick: Joystick, int button, Uint8 value)
  # int SDL_SetJoystickVirtualHat(joystick: Joystick, int hat, Uint8 value)
  # SDL_PropertiesID SDL_GetJoystickProperties(joystick: Joystick)
  # int SDL_GetJoystickPlayerIndex(joystick: Joystick)
  # int SDL_SetJoystickPlayerIndex(joystick: Joystick, int player_index)
  # Uint16 SDL_GetJoystickProductVersion(joystick: Joystick)
  # Uint16 SDL_GetJoystickFirmwareVersion(joystick: Joystick)
  # const char * SDL_GetJoystickSerial(joystick: Joystick)
  # SDL_JoystickType SDL_GetJoystickType(joystick: Joystick)
  # int SDL_GetJoystickGUIDString(SDL_JoystickGUID guid, char *pszGUID, int cbGUID)
  # SDL_JoystickGUID SDL_GetJoystickGUIDFromString(const char *pchGUID)
  # void SDL_GetJoystickGUIDInfo(SDL_JoystickGUID guid, Uint16 *vendor, Uint16 *product, Uint16 *version, Uint16 *crc16)
  # SDL_bool SDL_JoystickConnected(joystick: Joystick)
  # SDL_JoystickID SDL_GetJoystickInstanceID(joystick: Joystick)
  # void SDL_SetJoystickEventsEnabled(SDL_bool enabled)
  # SDL_bool SDL_JoystickEventsEnabled(void)
  # Sint16 SDL_GetJoystickAxis(joystick: Joystick,
  # SDL_bool SDL_GetJoystickAxisInitialState(joystick: Joystick,
  # Uint8 SDL_GetJoystickHat(joystick: Joystick,
  # Uint8 SDL_GetJoystickButton(joystick: Joystick,
  # int SDL_RumbleJoystick(joystick: Joystick, Uint16 low_frequency_rumble, Uint16 high_frequency_rumble, Uint32 duration_ms)
  # int SDL_RumbleJoystickTriggers(joystick: Joystick, Uint16 left_rumble, Uint16 right_rumble, Uint32 duration_ms)
  # int SDL_SetJoystickLED(joystick: Joystick, Uint8 red, Uint8 green, Uint8 blue)
  # int SDL_SendJoystickEffect(joystick: Joystick, const void *data, int size)
  # SDL_JoystickPowerLevel SDL_GetJoystickPowerLevel(joystick: Joystick)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_keyboard.h>                                                       #
# --------------------------------------------------------------------------- #

# TODO.

# --------------------------------------------------------------------------- #
# <SDL3/SDL_log.h>                                                            #
# --------------------------------------------------------------------------- #

# SDL_Log, SDL_LogCritical, SDL_LogDebug, SDL_LogError, SDL_LogInfo,
# SDL_LogVerbose and SDL_LogWarn are emulated by calling SDL_LogMessage.

proc LogMessage*(category: LogCategory, priority: LogPriority, message: string)

proc Log*(message: string) {.inline.} =
  ##  ```c
  ##  void SDL_Log(const char *fmt, ...)
  ##  ```
  LogMessage LOG_CATEGORY_APPLICATION, LOG_PRIORITY_INFO, message

proc LogCritical*(category: LogCategory, message: string) {.inline.} =
  ##  ```c
  ##  void SDL_LogCritical(int category, const char *fmt, ...)
  ##  ```
  LogMessage category, LOG_PRIORITY_CRITICAL, message

proc LogDebug*(category: LogCategory, message: string) {.inline.} =
  ##  ```c
  ##  void SDL_LogDebug(int category, const char *fmt, ...)
  ##  ```
  LogMessage category, LOG_PRIORITY_DEBUG, message

proc LogError*(category: LogCategory, message: string) {.inline.} =
  ##  ```c
  ##  void SDL_LogError(int category, const char *fmt, ...)
  ##  ```
  LogMessage category, LOG_PRIORITY_ERROR, message

# void SDL_LogGetOutputFunction(SDL_LogOutputFunction *callback,
#     void **userdata)
# SDL_LogPriority SDL_LogGetPriority(int category)

proc LogInfo*(category: LogCategory, message: string) {.inline.} =
  ##  ```c
  ##  void SDL_LogInfo(int category, const char *fmt, ...)
  ##  ```
  LogMessage category, LOG_PRIORITY_INFO, message

proc LogMessage*(category: LogCategory, priority: LogPriority,
                 message: string) =
  ##  ```c
  ##  void SDL_LogMessage(int category, SDL_LogPriority priority,
  ##                      const char *fmt, ...)
  ##  ```
  SDL_LogMessage category, priority, "%s", message.cstring

# void SDL_LogMessageV(int category, SDL_LogPriority priority, const char *fmt,
#                      va_list ap)
# void SDL_LogResetPriorities(void)
# void SDL_LogSetAllPriority(SDL_LogPriority priority)

proc SetLogOutputFunction*(callback: LogOutputFunction,
                           userdata: pointer = nil) {.inline.} =
  ##  ```c
  ##  void SDL_SetLogOutputFunction(SDL_LogOutputFunction callback,
  ##                                void *userdata)
  ##  ```
  SDL_SetLogOutputFunction callback, userdata

proc LogSetPriority*(category: LogCategory, priority: LogPriority) {.inline.} =
  ##  ```c
  ##  void SDL_LogSetPriority(int category, SDL_LogPriority priority)
  ##  ```
  SDL_LogSetPriority category, priority

proc LogVerbose*(category: LogCategory, message: string) {.inline.} =
  ##  ```c
  ##  void SDL_LogVerbose(int category, const char *fmt, ...)
  ##  ```
  LogMessage category, LOG_PRIORITY_VERBOSE, message

proc LogWarn*(category: LogCategory, message: string) {.inline.} =
  ##  ```c
  ##  void SDL_LogWarn(int category, const char *fmt, ...)
  ##  ```
  LogMessage category, LOG_PRIORITY_WARN, message

# --------------------------------------------------------------------------- #
# <SDL3/SDL_main.h>                                                           #
# --------------------------------------------------------------------------- #

# int SDL_AppEvent(const SDL_Event *event)
# int SDL_AppInit(int argc, char *argv[])
# int SDL_AppIterate(void)
# void SDL_AppQuit(void)
# int SDL_EnterAppMainCallbacks(int argc, char* argv[],
#     SDL_AppInit_func appinit, SDL_AppIterate_func appiter,
#     SDL_AppEvent_func appevent, SDL_AppQuit_func appquit)
# void SDL_GDKSuspendComplete(void)
# int SDL_RegisterApp(const char *name, Uint32 style, void *hInst)
# int SDL_RunApp(int argc, char* argv[], SDL_main_func mainFunction,
#     void *reserved)
# void SDL_SetMainReady(void)
# void SDL_UnregisterApp(void)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_messagebox.h>                                                     #
# --------------------------------------------------------------------------- #

when use_messagebox:

  proc ShowMessageBox*(messageboxdata: var MessageBoxData,
                       buttonid: var int): bool =
    ##  ```c
    ##  int SDL_ShowMessageBox(const SDL_MessageBoxData *messageboxdata,
    ##                         int *buttonid)
    ##  ```
    var but: cint = 0
    ensure_zero "SDL_ShowMessageBox":
      SDL_ShowMessageBox messageboxdata.addr, but.addr
    buttonid = but

  proc ShowSimpleMessageBox*(flags: MessageBoxFlags, title: string,
                             message: string, window: Window = nil): bool =
    ##  ```c
    ##  int SDL_ShowSimpleMessageBox(Uint32 flags, const char *title,
    ##                               const char *message, SDL_Window *window)
    ##  ```
    ensure_zero "SDL_ShowSimpleMessageBox":
      SDL_ShowSimpleMessageBox flags, title.cstring, message.cstring, window

# --------------------------------------------------------------------------- #
# <SDL3/SDL_mouse.h>                                                          #
# --------------------------------------------------------------------------- #

when use_mouse:

  proc CaptureMouse*(enabled: bool): bool =
    ##  ```c
    ##  int SDL_CaptureMouse(SDL_bool enabled)
    ##  ```
    ensure_zero "SDL_CaptureMouse":
      SDL_CaptureMouse enabled

  proc CreateColorCursor*(surface: SurfacePtr, hot_x: int,
                          hot_y: int): Cursor =
    ##  ```c
    ##  SDL_Cursor *SDL_CreateColorCursor(SDL_Surface *surface,
    ##                                    int hot_x, int hot_y)
    ##  ```
    ensure_not_nil "SDL_CreateColorCursor":
      SDL_CreateColorCursor surface, hot_x.cint, hot_y.cint

  proc CreateCursor*(data, mask: openArray[byte], w: int, h: int,
                     hot_x: int, hot_y: int): Cursor =
    ##  ```c
    ##  SDL_Cursor *SDL_CreateCursor(const Uint8 *data, const Uint8 *mask,
    ##                               int w, int h, int hot_x, int hot_y)
    ##  ```
    # XXX: check arrays size agains w/h
    ensure_not_nil "SDL_CreateCursor":
      when NimMajor >= 2:
        SDL_CreateCursor data[0].addr, mask[0].addr,
                                w.cint, h.cint, hot_x.cint, hot_y.cint
      else:
        SDL_CreateCursor data[0].unsafeAddr, mask[0].unsafeAddr,
                                w.cint, h.cint, hot_x.cint, hot_y.cint

  proc CreateSystemCursor*(id: SystemCursor): Cursor =
    ##  Create a system cursor.
    ##
    ##  ```c
    ##  SDL_Cursor *SDL_CreateSystemCursor(SDL_SystemCursor id)
    ##  ```
    ensure_not_nil "SDL_CreateSystemCursor":
      SDL_CreateSystemCursor id

  proc CursorVisible*(): bool =
    ##  ```c
    ##  SDL_bool SDL_CursorVisible(void)
    ##  ```
    SDL_CursorVisible()

  proc DestroyCursor*(cursor: Cursor) {.inline.} =
    ##  ```c
    ##  void SDL_DestroyCursor(SDL_Cursor *cursor)
    ##  ```
    SDL_DestroyCursor cursor

  proc GetCursor*(): Cursor =
    ##  ```c
    ##  SDL_Cursor *SDL_GetCursor(void)
    ##  ```
    SDL_GetCursor()

  # SDL_Cursor *SDL_GetDefaultCursor(void)

  proc GetGlobalMouseState*(): tuple[x, y: float, state: uint32] =
    ##  ```c
    ##  Uint32 SDL_GetGlobalMouseState(float *x, float *y)
    ##  ```
    var outx, outy: cfloat = 0.0
    let state = SDL_GetGlobalMouseState(outx.addr, outy.addr)
    (outx.float, outy.float, state)

  proc GetMouseFocus*(): Window =
    ##  ```c
    ##  SDL_Window * SDL_GetMouseFocus(void)
    ##  ```
    SDL_GetMouseFocus()

  proc GetMouseState*(): tuple[x, y: float, state: uint32] =
    ##  ```c
    ##  Uint32 SDL_GetMouseState(float *x, float *y)
    ##  ```
    var outx, outy: cfloat = 0.0
    let state = SDL_GetMouseState(outx.addr, outy.addr)
    (outx.float, outy.float, state)

  proc GetRelativeMouseMode*(): bool =
    ##  ```c
    ##  SDL_bool SDL_GetRelativeMouseMode(void)
    ##  ```
    SDL_GetRelativeMouseMode()

  # Uint32 SDL_GetRelativeMouseState(float *x, float *y)

  proc HasMouse*(): bool {.inline.} =
    ##  Return whether a mouse is currently connected.
    ##
    ##  See: `SDL_HasMouse`.
    SDL_HasMouse()

  proc HideCursor*(): bool {.discardable, inline.} =
    ##  Hide the cursor.
    ##
    ##  ```c
    ##  int SDL_HideCursor(void)
    ##  ```
    SDL_HideCursor() != 0

  proc SetCursor*(cursor: Cursor): bool =
    ##  ```c
    ##  int SDL_SetCursor(SDL_Cursor *cursor)
    ##  ```
    ensure_zero "SDL_SetCursor":
      SDL_SetCursor cursor

  proc SetRelativeMouseMode*(enabled: bool): bool =
    ##  Set relative mouse mode.
    ##
    ##  ```c
    ##  int SDL_SetRelativeMouseMode(SDL_bool enabled)
    ##  ```
    ensure_zero "SDL_SetRelativeMouseMode":
      SDL_SetRelativeMouseMode enabled

  proc ShowCursor*(): bool {.discardable, inline.} =
    ##  ```c
    ##  int SDL_ShowCursor(void)
    ##  ```
    SDL_ShowCursor() != 0

  # int SDL_WarpMouseGlobal(float x, float y)
  # void SDL_WarpMouseInWindow(SDL_Window *window, float x, float y)

# ------------------------------------------------------------------------- #
# <SDL3/SDL_pen.h>                                                          #
# ------------------------------------------------------------------------- #

# Uint32 SDL_GetPenCapabilities(SDL_PenID instance_id, SDL_PenCapabilityInfo *capabilities)
# SDL_PenID SDL_GetPenFromGUID(SDL_GUID guid)
# SDL_GUID SDL_GetPenGUID(SDL_PenID instance_id)
# const char * SDL_GetPenName(SDL_PenID instance_id)
# SDL_PenID * SDL_GetPens(int *count)
# Uint32 SDL_GetPenStatus(SDL_PenID instance_id, float *x, float *y, float *axes, size_t num_axes)
# SDL_PenSubtype SDL_GetPenType(SDL_PenID instance_id)
# SDL_bool SDL_PenConnected(SDL_PenID instance_id)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_pixels.h>                                                         #
# --------------------------------------------------------------------------- #

# SDL_Palette *SDL_CreatePalette(int ncolors)
# SDL_PixelFormat * SDL_CreatePixelFormat(Uint32 pixel_format)
# void SDL_DestroyPalette(SDL_Palette *palette)
# void SDL_DestroyPixelFormat(SDL_PixelFormat *format)
# SDL_bool SDL_GetMasksForPixelFormatEnum(Uint32 format, int *bpp,
#     Uint32 *Rmask, Uint32 *Gmask, Uint32 *Bmask, Uint32 *Amask)

proc GetPixelFormatEnumForMasks*(bpp: int, rmask: uint32, gmask: uint32,
                                 bmask: uint32,
                                 amask: uint32): PixelFormatEnum {.inline.} =
  ##  Convert bits/pixel value and RGBA masks to pixel format.
  ##
  ##  Return `PIXELFORMAT_UNKNOWN` if the conversion failed.
  ##
  ##  ```c
  ##  Uint32 SDL_GetPixelFormatEnumForMasks(int bpp, Uint32 Rmask,
  ##                                        Uint32 Gmask, Uint32 Bmask,
  ##                                        Uint32 Amask)
  ##  ```
  # XXX: TODO: return pixelformat enum and not uint32.
  SDL_GetPixelFormatEnumForMasks bpp.cint, rmask, gmask, bmask, amask

# const char* SDL_GetPixelFormatName(Uint32 format)
# void SDL_GetRGB(Uint32 pixel, const SDL_PixelFormat *format, Uint8 *r,
#     Uint8 *g, Uint8 *b)
# void SDL_GetRGBA(Uint32 pixel, const SDL_PixelFormat *format, Uint8 *r,
#     Uint8 *g, Uint8 *b, Uint8 *a)

proc MapRGB*(format: PixelFormat, r: byte, g: byte, b: byte): uint32 =
  ##  ```c
  ##  Uint32 SDL_MapRGB(const SDL_PixelFormat *format,
  ##                    Uint8 r, Uint8 g, Uint8 b)
  ##  ```
  when NimMajor < 2:
    var format = format
  SDL_MapRGB format.addr, r, g, b

proc MapRGBA*(format: PixelFormat, r: byte, g: byte, b: byte,
              a: byte): uint32 =
  ##  ```c
  ##  Uint32 SDL_MapRGBA(const SDL_PixelFormat *format,
  ##                     Uint8 r, Uint8 g, Uint8 b, Uint8 a)
  ##  ```
  when NimMajor < 2:
    var format = format
  SDL_MapRGBA format.addr, r, g, b, a

# int SDL_SetPaletteColors(SDL_Palette *palette, const SDL_Color *colors,
#     int firstcolor, int ncolors)
# int SDL_SetPixelFormatPalette(SDL_PixelFormat *format, SDL_Palette *palette)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_properties.h>                                                     #
# --------------------------------------------------------------------------- #

# int SDL_ClearProperty(SDL_PropertiesID props, const char *name)
# SDL_PropertiesID SDL_CreateProperties(void)
# void SDL_DestroyProperties(SDL_PropertiesID props)
# int SDL_EnumerateProperties(SDL_PropertiesID props, SDL_EnumeratePropertiesCallback callback, void *userdata)
# SDL_bool SDL_GetBooleanProperty(SDL_PropertiesID props, const char *name, SDL_bool default_value)
# float SDL_GetFloatProperty(SDL_PropertiesID props, const char *name, float default_value)
# SDL_PropertiesID SDL_GetGlobalProperties(void)
# Sint64 SDL_GetNumberProperty(SDL_PropertiesID props, const char *name, Sint64 default_value)
# void * SDL_GetProperty(SDL_PropertiesID props, const char *name, void *default_value)
# SDL_PropertyType SDL_GetPropertyType(SDL_PropertiesID props, const char *name)
# const char * SDL_GetStringProperty(SDL_PropertiesID props, const char *name, const char *default_value)
# int SDL_LockProperties(SDL_PropertiesID props)
# int SDL_SetBooleanProperty(SDL_PropertiesID props, const char *name, SDL_bool value)
# int SDL_SetFloatProperty(SDL_PropertiesID props, const char *name, float value)
# int SDL_SetNumberProperty(SDL_PropertiesID props, const char *name, Sint64 value)
# int SetProperty(SDL_PropertiesID props, const char *name, void *value)
# int SDL_SetPropertyWithCleanup(SDL_PropertiesID props, const char *name,
#     void *value, void (*cleanup)(void *userdata, void *value),
#     void *userdata)
# int SDL_SetStringProperty(SDL_PropertiesID props, const char *name, const char *value)
# void SDL_UnlockProperties(SDL_PropertiesID props)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_rect.h>                                                           #
# --------------------------------------------------------------------------- #

# SDL_bool SDL_GetRectAndLineIntersection(const SDL_Rect *rect, int *X1,
#     int *Y1, int *X2, int *Y2)
# SDL_bool SDL_GetRectAndLineIntersectionFloat(const SDL_FRect *rect,
#     float *X1, float *Y1, float *X2, float *Y2)
# SDL_bool SDL_GetRectEnclosingPoints(const SDL_Point *points, int count,
#     const SDL_Rect *clip, SDL_Rect *result)
# SDL_bool SDL_GetRectEnclosingPointsFloat(const SDL_FPoint *points,
#     int count, const SDL_FRect *clip, SDL_FRect *result)
# SDL_bool SDL_GetRectIntersection(const SDL_Rect *A, const SDL_Rect *B,
#     SDL_Rect *result)
# SDL_bool SDL_GetRectIntersectionFloat(const SDL_FRect *A,
#     const SDL_FRect *B, SDL_FRect *result)
# int SDL_GetRectUnion(const SDL_Rect *A, const SDL_Rect *B, SDL_Rect *result)
# int SDL_GetRectUnionFloat(const SDL_FRect *A, const SDL_FRect *B,
#     SDL_FRect *result)
# SDL_bool SDL_HasRectIntersection(const SDL_Rect *A, const SDL_Rect *B)
# SDL_bool SDL_HasRectIntersectionFloat(const SDL_FRect *A, const SDL_FRect *B)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_render.h>                                                         #
# --------------------------------------------------------------------------- #

# int SDL_ConvertEventToRenderCoordinates(SDL_Renderer *renderer,
#     SDL_Event *event)

proc CreateRenderer*(window: Window, name: string,
                     flags = RendererFlags 0): Renderer =
  ##  ```c
  ##  SDL_Renderer *SDL_CreateRenderer(SDL_Window *window, const char *name,
  ##                                   Uint32 flags)
  ##  ```
  ensure_not_nil "SDL_CreateRenderer":
    SDL_CreateRenderer window, name.cstring, flags

proc CreateRenderer*(window: Window,
                     flags = RendererFlags 0): Renderer =
  ##  ```c
  ##  SDL_Renderer *SDL_CreateRenderer(SDL_Window *window, const char *name,
  ##                                   Uint32 flags)
  ##  ```
  ensure_not_nil "SDL_CreateRenderer":
    SDL_CreateRenderer window, nil, flags

proc CreateRendererWithProperties*(props: PropertiesID): Renderer =
  ##  Create a 2D rendering context for a window, with the specified
  ##  properties.
  ##
  ##  `SDL_CreateRendererWithProperties`
  ensure_not_nil "SDL_CreateRendererWithProperties":
    SDL_CreateRendererWithProperties props

# SDL_Renderer *SDL_CreateSoftwareRenderer(SDL_Surface *surface)

proc CreateTexture*(renderer: Renderer, format: PixelFormatEnum,
                    access: TextureAccess, width: int, height: int): Texture =
  ##  Create a texture for a rendering context.
  ##
  ##  `SDL_CreateTexture`
  ensure_not_nil "SDL_CreateTexture":
    SDL_CreateTexture renderer, format, access, width.cint, height.cint

proc CreateTextureFromSurface*(renderer: Renderer,
                               surface: SurfacePtr): Texture =
  ##  Create a texture from an existing surface.
  ##
  ##  `SDL_CreateTextureFromSurface`
  ensure_not_nil "SDL_CreateTextureFromSurface":
    SDL_CreateTextureFromSurface renderer, surface

proc CreateTextureWithProperties*(renderer: Renderer,
                                  props: PropertiesID): Texture =
  ##  Create a texture for a rendering context with the specified properties.
  ##
  ##  `SDL_CreateTextureWithProperties`
  ensure_not_nil "SDL_CreateTextureWithProperties":
    SDL_CreateTextureWithProperties renderer, props

proc CreateWindowAndRenderer*(width: int, height: int,
                              window_flags: WindowFlags = WindowFlags 0): tuple[window: Window, renderer: Renderer] =
  ##  Create a window and default renderer.
  ##
  ##  `SDL_CreateWindowAndRenderer`
  var out_window    : Window = nil
  var out_renderer  : Renderer = nil
  if not SDL_CreateWindowAndRenderer(width.cint, height.cint,
                                             window_flags, out_window.addr,
                                             out_renderer.addr) != 0:
    echo "SDL_CreateWindowAndRenderer failed: ", GetError()   # XXX: echo
    # XXX: TODO: check whether this function writes anythin on error.
    if out_renderer != nil:
      SDL_DestroyRenderer out_renderer
    if out_window != nil:
      SDL_DestroyWindow out_window
    return (nil, nil)
  (out_window, out_renderer)

proc DestroyRenderer*(renderer: Renderer) {.inline.} =
  ##  Destroy the window rendering context and free all textures.
  ##
  ##  `SDL_DestroyRenderer`
  SDL_DestroyRenderer renderer

proc DestroyTexture*(texture: Texture) {.inline.} =
  ##  Destroy the texture.
  ##
  ##  `SDL_DestroyTexture`
  SDL_DestroyTexture texture

# int SDL_GL_BindTexture(SDL_Texture *texture, float *texw, float *texh)
# int SDL_GL_UnbindTexture(SDL_Texture *texture)
# int SDL_GetCurrentRenderOutputSize(SDL_Renderer *renderer, int *w, int *h)
# int SDL_GetNumRenderDrivers(void)
# int SDL_GetRenderClipRect(SDL_Renderer *renderer, SDL_Rect *rect)
# int SDL_GetRenderDrawBlendMode(SDL_Renderer *renderer,
#     SDL_BlendMode *blendMode)
# int SDL_GetRenderDrawColor(SDL_Renderer *renderer, Uint8 *r, Uint8 *g,
#     Uint8 *b, Uint8 *a)
# const char *SDL_GetRenderDriver(int index)
# SDL_Renderer * SDL_GetRendererFromTexture(SDL_Texture *texture);
# int SDL_GetRenderLogicalPresentation(SDL_Renderer *renderer, int *w, int *h,
#     SDL_RendererLogicalPresentation *mode, SDL_ScaleMode *scale_mode)
# void *SDL_GetRenderMetalCommandEncoder(SDL_Renderer *renderer)
# void *SDL_GetRenderMetalLayer(SDL_Renderer *renderer)
# int SDL_GetRenderOutputSize(SDL_Renderer *renderer, int *w, int *h)
# SDL_PropertiesID SDL_GetRendererProperties(SDL_Renderer *renderer)
# int SDL_GetRenderScale(SDL_Renderer *renderer, float *scaleX, float *scaleY)
# SDL_Texture *SDL_GetRenderTarget(SDL_Renderer *renderer)
# int SDL_GetRenderVSync(SDL_Renderer *renderer, int *vsync)
# int SDL_GetRenderViewport(SDL_Renderer *renderer, SDL_Rect *rect)
# SDL_Window *SDL_GetRenderWindow(SDL_Renderer *renderer)

proc GetRenderer*(window: Window): Renderer =
  ##  ```c
  ##  SDL_Renderer *SDL_GetRenderer(SDL_Window *window)
  ##  ```
  ensure_not_nil "SDL_GetRenderer":
    SDL_GetRenderer window

# int SDL_GetRendererInfo(SDL_Renderer *renderer, SDL_RendererInfo *info)
# int SDL_GetTextureAlphaMod(SDL_Texture *texture, Uint8 *alpha)
# int SDL_GetTextureBlendMode(SDL_Texture *texture, SDL_BlendMode *blendMode)
# int SDL_GetTextureColorMod(SDL_Texture *texture,
#     Uint8 *r, Uint8 *g, Uint8 *b)
# SDL_PropertiesID SDL_GetTextureProperties(SDL_Texture *texture)
# int SDL_GetTextureScaleMode(SDL_Texture *texture, SDL_ScaleMode *scaleMode)
# int SDL_LockTexture(SDL_Texture *texture, const SDL_Rect *rect,
#     void **pixels, int *pitch)
# int SDL_LockTextureToSurface(SDL_Texture *texture, const SDL_Rect *rect,
#     SDL_Surface **surface)

proc QueryTexture*(texture: Texture, format: var PixelFormatEnum,
                   access: var int, w: var int, h: var int): bool =
  ##  ```c
  ##  int SDL_QueryTexture(SDL_Texture *texture, Uint32 *format, int *access,
  ##                       int *w, int *h)
  ##  ```
  var outaccess, outw, outh: cint
  if SDL_QueryTexture(texture, format.addr, outaccess.addr, outw.addr,
                      outh.addr) != 0:
    log_error "SDL_QueryTexture failed: ", $SDL_GetError()
    return false
  access = outaccess
  w = outw
  h = outh
  true

proc RenderClear*(renderer: Renderer): bool =
  ##  ```c
  ##  int SDL_RenderClear(SDL_Renderer *renderer)
  ##  ```
  ensure_zero "SDL_RenderClear":
    SDL_RenderClear renderer

# SDL_bool SDL_RenderClipEnabled(SDL_Renderer *renderer)

proc RenderCoordinatesFromWindow*(renderer: Renderer, window_x: float,
                                  window_y: float, x: var float,
                                  y: var float): bool =
  ##  Get a point in render coordinates when given a point in window coordinates.
  ##
  ##  ```c
  ##  int SDL_RenderCoordinatesFromWindow(SDL_Renderer *renderer,
  ##                                      float window_x, float window_y,
  ##                                      float *x, float *y)
  ##  ```
  var outx, outy: cfloat = 0
  ensure_zero "SDL_RenderCoordinatesFromWindow":
    SDL_RenderCoordinatesFromWindow renderer, window_x.cfloat, window_y.cfloat,
                                    outx.addr, outy.addr
  x = outx
  y = outy

# int SDL_RenderCoordinatesToWindow(SDL_Renderer *renderer, float x, float y,
#     float *window_x, float *window_y)

proc RenderFillRect*(renderer: Renderer): bool =
  ##  ```c
  ##  int SDL_RenderFillRect(SDL_Renderer *renderer, const SDL_FRect *rect)
  ##  ```
  ensure_zero "SDL_RenderFillRect":
    SDL_RenderFillRect renderer, nil

proc RenderFillRect*(renderer: Renderer, rect: FRect): bool =
  ##  ```c
  ##  int SDL_RenderFillRect(SDL_Renderer *renderer, const SDL_FRect *rect)
  ##  ```
  when NimMajor < 2:
    var rect = rect
  ensure_zero "SDL_RenderFillRect":
    SDL_RenderFillRect renderer, rect.addr

proc RenderFillRect*(renderer: Renderer, x: float, y: float,
                     w: float, h: float): bool {.inline.} =
  ##  ```c
  ##  int SDL_RenderFillRect(SDL_Renderer *renderer, const SDL_FRect *rect)
  ##  ```
  RenderFillRect renderer, FRect.init(x, y, w, h)

# int SDL_RenderFillRects(SDL_Renderer *renderer, const SDL_FRect *rects,
#     int count)
# int SDL_RenderFlush(SDL_Renderer *renderer)

proc RenderGeometry*(renderer: Renderer, texture: Texture,
                     vertices: openArray[Vertex]): bool =
  ##  ```c
  ##  int SDL_RenderGeometry(SDL_Renderer *renderer, SDL_Texture *texture,
  ##                         const SDL_Vertex *vertices, int num_vertices,
  ##                         const int *indices, int num_indices)
  ##  ```
  ensure_zero "SDL_RenderGeometry":
    when NimMajor >= 2:
      SDL_RenderGeometry renderer, texture, vertices[0].addr,
                         vertices.len.cint, nil, 0
    else:
      SDL_RenderGeometry renderer, texture, vertices[0].unsafeAddr,
                         vertices.len.cint, nil, 0

proc RenderGeometry*(renderer: Renderer,
                     vertices: openArray[Vertex]): bool {.inline.} =
  ##  ```c
  ##  int SDL_RenderGeometry(SDL_Renderer *renderer, SDL_Texture *texture,
  ##                         const SDL_Vertex *vertices, int num_vertices,
  ##                         const int *indices, int num_indices)
  ##  ```
  RenderGeometry renderer, nil, vertices

proc RenderGeometry*(renderer: Renderer, texture: Texture,
                     vertices: openArray[Vertex],
                     indices: openArray[cint]): bool =
  ##  ```c
  ##  int SDL_RenderGeometry(SDL_Renderer *renderer, SDL_Texture *texture,
  ##                         const SDL_Vertex *vertices, int num_vertices,
  ##                         const int *indices, int num_indices)
  ##  ```
  ensure_zero "SDL_RenderGeometry":
    when NimMajor >= 2:
      SDL_RenderGeometry renderer, texture,
                         vertices[0].addr, vertices.len.cint,
                         indices[0].addr, indices.len.cint
    else:
      SDL_RenderGeometry renderer, texture,
                         vertices[0].unsafeAddr, vertices.len.cint,
                         indices[0].unsafeAddr, indices.len.cint

proc RenderGeometry*(renderer: Renderer, vertices: openArray[Vertex],
                     indices: openArray[cint]): bool {.inline.} =
  ##  ```c
  ##  int SDL_RenderGeometry(SDL_Renderer *renderer, SDL_Texture *texture,
  ##                         const SDL_Vertex *vertices, int num_vertices,
  ##                         const int *indices, int num_indices)
  ##  ```
  RenderGeometry renderer, nil, vertices, indices

# int SDL_RenderGeometryRaw(SDL_Renderer *renderer, SDL_Texture *texture,
#     const float *xy, int xy_stride, const SDL_Color *color, int color_stride,
#     const float *uv, int uv_stride, int num_vertices, const void *indices,
#     int num_indices, int size_indices)

proc RenderLine*(renderer: Renderer, x1: float, y1: float,
                 x2: float, y2: float): bool =
  ##  ```c
  ##  int SDL_RenderLine(SDL_Renderer *renderer, float x1, float y1,
  ##                     float x2, float y2)
  ##  ```
  ensure_zero "SDL_RenderLine":
    SDL_RenderLine renderer, x1.cfloat, y1.cfloat, x2.cfloat, y2.cfloat

# int SDL_RenderLines(SDL_Renderer *renderer, const SDL_FPoint *points,
#     int count)

proc RenderPoint*(renderer: Renderer, x: float, y: float): bool =
  ##  ```c
  ##  int SDL_RenderPoint(SDL_Renderer *renderer, float x, float y)
  ##  ```
  ensure_zero "SDL_RenderPoint":
    SDL_RenderPoint renderer, x.cfloat, y.cfloat

proc RenderPoint*(renderer: Renderer, x, y: int): bool {.inline.} =
  RenderPoint renderer, x.float, y.float

# int SDL_RenderPoints(SDL_Renderer *renderer, const SDL_FPoint *points,
#     int count)

proc RenderPresent*(renderer: Renderer) {.inline.} =
  ##  ```c
  ##  int SDL_RenderPresent(SDL_Renderer *renderer)
  ##  ```
  SDL_RenderPresent renderer

# int SDL_RenderReadPixels(SDL_Renderer *renderer, const SDL_Rect *rect,
#     Uint32 format, void *pixels, int pitch)

proc RenderRect*(renderer: Renderer, rect: FRect): bool =
  ##  ```c
  ##  int SDL_RenderRect(SDL_Renderer *renderer, const SDL_FRect *rect)
  ##  ```
  when NimMajor < 2:
    var rect = rect
  ensure_zero "SDL_RenderRect":
    SDL_RenderRect renderer, rect.addr

proc RenderRect*(renderer: Renderer, x, y: float,
                  w, h: float): bool {.inline.} =
  ##  ```c
  ##  int SDL_RenderRect(SDL_Renderer *renderer, const SDL_FRect *rect)
  ##  ```
  RenderRect renderer, FRect.init(x, y, w, h)

# int SDL_RenderRects(SDL_Renderer *renderer, const SDL_FRect *rects,
#     int count)

proc RenderTexture*(renderer: Renderer, texture: Texture): bool =
  ##  ```c
  ##  int SDL_RenderTexture(SDL_Renderer *renderer, SDL_Texture *texture,
  ##                        const SDL_FRect *srcrect, const SDL_FRect *dstrect)
  ##  ```
  ensure_zero "SDL_RenderTexture":
    SDL_RenderTexture renderer, texture, nil, nil

proc RenderTexture*(renderer: Renderer, texture: Texture, dst: FRect): bool =
  ##  ```c
  ##  int SDL_RenderTexture(SDL_Renderer *renderer, SDL_Texture *texture,
  ##                        const SDL_FRect *srcrect, const SDL_FRect *dstrect)
  ##  ```
  when NimMajor < 2:
    var dst = dst
  ensure_zero "SDL_RenderTexture":
    SDL_RenderTexture renderer, texture, nil, dst.addr

# XXX: add similar with floats?
proc RenderTexture*(renderer: Renderer, texture: Texture, x: int, y: int,
                    w: int, h: int): bool =
  ##  ```c
  ##  int SDL_RenderTexture(SDL_Renderer *renderer, SDL_Texture *texture,
  ##                        const SDL_FRect *srcrect, const SDL_FRect *dstrect)
  ##  ```
  var dst: FRect = FRect(x: x.cfloat, y: y.cfloat, w: w.cfloat, h: h.cfloat)
  ensure_zero "SDL_RenderTexture":
    SDL_RenderTexture renderer, texture, nil, dst.addr

proc RenderTexture*(renderer: Renderer, texture: Texture, srcrect: FRect,
                    dstrect: FRect): bool =
  ##  ```c
  ##  int SDL_RenderTexture(SDL_Renderer *renderer, SDL_Texture *texture,
  ##                        const SDL_FRect *srcrect, const SDL_FRect *dstrect)
  ##  ```
  when NimMajor < 2:
    var srcrect = srcrect
    var dstrect = dstrect
  ensure_zero "SDL_RenderTexture":
    SDL_RenderTexture renderer, texture, srcrect.addr, dstrect.addr

proc RenderTextureRotated*(renderer: Renderer, texture: Texture,
                           srcrect: FRect, dstrect: FRect, angle: float,
                           center: FPoint, flip: FlipMode): bool =
  ##  See: `SDL_RenderTextureRotated`.
  when NimMajor < 2:
    var srcrect = srcrect
    var dstrect = dstrect
    var center = center
  ensure_zero "SDL_RenderTextureRotated":
    SDL_RenderTextureRotated renderer, texture, srcrect.addr, dstrect.addr,
                             angle.cdouble, center.addr, flip

proc SetRenderClipRect*(renderer: Renderer, rect: Rect): bool =
  ##  ```c
  ##  int SDL_SetRenderClipRect(SDL_Renderer *renderer, const SDL_Rect *rect)
  ##  ```
  when NimMajor < 2:
    var rect = rect
  ensure_zero "SDL_SetRenderClipRect":
    SDL_SetRenderClipRect renderer, rect.addr

proc SetRenderDrawBlendMode*(renderer: Renderer, blend_mode: BlendMode): bool =
  ##  ```c
  ##  int SDL_SetRenderDrawBlendMode(SDL_Renderer *renderer,
  ##                                 SDL_BlendMode blendMode)
  ##  ```
  ensure_zero "SDL_SetRenderDrawBlendMode":
    SDL_SetRenderDrawBlendMode renderer, blend_mode

proc SetRenderDrawColor*(renderer: Renderer, r: byte, g: byte, b: byte,
                         a: byte = 0xff): bool =
  ##  Set the color used for drawing operations (clear, line, rect, etc.).
  ##
  ##  ```c
  ##  int SDL_SetRenderDrawColor(SDL_Renderer *renderer, Uint8 r, Uint8 g,
  ##                             Uint8 b, Uint8 a)
  ##  ```
  ensure_zero "SDL_SetRenderDrawColor":
    SDL_SetRenderDrawColor renderer, r, g, b, a

# int SDL_SetRenderLogicalPresentation(SDL_Renderer *renderer, int w, int h,
#     SDL_RendererLogicalPresentation mode, SDL_ScaleMode scale_mode)

proc SetRenderScale*(renderer: Renderer, scale_x: float,
                     scale_y: float): bool =
  ##  ```c
  ##  int SDL_SetRenderScale(SDL_Renderer *renderer,
  ##                         float scaleX, float scaleY)
  ##  ```
  ensure_zero "SDL_SetRenderScale":
    SDL_SetRenderScale renderer, scale_x.cfloat, scale_y.cfloat

proc SetRenderTarget*(renderer: Renderer, texture: Texture = nil): bool =
  ##  ```c
  ##  int SDL_SetRenderTarget(SDL_Renderer *renderer, SDL_Texture *texture)
  ##  ```
  ensure_zero "SDL_SetRenderTarget":
    SDL_SetRenderTarget renderer, texture

proc SetRenderVSync*(renderer: Renderer, vsync: bool): bool =
  ##  ```c
  ##  int SDL_SetRenderVSync(SDL_Renderer *renderer, int vsync)
  ##  ```
  ensure_zero "SDL_SetRenderVSync":
    SDL_SetRenderVSync renderer, vsync.cint

# int SDL_SetRenderViewport(SDL_Renderer *renderer, const SDL_Rect *rect)

proc SetTextureAlphaMod*(texture: Texture, alpha: byte): bool =
  ##  ```c
  ##  int SDL_SetTextureAlphaMod(SDL_Texture *texture, Uint8 alpha)
  ##  ```
  ensure_zero "SDL_SetTextureAlphaMod":
    SDL_SetTextureAlphaMod texture, alpha

proc SetTextureBlendMode*(texture: Texture, blend_mode: BlendMode): bool =
  ##  ```c
  ##  int SDL_SetTextureBlendMode(SDL_Texture *texture,
  ##                              SDL_BlendMode blendMode)
  ##  ```
  ensure_zero "SDL_SetTextureBlendMode":
    SDL_SetTextureBlendMode texture, blend_mode

proc SetTextureColorMod*(texture: Texture, r: byte, g: byte, b: byte): bool =
  ##  ```c
  ##  int SDL_SetTextureColorMod(SDL_Texture *texture,
  ##                             Uint8 r, Uint8 g, Uint8 b)
  ##  ```
  ensure_zero "SDL_SetTextureColorMod":
    SDL_SetTextureColorMod texture, r, g, b

proc SetTextureScaleMode*(texture: Texture, scale_mode: ScaleMode): bool =
  ##  ```c
  ##  int SDL_SetTextureScaleMode(SDL_Texture *texture, SDL_ScaleMode scaleMode)
  ##  ```
  ensure_zero "SDL_SetTextureScaleMode":
    SDL_SetTextureScaleMode texture, scale_mode

# void SDL_UnlockTexture(SDL_Texture *texture)
# int SDL_UpdateNVTexture(SDL_Texture *texture, const SDL_Rect *rect,
#     const Uint8 *Yplane, int Ypitch, const Uint8 *UVplane, int UVpitch)

proc UpdateTexture*(texture: Texture, rect: var Rect, pixels: pointer,
                    pitch: int): bool =
  ##  ```c
  ##  int SDL_UpdateTexture(SDL_Texture *texture, const SDL_Rect *rect,
  ##                        const void *pixels, int pitch)
  ##  ```
  ensure_zero "SDL_UpdateTexture":
    SDL_UpdateTexture texture, rect.addr, pixels, pitch.cint

proc UpdateTexture*(texture: Texture, pixels: pointer, pitch: int): bool =
  ##  ```c
  ##  int SDL_UpdateTexture(SDL_Texture *texture, const SDL_Rect *rect,
  ##                        const void *pixels, int pitch)
  ##  ```
  ensure_zero "SDL_UpdateTexture":
    SDL_UpdateTexture texture, nil, pixels, pitch.cint

# int SDL_UpdateYUVTexture(SDL_Texture *texture, const SDL_Rect *rect,
#     const Uint8 *Yplane, int Ypitch, const Uint8 *Uplane, int Upitch,
#     const Uint8 *Vplane, int Vpitch)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_rwops.h>                                                          #
# --------------------------------------------------------------------------- #

# XXX: not needed.
#proc rw_from_file*(file, mode: string): RWopsPtr =
#  ##  ```c
#  ##  SDL_RWops * SDL_RWFromFile(const char *file, const char *mode)
#  ##  ```
#  ensure_not_nil "SDL_RWFromFile":
#    SDL_RWFromFile file.cstring, mode.cstring

# XXX: obsolete.
# proc save_bmp*(surface: SurfacePtr, file: string): bool =
#   ##  ```c
#   ##  ```
#   ensure_zero "SDL_SaveBMP_RW":
#     SDL_SaveBMP_RW surface, context.SDL_RWFromFile(file, "wb"), 1

# --------------------------------------------------------------------------- #
# <SDL3/SDL_sensor.h>                                                         #
# --------------------------------------------------------------------------- #

# void SDL_CloseSensor(SDL_Sensor *sensor)
# int SDL_GetSensorData(SDL_Sensor *sensor, float *data, int num_values)
# SDL_Sensor *SDL_GetSensorFromInstanceID(SDL_SensorID instance_id)
# SDL_SensorID SDL_GetSensorInstanceID(SDL_Sensor *sensor)
# const char *SDL_GetSensorInstanceName(SDL_SensorID instance_id)
# int SDL_GetSensorInstanceNonPortableType(SDL_SensorID instance_id)
# SDL_SensorType SDL_GetSensorInstanceType(SDL_SensorID instance_id)
# const char *SDL_GetSensorName(SDL_Sensor *sensor)
# int SDL_GetSensorNonPortableType(SDL_Sensor *sensor)
# SDL_SensorType SDL_GetSensorType(SDL_Sensor *sensor)
# SDL_SensorID *SDL_GetSensors(int *count)
# SDL_Sensor *SDL_OpenSensor(SDL_SensorID instance_id)
# void SDL_UpdateSensors(void)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_surface.h>                                                        #
# --------------------------------------------------------------------------- #

# int SDL_BlitSurface (SDL_Surface *src, const SDL_Rect *srcrect,
#     SDL_Surface *dst, SDL_Rect *dstrect)
# int SDL_BlitSurfaceScaled (SDL_Surface *src, const SDL_Rect *srcrect,
#     SDL_Surface *dst, SDL_Rect *dstrect, SDL_ScaleMode scaleMode)
# int SDL_BlitSurfaceUnchecked (SDL_Surface *src, const SDL_Rect *srcrect,
#     SDL_Surface *dst, const SDL_Rect *dstrect)
# int SDL_BlitSurfaceUncheckedScaled (SDL_Surface *src, const SDL_Rect *srcrect,
#     SDL_Surface *dst, const SDL_Rect *dstrect, SDL_ScaleMode scaleMode)
# int SDL_ConvertPixels(int width, int height, Uint32 src_format,
#     const void *src, int src_pitch, Uint32 dst_format, void *dst,
#     int dst_pitch)
# SDL_Surface *SDL_ConvertSurface(SDL_Surface *surface,
#     const SDL_PixelFormat *format)
# SDL_Surface *SDL_ConvertSurfaceFormat(SDL_Surface *surface, Uint32 pixel_format)
# SDL_Surface *SDL_CreateSurface (int width, int height, Uint32 format)

proc CreateSurfaceFrom*(pixels: pointer, width, height: int, pitch: int,
                        format: PixelFormatEnum): SurfacePtr =
  ##  ```c
  ##  SDL_Surface *SDL_CreateSurfaceFrom(void *pixels, int width, int height,
  ##                                    int pitch, Uint32 format)
  ##  ```
  ensure_not_nil "SDL_CreateSurfaceFrom":
    SDL_CreateSurfaceFrom pixels, width.cint, height.cint, pitch.cint, format

proc DestroySurface*(surface: SurfacePtr) {.inline.} =
  ##  ```c
  ##  void SDL_DestroySurface(SDL_Surface *surface)
  ##  ```
  SDL_DestroySurface surface

# SDL_Surface *SDL_DuplicateSurface(SDL_Surface *surface)
# int SDL_FillSurfaceRect (SDL_Surface *dst, const SDL_Rect *rect, Uint32 color)
# int SDL_FillSurfaceRects (SDL_Surface *dst, const SDL_Rect *rects,
#     int count, Uint32 color)
# extern DECLSPEC int SDLCALL SDL_FlipSurface(SDL_Surface *surface, SDL_FlipMode flip);
# int SDL_GetSurfaceAlphaMod(SDL_Surface *surface, Uint8 *alpha)
# int SDL_GetSurfaceBlendMode(SDL_Surface *surface, SDL_BlendMode *blendMode)
# int SDL_GetSurfaceClipRect(SDL_Surface *surface, SDL_Rect *rect)
# int SDL_GetSurfaceColorKey(SDL_Surface *surface, Uint32 *key)
# int SDL_GetSurfaceColorMod(SDL_Surface *surface, Uint8 *r, Uint8 *g, Uint8 *b)
# SDL_PropertiesID SDL_GetSurfaceProperties(SDL_Surface *surface)
# SDL_YUV_CONVERSION_MODE SDL_GetYUVConversionMode(void)
# SDL_YUV_CONVERSION_MODE SDL_GetYUVConversionModeForResolution(int width, int height)

proc LoadBMP*(file: string): SurfacePtr =
  ##  ```c
  ##  SDL_Surface *SDL_LoadBMP(const char *file)
  ##  ```
  ensure_not_nil "SDL_LoadBMP":
    SDL_LoadBMP file

#proc load_bmp_rw*(src: RWopsPtr, freesrc: bool): SurfacePtr =
#  ##  ```c
#  ##  SDL_Surface *SDL_LoadBMP_RW(SDL_RWops *src, SDL_bool freesrc)
#  ##  ```
#  ensure_not_nil "SDL_LoadBMP_RW":
#    SDL_LoadBMP_RW src, freesrc.cint

#proc load_bmp_rw_unchecked(src: RWopsPtr, freesrc: bool): SurfacePtr {.inline.} =
#  ##  Unchecked version. Used by `load_bmp` not to generate multiple errors
#  ##  such as:
#  ##    - SDL_RWFromFile failed: Couldn't open sail.bmp
#  ##    - SDL_LoadBMP_RW failed: Parameter 'src' is invalid
#  ##
#  ##  ```c
#  ##  SDL_Surface *SDL_LoadBMP_RW(SDL_RWops *src, SDL_bool freesrc)
#  ##  ```
#  SDL_LoadBMP_RW src, freesrc.cint

# int SDL_LockSurface(SDL_Surface *surface)
# int SDL_PremultiplyAlpha(int width, int height, Uint32 src_format,
#     const void *src, int src_pitch, Uint32 dst_format, void *dst,
#     int dst_pitch)

# int SDL_ReadSurfacePixel(SDL_Surface *surface, int x, int y, Uint8 *r, Uint8 *g, Uint8 *b, Uint8 *a);

proc SaveBMP*(surface: SurfacePtr, file: string): bool =
  ##  ```c
  ##  int SDL_SaveBMP(SDL_Surface *surface, const char *file)
  ##  ```
  ensure_zero "SDL_SaveBMP":
    SDL_SaveBMP surface, file.cstring

# int SDL_SaveBMP_RW(SDL_Surface *surface, SDL_RWops *dst, SDL_bool freedst)
# int SDL_SetSurfaceAlphaMod(SDL_Surface *surface, Uint8 alpha)
# int SDL_SetSurfaceBlendMode(SDL_Surface *surface, SDL_BlendMode blendMode)
# SDL_bool SDL_SetSurfaceClipRect(SDL_Surface *surface, const SDL_Rect *rect)

proc SetSurfaceColorKey*(surface: SurfacePtr, flag: bool, key: uint32): bool =
  ##  ```c
  ##  int SDL_SetSurfaceColorKey(SDL_Surface *surface, int flag, Uint32 key)
  ##  ```
  ensure_zero "SDL_SetSurfaceColorKey":
    SDL_SetSurfaceColorKey surface, flag.cint, key

# int SDL_SetSurfaceColorMod(SDL_Surface *surface, Uint8 r, Uint8 g, Uint8 b)
# int SDL_SetSurfacePalette(SDL_Surface *surface, SDL_Palette *palette)
# int SDL_SetSurfaceRLE(SDL_Surface *surface, int flag)
# void SDL_SetYUVConversionMode(SDL_YUV_CONVERSION_MODE mode)
# int SDL_SoftStretch(SDL_Surface *src, const SDL_Rect *srcrect,
#     SDL_Surface *dst, const SDL_Rect *dstrect, SDL_ScaleMode scaleMode)
# SDL_bool SDL_SurfaceHasColorKey(SDL_Surface *surface)
# SDL_bool SDL_SurfaceHasRLE(SDL_Surface *surface)
# void SDL_UnlockSurface(SDL_Surface *surface)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_syswm.h>                                                          #
# --------------------------------------------------------------------------- #

# int SDL_GetWindowWMInfo(SDL_Window *window, SDL_SysWMinfo *info, Uint32 version)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_timer.h>                                                          #
# --------------------------------------------------------------------------- #

proc AddTimer*(interval: uint32, callback: TimerCallback,
               param: pointer = nil): TimerID =
  ##  ```c
  ##  SDL_TimerID SDL_AddTimer(Uint32 interval, SDL_TimerCallback callback,
  ##                           void *param)
  ##  ```
  result = SDL_AddTimer(interval, callback, param)
  if result.int == 0:
    log_error "SDL_AddTimer failed: ", $SDL_GetError()

proc Delay*(ms: uint32) {.inline.} =
  ##  ```c
  ##  ```
  SDL_Delay ms

proc DelayNS*(ns: uint64) {.inline.} =
  ##  ```c
  ##  ```
  SDL_DelayNS ns

proc GetPerformanceCounter*(): uint64 {.inline.} =
  ##  ```c
  ##  Uint64 SDL_GetPerformanceCounter(void)
  ##  ```
  SDL_GetPerformanceCounter()

proc GetPerformanceFrequency*(): uint64 {.inline.} =
  ##  ```c
  ##  Uint64 SDL_GetPerformanceFrequency(void)
  ##  ```
  SDL_GetPerformanceFrequency()

proc GetTicks*(): uint64 {.inline.} =
  ##  Return the number of milliseconds since the SDL library initialization.
  ##
  ##  ```c
  ##  Uint64 SDL_GetTicks(void)
  ##  ```
  SDL_GetTicks()

proc GetTicksNS*(): uint64 {.inline.} =
  ##  ```c
  ##  Uint64 SDL_GetTicksNS(void)
  ##  ```
  SDL_GetTicks()

proc RemoveTimer*(id: TimerID): bool {.discardable, inline.} =
  ##  ```c
  ##  SDL_bool SDL_RemoveTimer(SDL_TimerID id)
  ##  ```
  {.warning: "print a warning?".}
  SDL_RemoveTimer id

# --------------------------------------------------------------------------- #
# <SDL3/SDL_touch.h>                                                          #
# --------------------------------------------------------------------------- #

# TODO.

# --------------------------------------------------------------------------- #
# <SDL3/SDL_version.h>                                                        #
# --------------------------------------------------------------------------- #

proc GetRevision*(): string =
  ##  ```c
  ##  const char *SDL_GetRevision(void)
  ##  ```
  $SDL_GetRevision()

proc GetVersion*(): tuple[major, minor, patch: int] =
  ##  ```c
  ##  int SDL_GetVersion(SDL_version *ver)
  ##  ```
  var ver = Version(major: 0, minor: 0, patch: 0)
  SDL_GetVersion ver.addr
  (ver.major.int, ver.minor.int, ver.patch.int)

# --------------------------------------------------------------------------- #
# <SDL3/SDL_video.h>                                                          #
# --------------------------------------------------------------------------- #

proc CreatePopupWindow*(parent: Window, offset_x: int, offset_y: int,
                        w: int, h: int, flags: WindowFlags): Window =
  ##  Create a child popup window of the specified parent window.
  ##
  ##  ```c
  ##  SDL_Window *SDL_CreatePopupWindow(SDL_Window *parent, int offset_x,
  ##                                    int offset_y, int w, int h,
  ##                                    Uint32 flags)
  ##  ```
  ensure_not_nil "SDL_CreatePopupWindow":
    SDL_CreatePopupWindow parent, offset_x.cint, offset_y.cint,
                                  w.cint, h.cint, flags

proc CreateWindow*(title: string, w: int, h: int,
                   flags = WindowFlags 0): Window =
  ##  Create a window with the specified dimensions and flags.
  ##
  ##  ```c
  ##  SDL_Window *SDL_CreateWindow(const char *title, int w, int h,
  ##                               Uint32 flags)
  ##  ```
  ensure_not_nil "SDL_CreateWindow":
    SDL_CreateWindow title, w.cint, h.cint, flags

proc CreateWindowWithProperties*(props: PropertiesID): Window =
  ##  Create a window with the specified properties.
  ##
  ##  `SDL_CreateWindowWithProperties`
  ensure_not_nil "SDL_CreateWindowWithProperties":
    SDL_CreateWindowWithProperties props

proc DestroyWindow*(window: Window) {.inline.} =
  ##  Destroy the window.
  ##
  ##  ```c
  ##  void SDL_DestroyWindow(SDL_Window *window)
  ##  ```
  SDL_DestroyWindow window

# int SDL_DestroyWindowSurface(SDL_Window *window)

proc DisableScreenSaver*(): bool =
  ##  Prevent the screen from being blanked by a screen saver.
  ##
  ##  ```c
  ##  int SDL_DisableScreenSaver(void)
  ##  ```
  ensure_zero "SDL_DisableScreenSaver":
    SDL_DisableScreenSaver()

# SDL_EGLConfig SDL_EGL_GetCurrentEGLConfig(void)
# SDL_EGLDisplay SDL_EGL_GetCurrentEGLDisplay(void)
# SDL_FunctionPointer SDL_EGL_GetProcAddress(const char *proc)
# SDL_EGLSurface SDL_EGL_GetWindowEGLSurface(SDL_Window *window)
# void SDL_EGL_SetEGLAttributeCallbacks(SDL_EGLAttribArrayCallback platformAttribCallback,
#     SDL_EGLIntArrayCallback surfaceAttribCallback, SDL_EGLIntArrayCallback contextAttribCallback)

proc EnableScreenSaver*(): bool =
  ##  Allow the screen to be blanked by a screen saver.
  ##
  ##  ```c
  ##  int SDL_EnableScreenSaver(void)
  ##  ```
  ensure_zero "SDL_EnableScreenSaver":
    SDL_EnableScreenSaver()

proc FlashWindow*(window: Window,
                  operation: FlashOperation): bool {.discardable.} =
  ##  Request a window to demand attention from the user.
  ##
  ##  ```c
  ##  int SDL_FlashWindow(SDL_Window *window, SDL_FlashOperation operation)
  ##  ```
  ensure_zero "SDL_FlashWindow":
    SDL_FlashWindow window, operation

# SDL_GLContext SDL_GL_CreateContext(SDL_Window *window)
# int SDL_GL_DeleteContext(SDL_GLContext context)
# SDL_bool SDL_GL_ExtensionSupported(const char *extension)
# int SDL_GL_GetAttribute(SDL_GLattr attr, int *value)
# SDL_GLContext SDL_GL_GetCurrentContext(void)
# SDL_Window *SDL_GL_GetCurrentWindow(void)
# SDL_FunctionPointer SDL_GL_GetProcAddress(const char *proc)
# int SDL_GL_GetSwapInterval(int *interval)
# int SDL_GL_LoadLibrary(const char *path)
# int SDL_GL_MakeCurrent(SDL_Window *window, SDL_GLContext context)
# void SDL_GL_ResetAttributes(void)
# int SDL_GL_SetAttribute(SDL_GLattr attr, int value)
# int SDL_GL_SetSwapInterval(int interval)
# int SDL_GL_SwapWindow(SDL_Window *window)
# void SDL_GL_UnloadLibrary(void)

proc GetClosestFullscreenDisplayMode*(display_id: DisplayID, w: int, h: int,
                                      refresh_rate: float,
                                      include_high_density_modes: bool): ptr DisplayMode =
  ##  Get the closest match to the requested display mode.
  ##
  ##  ```c
  ##  const SDL_DisplayMode *
  ##  SDL_GetClosestFullscreenDisplayMode(SDL_DisplayID displayID,
  ##                                      int w, int h, float refresh_rate,
  ##                                      SDL_bool include_high_density_modes)
  ##  ```
  ensure_not_nil "SDL_GetClosestFullscreenDisplayMode":
    SDL_GetClosestFullscreenDisplayMode display_id, w.cint, h.cint,
                                                refresh_rate.cfloat,
                                                include_high_density_modes

proc GetCurrentDisplayMode*(display_id: DisplayID): ptr DisplayMode =
  ##  Get information about the current display mode.
  ##
  ##  ```c
  ##  const SDL_DisplayMode *SDL_GetCurrentDisplayMode(SDL_DisplayID displayID)
  ##  ```
  ensure_not_nil "SDL_GetCurrentDisplayMode":
    SDL_GetCurrentDisplayMode display_id

# SDL_DisplayOrientation SDL_GetCurrentDisplayOrientation(SDL_DisplayID displayID)

proc GetCurrentVideoDriver*(): string =
  ##  Get the name of the currently initialized video driver.
  ##
  ##  ```c
  ##  const char *SDL_GetCurrentVideoDriver(void)
  ##  ```
  let driver = SDL_GetCurrentVideoDriver()
  if driver == nil:
    return ""
  $driver

# const SDL_DisplayMode *SDL_GetDesktopDisplayMode(SDL_DisplayID displayID)

proc GetDisplayBounds*(display_id: DisplayID, rect: var Rect): bool =
  ##  Get the desktop area represented by a display.
  ##
  ##  ```c
  ##  int SDL_GetDisplayBounds(SDL_DisplayID displayID, SDL_Rect *rect)
  ##  ```
  ensure_zero "SDL_GetDisplayBounds":
    SDL_GetDisplayBounds display_id, rect.addr

proc GetDisplayBounds*(display_id: DisplayID, x: var int, y: var int,
                       width: var int, height: var int): bool =
  ##  Get the desktop area represented by a display.
  ##
  ##  ```c
  ##  int SDL_GetDisplayBounds(SDL_DisplayID displayID, SDL_Rect *rect)
  ##  ```
  var bounds = Rect(x: 0, y: 0, w: 0, h: 0)
  if not GetDisplayBounds(display_id, bounds):
    return false
  x       = bounds.x.int
  y       = bounds.y.int
  width   = bounds.w.int
  height  = bounds.h.int
  true

proc GetDisplayContentScale*(display_id: DisplayID): float {.inline.} =
  ##  Get the content scale of a display.
  ##
  ##  ```c
  ##  float SDL_GetDisplayContentScale(SDL_DisplayID displayID)
  ##  ```
  # XXX: TODO: return 0.0f on error
  SDL_GetDisplayContentScale display_id

# SDL_DisplayID SDL_GetDisplayForPoint(const SDL_Point *point)
# SDL_DisplayID SDL_GetDisplayForRect(const SDL_Rect *rect)

proc GetDisplayForWindow*(window: Window): DisplayID =
  ##  Get the display associated with a window.
  ##
  ##  ```c
  ##  SDL_DisplayID SDL_GetDisplayForWindow(SDL_Window *window)
  ##  ```
  result = SDL_GetDisplayForWindow window
  if result.uint32 == 0:
    log_error "SDL_GetDisplayForWindow failed: ", $SDL_GetError()

proc GetDisplayName*(display_id: DisplayID): string =
  ##  Get the name of a display in UTF-8 encoding.
  ##
  ##  ```c
  ##  const char *SDL_GetDisplayName(SDL_DisplayID displayID)
  ##  ```
  $SDL_GetDisplayName display_id

# SDL_PropertiesID SDL_GetDisplayProperties(SDL_DisplayID displayID)

# SDL_PropertiesID SDL_GetGlobalProperties(void)

# XXX: test and remove.
# proc get_displays*(count: var int): ptr UncheckedArray[DisplayID] =
#   ##  ```c
#   ##  SDL_DisplayID *SDL_GetDisplays(int *count)
#   ##  ```
#   {.warning: "allocated seq and do not bother the user with free".}
#   var outcount: cint = 0
#   result = SDL_GetDisplays outcount.addr
#   if result == nil:
#     log_error "SDL_GetDisplays failed: ", $SDL_GetError()
#     return nil
#   count = outcount

proc GetDisplays*(): seq[DisplayID] =
  ##  Get a list of currently connected displays.
  ##
  ##  ```c
  ##  SDL_DisplayID *SDL_GetDisplays(int *count)
  ##  ```
  var count: cint = 0

  let display_list = SDL_GetDisplays(count.addr)
  if display_list == nil:
    log_error "SDL_GetDisplays failed: ", $SDL_GetError()
    return @[]

  result = newSeqOfCap[DisplayID] count
  for i in 0 ..< count:
    result.add display_list[i]

  c_free display_list

proc GetDisplayUsableBounds*(display_id: DisplayID, rect: var Rect): bool =
  ##  Get the usable desktop area represented by a display, in screen
  ##  coordinates.
  ##
  ##  ```c
  ##  int SDL_GetDisplayUsableBounds(SDL_DisplayID displayID, SDL_Rect *rect)
  ##  ```
  ensure_zero "SDL_GetDisplayUsableBounds":
    SDL_GetDisplayUsableBounds display_id, rect.addr

# XXX: TODO: remove this, leave only Rect or add x and y?
proc GetDisplayUsableBounds*(display_id: DisplayID, width: var int,
                             height: var int): bool =
  ##  Get the usable desktop area represented by a display, in screen
  ##  coordinates.
  ##
  ##  ```c
  ##  int SDL_GetDisplayUsableBounds(SDL_DisplayID displayID, SDL_Rect *rect)
  ##  ```
  var bounds = Rect(x: 0, y: 0, w: 0, h: 0)
  if unlikely SDL_GetDisplayUsableBounds(display_id, bounds.addr) != 0:
    log_error "SDL_GetDisplayUsableBounds failed: ", $SDL_GetError()
    return false
  width   = bounds.w.int
  height  = bounds.h.int
  true

# const SDL_DisplayMode **SDL_GetFullscreenDisplayModes(SDL_DisplayID displayID, int *count)

# {.warning: "return nim type".}
# proc get_fullscreen_display_modes*(display_id: DisplayID,
#                                    count: var int): ptr UncheckedArray[ptr DisplayMode] =
#   ##  ```c
#   ##  const SDL_DisplayMode **SDL_GetFullscreenDisplayModes(SDL_DisplayID displayID, int *count)
#   ##  ```
#   var outcount: cint = 0
#   result = SDL_GetFullscreenDisplayModes(display_id, outcount.addr)
#   if result == nil:
#     log_error "SDL_GetFullscreenDisplayModes failed: ", $SDL_GetError()
#     return nil
#   count = outcount

# XXX: test it and remove above
proc GetFullscreenDisplayModes*(display_id: DisplayID): seq[DisplayMode] =
  ##  Get a list of fullscreen display modes available on a display.
  ##
  ##  ```c
  ##  const SDL_DisplayMode **SDL_GetFullscreenDisplayModes(SDL_DisplayID displayID, int *count)
  ##  ```
  var count: cint = 0

  let mode_list = SDL_GetFullscreenDisplayModes(display_id, count.addr)
  if mode_list == nil:
    log_error "SDL_GetFullscreenDisplayModes failed: ", $SDL_GetError()
    return @[]

  result = newSeqOfCap[DisplayMode] count
  for i in 0 ..< count:
    result.add mode_list[i][]

  c_free mode_list

proc GetGrabbedWindow*(): Window =
  ##  Get the window that currently has an input grab enabled.
  ##
  ##  ```c
  ##  SDL_Window *SDL_GetGrabbedWindow(void)
  ##  ```
  SDL_GetGrabbedWindow()

# SDL_DisplayOrientation SDL_GetNaturalDisplayOrientation(SDL_DisplayID displayID)

proc GetNumVideoDrivers*(): int =
  ##  Get the number of video drivers compiled into SDL.
  ##
  ##  ```c
  ##  int SDL_GetNumVideoDrivers(void)
  ##  ```
  ensure_positive "SDL_GetNumVideoDrivers":
    SDL_GetNumVideoDrivers()

proc GetPrimaryDisplay*(): DisplayID {.inline.} =
  ##  Return the primary display.
  ##
  ##  ```c
  ##  SDL_DisplayID SDL_GetPrimaryDisplay(void)
  ##  ```
  # XXX: check result?
  SDL_GetPrimaryDisplay()

# SDL_SystemTheme SDL_GetSystemTheme(void)
# const char *SDL_GetVideoDriver(int index)
# int SDL_GetWindowBordersSize(SDL_Window *window, int *top, int *left,
#     int *bottom, int *right)

# float SDL_GetWindowDisplayScale(SDL_Window *window)

proc GetWindowFlags*(window: Window): WindowFlags {.inline.} =
  ##  Get the window flags.
  ##
  ##  ```c
  ##  Uint32 SDL_GetWindowFlags(SDL_Window *window)
  ##  ```
  SDL_GetWindowFlags window

# int SDL_SetWindowFocusable(SDL_Window *window, SDL_bool focusable)

proc GetWindowFromID*(id: WindowID or uint32): Window {.inline.} =
  ##  Get a window from a stored ID.
  ##
  ##  ```c
  ##  SDL_Window *SDL_GetWindowFromID(SDL_WindowID id)
  ##  ```
  SDL_GetWindowFromID id.WindowID

proc GetWindowFullscreenMode*(window: Window = nil): ptr DisplayMode =
  ##  Query the display mode to use when a window is visible at fullscreen.
  ##
  ##  ```c
  ##  const SDL_DisplayMode *SDL_GetWindowFullscreenMode(SDL_Window *window)
  ##  ```
  ensure_not_nil "SDL_GetWindowFullscreenMode":
    SDL_GetWindowFullscreenMode window

# void *SDL_GetWindowICCProfile(SDL_Window *window, size_t *size)

proc GetWindowID*(window: Window): WindowID {.inline.} =
  ##  Get the numeric ID of a window.
  ##
  ##  ```c
  ##  SDL_WindowID SDL_GetWindowID(SDL_Window *window)
  ##  ```
  # XXX: ensure_positive
  SDL_GetWindowID window

proc GetWindowKeyboardGrab*(window: Window): bool {.inline.} =
  ##  Get a window's keyboard grab mode.
  ##
  ##  ```c
  ##  SDL_bool SDL_GetWindowKeyboardGrab(SDL_Window *window)
  ##  ```
  SDL_GetWindowKeyboardGrab window

proc GetWindowMaximumSize*(window: Window, w: var int, h: var int): bool =
  ##  Get the maximum size of a window's client area.
  ##
  ##  ```c
  ##  int SDL_GetWindowMaximumSize(SDL_Window *window, int *w, int *h)
  ##  ```
  var outw, outh: cint = 0
  ensure_zero "SDL_GetWindowMaximumSize":
    SDL_GetWindowMaximumSize window, outw.addr, outh.addr
  w = outw
  h = outh

proc GetWindowMinimumSize*(window: Window, w: var int, h: var int): bool =
  ##  Get the minimum size of a window's client area.
  ##
  ##  ```c
  ##  int SDL_GetWindowMinimumSize(SDL_Window *window, int *w, int *h)
  ##  ```
  var outw, outh: cint = 0
  ensure_zero "SDL_GetWindowMinimumSize":
    SDL_GetWindowMinimumSize window, outw.addr, outh.addr
  w = outw
  h = outh

proc GetWindowMouseGrab*(window: Window): bool =
  ##  Get a window's mouse grab mode.
  ##
  ##  ```c
  ##  SDL_bool SDL_GetWindowMouseGrab(SDL_Window *window)
  ##  ```
  SDL_GetWindowMouseGrab window

# const SDL_Rect *SDL_GetWindowMouseRect(SDL_Window *window)
# int SDL_GetWindowOpacity(SDL_Window *window, float *out_opacity)
# SDL_Window *SDL_GetWindowParent(SDL_Window *window)
# float SDL_GetWindowPixelDensity(SDL_Window *window)

proc GetWindowPixelFormat*(window: Window): PixelFormatEnum =
  ##  Get the pixel format associated with the window.
  ##
  ##  ```c
  ##  Uint32 SDL_GetWindowPixelFormat(SDL_Window *window)
  ##  ```
  result = SDL_GetWindowPixelFormat window
  if result == PIXELFORMAT_UNKNOWN:
    log_error "SDL_GetWindowPixelFormat failed: " & $SDL_GetError()

proc GetWindowPosition*(window: Window, x: var int, y: var int): bool =
  ##  Get the position of a window.
  ##
  ##  ```c
  ##  int SDL_GetWindowPosition(SDL_Window *window, int *x, int *y)
  ##  ```
  var outx, outy: cint = 0
  if SDL_GetWindowPosition(window, outx.addr, outy.addr) != 0:
    log_error "SDL_GetWindowPosition failed: ", $SDL_GetError()
    return false
  x = outx
  y = outy
  true

# SDL_PropertiesID SDL_GetWindowProperties(SDL_Window *window)

proc GetWindowSize*(window: Window, w, h: var int): bool =
  ##  Get the size of a window's client area.
  ##
  ##  ```c
  ##  int SDL_GetWindowSize(SDL_Window *window, int *w, int *h)
  ##  ```
  var outw, outh: cint = 0
  if SDL_GetWindowSize(window, outw.addr, outh.addr) != 0:
    log_error "SDL_GetWindowSize failed: ", $SDL_GetError()
    return false
  w = outw
  h = outh
  true

# int SDL_GetWindowSizeInPixels(SDL_Window *window, int *w, int *h)
# SDL_Surface *SDL_GetWindowSurface(SDL_Window *window)
# const char *SDL_GetWindowTitle(SDL_Window *window)
# SDL_bool SDL_HasWindowSurface(SDL_Window *window)

proc HideWindow*(window: Window): bool =
  ##  Hide a window.
  ##
  ##  ```c
  ##  int SDL_HideWindow(SDL_Window *window)
  ##  ```
  ensure_zero "SDL_HideWindow":
    SDL_HideWindow window

# int SDL_MaximizeWindow(SDL_Window *window)
# int SDL_MinimizeWindow(SDL_Window *window)

proc RaiseWindow*(window: Window): bool =
  ##  Raise a window above other windows and set the input focus.
  ##
  ##  ```c
  ##  int SDL_RaiseWindow(SDL_Window *window)
  ##  ```
  ensure_zero "SDL_RaiseWindow":
    SDL_RaiseWindow window

# int SDL_RestoreWindow(SDL_Window *window)

proc ScreenSaverEnabled*(): bool {.inline.} =
  ##  Check whether the screensaver is currently enabled.
  ##
  ##  ```c
  ##  SDL_bool SDL_ScreenSaverEnabled(void)
  ##  ```
  SDL_ScreenSaverEnabled()

# int SDL_SetWindowAlwaysOnTop(SDL_Window *window, SDL_bool on_top)

proc SetWindowBordered*(window: Window, bordered: bool): bool =
  ##  Set the border state of a window.
  ##
  ##  ```c
  ##  int SDL_SetWindowBordered(SDL_Window *window, SDL_bool bordered)
  ##  ```
  ensure_zero "SDL_SetWindowBordered":
    SDL_SetWindowBordered window, bordered

# int SDL_SetWindowFocusable(SDL_Window *window, SDL_bool focusable)

proc SetWindowFullscreen*(window: Window, fullscreen: bool): bool =
  ##  Set a window's fullscreen state.
  ##
  ##  ```c
  ##  int SDL_SetWindowFullscreen(SDL_Window *window, SDL_bool fullscreen)
  ##  ```
  ensure_zero "SDL_SetWindowFullscreen":
    SDL_SetWindowFullscreen window, fullscreen

proc SetWindowFullscreenMode*(window: Window, mode: ptr DisplayMode): bool =
  ##  Set the display mode to use when a window is visible and fullscreen.
  ##
  ##  ```c
  ##  int SDL_SetWindowFullscreenMode(SDL_Window *window,
  ##                                  const SDL_DisplayMode *mode)
  ##  ```
  ensure_zero "SDL_SetWindowFullscreenMode":
    SDL_SetWindowFullscreenMode window, mode

# int SDL_SetWindowHitTest(SDL_Window *window, SDL_HitTest callback,
#     void *callback_data)

proc SetWindowIcon*(window: Window, surface: SurfacePtr): bool =
  ##  Set the icon for a window.
  ##
  ##  ```c
  ##  int SDL_SetWindowIcon(SDL_Window *window, SDL_Surface *icon)
  ##  ```
  ensure_zero "SDL_SetWindowIcon":
    SDL_SetWindowIcon window, surface

# int SDL_SetWindowInputFocus(SDL_Window *window)

proc SetWindowKeyboardGrab*(window: Window, grabbed: bool): bool =
  ##  Set a window's keyboard grab mode.
  ##
  ##  ```c
  ##  int SDL_SetWindowKeyboardGrab(SDL_Window *window, SDL_bool grabbed)
  ##  ```
  ensure_zero "SDL_SetWindowKeyboardGrab":
    SDL_SetWindowKeyboardGrab window, grabbed

proc SetWindowMaximumSize*(window: Window, min_w: int, min_h: int): bool =
  ##  Set the maximum size of a window's client area.
  ##
  ##  ```c
  ##  int SDL_SetWindowMaximumSize(SDL_Window *window, int max_w, int max_h)
  ##  ```
  ensure_zero "SDL_SetWindowMaximumSize":
    SDL_SetWindowMaximumSize window, min_w.cint, min_h.cint

proc SetWindowMinimumSize*(window: Window, min_w: int, min_h: int): bool =
  ##  Set the minimum size of a window's client area.
  ##
  ##  ```c
  ##  int SDL_SetWindowMinimumSize(SDL_Window *window, int min_w, int min_h)
  ##  ```
  ensure_zero "SDL_SetWindowMinimumSize":
    SDL_SetWindowMinimumSize window, min_w.cint, min_h.cint

# int SDL_SetWindowModalFor(SDL_Window *modal_window, SDL_Window *parent_window)

proc SetWindowMouseGrab*(window: Window, grabbed: bool): bool {.discardable.} =
  ##  Set a window's mouse grab mode.
  ##
  ##  ```c
  ##  int SDL_SetWindowMouseGrab(SDL_Window *window, SDL_bool grabbed)
  ##  ```
  ensure_zero "SDL_SetWindowMouseGrab":
    SDL_SetWindowMouseGrab window, grabbed

# int SDL_SetWindowMouseRect(SDL_Window *window, const SDL_Rect *rect)
# int SDL_SetWindowOpacity(SDL_Window *window, float opacity)

proc SetWindowPosition*(window: Window, x: int, y: int): bool =
  ##  Set the position of a window.
  ##
  ##  .. note::
  ##    Centering the window after returning from full screen moves
  ##    the window to primary display.
  ##    XXX: TODO: this note comes from SDL2, check this behavior in SDL3.
  ##
  ##  ```c
  ##  int SDL_SetWindowPosition(SDL_Window *window, int x, int y)
  ##  ```
  ensure_zero "SDL_SetWindowPosition":
    SDL_SetWindowPosition window, x.cint, y.cint

proc SetWindowResizable*(window: Window, ontop: bool): bool =
  ##  Set the user-resizable state of a window.
  ##
  ##  ```c
  ##  int SDL_SetWindowResizable(SDL_Window *window, SDL_bool resizable)
  ##  ```
  ensure_zero "SDL_SetWindowResizable":
    SDL_SetWindowResizable window, ontop

proc SetWindowSize*(window: Window, x: int, y: int): bool =
  ##  Set the size of a window's client area.
  ##
  ##  ```c
  ##  int SDL_SetWindowSize(SDL_Window *window, int w, int h)
  ##  ```
  ensure_zero "SDL_SetWindowSize":
    SDL_SetWindowSize window, x.cint, y.cint

proc SetWindowTitle*(window: Window, title: string): bool =
  ##  Set the title of a window.
  ##
  ##  ```c
  ##  int SDL_SetWindowTitle(SDL_Window *window, const char *title)
  ##  ```
  ensure_zero "SDL_SetWindowTitle":
    SDL_SetWindowTitle window, title

proc ShowWindow*(window: Window): bool =
  ##  Show a window.
  ##
  ##  ```c
  ##  int SDL_ShowWindow(SDL_Window *window)
  ##  ```
  ensure_zero "SDL_ShowWindow":
    SDL_ShowWindow window

# int SDL_ShowWindowSystemMenu(SDL_Window *window, int x, int y)
# int SDL_SyncWindow(SDL_Window *window)

proc UpdateWindowSurface*(window: Window): bool =
  ##  Copy the window surface to the screen.
  ##
  ##  ```c
  ##  int SDL_UpdateWindowSurface(SDL_Window *window)
  ##  ```
  ensure_zero "SDL_UpdateWindowSurface":
    SDL_UpdateWindowSurface window

# int SDL_UpdateWindowSurfaceRects(SDL_Window *window, const SDL_Rect *rects,
#     int numrects)

# XXX
# proc get_display_index*(window: Window): int {.deprecated: "use get_display_for_window instead".}

# --------------------------------------------------------------------------- #
# <SDL3/SDL_vulkan.h>                                                         #
# --------------------------------------------------------------------------- #

# SDL_bool SDL_Vulkan_CreateSurface(SDL_Window *window, VkInstance instance,
#     VkSurfaceKHR* surface)
# SDL_bool SDL_Vulkan_GetInstanceExtensions(unsigned int *pCount,
#     const char **pNames)
# SDL_FunctionPointer SDL_Vulkan_GetVkGetInstanceProcAddr(void)
# int SDL_Vulkan_LoadLibrary(const char *path)
# void SDL_Vulkan_UnloadLibrary(void)

# =========================================================================== #
# ==  C macros                                                             == #
# =========================================================================== #

# --------------------------------------------------------------------------- #
# <SDL/SDL_quit.h>                                                            #
# --------------------------------------------------------------------------- #

proc QuitRequested*(): bool {.inline.} =
  ##  ```c
  ##  #define SDL_QuitRequested() \
  ##      SDL_PumpEvents(), \
  ##      (SDL_PeepEvents(NULL, 0, SDL_PEEKEVENT, SDL_EVENT_QUIT, \
  ##                      SDL_EVENT_QUIT) > 0))
  ##  ```
  PumpEvents()
  var events: seq[Event] = @[]
  PeepEvents(events, 0, PEEKEVENT, EVENT_QUIT, EVENT_QUIT) > 0


# --------------------------------------------------------------------------- #
# <SDL/SDL_video.h>                                                           #
# --------------------------------------------------------------------------- #

# Obsolete.
#proc load_bmp*(file: string): SurfacePtr {.inline.} =
#  ##  ```c
#  ##  #define SDL_LoadBMP(file) SDL_LoadBMP_RW(SDL_RWFromFile(file, "rb"), 1)
#  ##  ```
#  load_bmp_rw_unchecked(rw_from_file(file, "rb"), true)

# =========================================================================== #
# ==  SDL3 compat                                                          == #
# =========================================================================== #

# --------------------------------------------------------------------------- #
# <SDL3/SDL_render.h>                                                         #
# --------------------------------------------------------------------------- #

proc RenderCopy*(renderer: Renderer, texture: Texture): bool {.deprecated: "use RenderTexture instead", inline.} =
  ##  ```c
  ##  XXX
  ##  ```
  RenderTexture renderer, texture

proc RenderCopy*(renderer: Renderer, texture: Texture, dst: FRect): bool {.deprecated: "use RenderTexture instead", inline.} =
  ##  ```c
  ##  XXX
  ##  ```
  RenderTexture renderer, texture, dst

proc RenderCopy*(renderer: Renderer, texture: Texture, src, dst: FRect): bool {.deprecated: "use RenderTexture instead", inline.} =
  ##  ```c
  ##  XXX
  ##  ```
  RenderTexture renderer, texture, src, dst

# --------------------------------------------------------------------------- #
# <SDL3/SDL_surface.h>                                                        #
# --------------------------------------------------------------------------- #

proc CreateRGBSurfaceFrom*(pixels: pointer, width: int, height: int,
                           depth: int, pitch: int, rmask: uint32,
                           gmask: uint32, bmask: uint32, amask: uint32): SurfacePtr {.deprecated: "use CreateSurfaceFrom", inline.} =
  ##  ```c
  ##  ```
  CreateSurfaceFrom pixels, width.cint, height.cint, pitch.cint,
                    GetPixelFormatEnumForMasks(depth, rmask, gmask, bmask, amask)


proc FreeSurface*(surface: SurfacePtr) {.deprecated: "use DestroySurface instead", inline.} =
  ##  ```c
  ##  ```
  DestroySurface surface

# =========================================================================== #
# ==  Helper functions                                                     == #
# =========================================================================== #

proc sdl3_avail*(flags = INIT_VIDEO): bool =
  result = Init flags
  if result:
    Quit()

# vim: set sts=2 et sw=2:
