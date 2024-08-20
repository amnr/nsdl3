##  SDL3 ABI functions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

import pkg/dlutils

import config

when use_audio:
  import sdl3inc/sdl3audio
when use_blendmode:
  import sdl3inc/sdl3blendmode
when use_clipboard:
  import sdl3inc/sdl3clipboard
import sdl3inc/sdl3events
# XXX: gamepad
# XXX: haptic
# XXX: hidapi
when use_hints:
  import sdl3inc/sdl3hints
import sdl3inc/sdl3init
import sdl3inc/sdl3iostream
when use_joystick:
  import sdl3inc/sdl3joystick
when use_keyboard:
  import sdl3inc/sdl3keycode
import sdl3inc/sdl3log
when use_messagebox:
  import sdl3inc/sdl3messagebox
when use_mouse:
  import sdl3inc/sdl3mouse
# XXX: pen
import sdl3inc/sdl3pixels
when use_properties:
  import sdl3inc/sdl3properties
import sdl3inc/sdl3rect
import sdl3inc/sdl3render
# XXX: sensor
import sdl3inc/sdl3surface
import sdl3inc/sdl3timer
# XXX: touch
import sdl3inc/sdl3video
# XXX: vulkan

when defined macosx:
  const lib_paths = [
    "libSDL3.dylib"
  ]
when defined posix:
  const lib_paths = [
    "libSDL3.so",
    "libSDL3.so.0"
  ]
elif defined windows:
  const lib_paths = [
    "SDL3.dll"
  ]
else:
  {.fatal: "unsupported platform.".}

# =========================================================================== #
# ==  SDL3 library object                                                  == #
# =========================================================================== #

dlgencalls "sdl3", lib_paths:

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_audio.h>                                                        #
  # ------------------------------------------------------------------------- #

  when use_audio:

    # int SDL_BindAudioStream(SDL_AudioDeviceID devid, SDL_AudioStream *stream)
    # int SDL_BindAudioStreams(SDL_AudioDeviceID devid,
    #     proc SDL_AudioStream **streams, int num_streams)
    # int SDL_ClearAudioStream(SDL_AudioStream *stream)
    # void SDL_CloseAudioDevice(SDL_AudioDeviceID devid)

    proc SDL_ConvertAudioSamples(
      src_spec  : ptr AudioSpec,
      src_data  : ptr byte,
      src_len   : cint,
      dst_spec  : ptr AudioSpec,
      dst_data  : ptr ptr byte,
      dst_len   : ptr cint
    ): cint

    proc SDL_CreateAudioStream(
      src_spec  : ptr AudioSpec,
      dst_spec  : ptr AudioSpec
    ): AudioStream

    proc SDL_DestroyAudioStream(
      stream    : AudioStream
    )

    proc SDL_FlushAudioStream(
      stream    : AudioStream
    ): cint

    # int SDL_GetAudioDeviceFormat(SDL_AudioDeviceID devid,
    #     proc SDL_AudioSpec *spec, int *sample_frames)

    proc SDL_GetAudioDeviceName(
      devid     : AudioDeviceID
    ): cstring

    proc SDL_GetAudioDriver(
      index     : cint
    ): cstring

    # const char * SDL_GetAudioFormatName(SDL_AudioFormat format)

    proc SDL_GetAudioPlaybackDevices(
      count     : ptr cint
    ): ptr UncheckedArray[AudioDeviceID]

    # SDL_AudioDeviceID *SDL_GetAudioRecordingDevices(int *count)

    proc SDL_GetAudioStreamAvailable(
      stream    : AudioStream
    ): cint

    # int SDL_GetAudioStreamData(SDL_AudioStream *stream, void *buf, int len)

    proc SDL_GetAudioStreamDevice(
      stream    : AudioStream
    ): AudioDeviceID

    # int SDL_GetAudioStreamFormat(SDL_AudioStream *stream,
    #     proc SDL_AudioSpec *src_spec, SDL_AudioSpec *dst_spec)

    # float SDL_GetAudioStreamFrequencyRatio(SDL_AudioStream *stream)
    # SDL_PropertiesID SDL_GetAudioStreamProperties(SDL_AudioStream *stream)
    # int SDL_GetAudioStreamQueued(SDL_AudioStream *stream)

    proc SDL_GetCurrentAudioDriver(): cstring

    proc SDL_GetNumAudioDrivers(): cint

    # int SDL_GetSilenceValueForFormat(SDL_AudioFormat format)
    # SDL_bool SDL_AudioDevicePaused(SDL_AudioDeviceID dev)
    # int SDL_LoadWAV(const char *path, SDL_AudioSpec *spec, Uint8 **audio_buf,
    #     Uint32 *audio_len)
    # int SDL_LoadWAV_IO(SDL_IOStream * src, SDL_bool closeio,
    #     SDL_AudioSpec * spec, Uint8 ** audio_buf, Uint32 * audio_len);
    # int SDL_LockAudioStream(SDL_AudioStream *stream)
    # int SDL_MixAudioFormat(Uint8 *dst, const Uint8 *src,
    #     proc SDL_AudioFormat format, Uint32 len, int volume)
    # SDL_AudioDeviceID SDL_OpenAudioDevice(SDL_AudioDeviceID devid,
    #     const SDL_AudioSpec *spec)

    proc SDL_OpenAudioDeviceStream(
      devid     : AudioDeviceID,
      spec      : ptr AudioSpec,
      callback  : AudioStreamCallback,
      userdata  : pointer
    ): AudioStream

    proc SDL_PauseAudioDevice(
      dev       : AudioDeviceID
    ): cint

    proc SDL_PutAudioStreamData(
      stream    : AudioStream,
      buf       : pointer,
      len       : cint
    ): cint

    proc SDL_ResumeAudioDevice(
      dev       : AudioDeviceID
    ): cint

    # int SDL_SetAudioPostmixCallback(SDL_AudioDeviceID devid,
    #     proc SDL_AudioPostmixCallback callback, void *userdata)
    # int SDL_SetAudioStreamFormat(SDL_AudioStream *stream,
    #     const SDL_AudioSpec *src_spec, const SDL_AudioSpec *dst_spec)
    # int SDL_SetAudioStreamFrequencyRatio(SDL_AudioStream *stream,
    #     float ratio)
    # int SDL_SetAudioStreamGetCallback(SDL_AudioStream *stream,
    #     proc SDL_AudioStreamCallback callback, void *userdata)
    # int SDL_SetAudioStreamPutCallback(SDL_AudioStream *stream,
    #     proc SDL_AudioStreamCallback callback, void *userdata)
    # void SDL_UnbindAudioStream(SDL_AudioStream *stream)
    # void SDL_UnbindAudioStreams(SDL_AudioStream **streams, int num_streams)
    # int SDL_UnlockAudioStream(SDL_AudioStream *stream)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_blendmode.h>                                                    #
  # ------------------------------------------------------------------------- #

  when use_blendmode:
    proc SDL_ComposeCustomBlendMode(
      src_color_factor  : BlendFactor,
      dst_color_factor  : BlendFactor,
      color_operation   : BlendOperation,
      src_alpha_factor  : BlendFactor,
      dst_alpha_factor  : BlendFactor,
      alpha_operation   : BlendOperation
    ): BlendMode

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_camera.h>                                                       #
  # ------------------------------------------------------------------------- #

  # SDL_Surface * SDL_AcquireCameraFrame(SDL_Camera *camera, Uint64 *timestampNS);
  # void SDL_CloseCamera(SDL_Camera *camera);
  # char * SDL_GetCameraDeviceName(SDL_CameraDeviceID instance_id);
  # SDL_CameraPosition SDL_GetCameraDevicePosition(SDL_CameraDeviceID instance_id);
  # SDL_CameraDeviceID *SDL_GetCameraDevices(int *count);
  # SDL_CameraSpec *SDL_GetCameraDeviceSupportedFormats(SDL_CameraDeviceID devid, int *count);
  # const char *SDL_GetCameraDriver(int index);
  # int SDL_GetCameraFormat(SDL_Camera *camera, SDL_CameraSpec *spec);
  # SDL_CameraDeviceID SDL_GetCameraInstanceID(SDL_Camera *camera);
  # int SDL_GetCameraPermissionState(SDL_Camera *camera);
  # SDL_PropertiesID SDL_GetCameraProperties(SDL_Camera *camera);
  # const char *SDL_GetCurrentCameraDriver(void);
  # int SDL_GetNumCameraDrivers(void);
  # SDL_Camera *SDL_OpenCameraDevice(SDL_CameraDeviceID instance_id, const SDL_CameraSpec *spec);
  # int SDL_ReleaseCameraFrame(SDL_Camera *camera, SDL_Surface *frame);

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_clipboard.h>                                                    #
  # ------------------------------------------------------------------------- #

  when use_clipboard:

    proc SDL_ClearClipboardData(): cint

    proc SDL_GetClipboardData(
      mime_type : cstring,
      size      : ptr csize_t
    ): pointer

    # char *SDL_GetClipboardText(void)
    # char *SDL_GetPrimarySelectionText(void)

    proc SDL_HasClipboardData(
      mime_type : cstring
    ): SdlBool

    # SDL_bool SDL_HasClipboardText(void)
    # SDL_bool SDL_HasPrimarySelectionText(void)

    proc SDL_SetClipboardData(
      callback        : ClipboardDataCallback,
      cleanup         : ClipboardCleanupCallback,
      userdata        : pointer,
      mime_types      : ptr cstring,
      num_mime_types  : csize_t
    ): cint

    # int SDL_SetClipboardText(const char *text)
    # int SDL_SetPrimarySelectionText(const char *text)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_dialog.h>                                                       #
  # ------------------------------------------------------------------------- #

  # void SDL_ShowOpenFileDialog(SDL_DialogFileCallback callback,
  #   void *userdata, SDL_Window *window, const SDL_DialogFileFilter *filters,
  #   const char *default_location, SDL_bool allow_many);
  # void SDL_ShowOpenFolderDialog(SDL_DialogFileCallback callback,
  #   void *userdata, SDL_Window *window, const char *default_location,
  #   SDL_bool allow_many);
  # void SDL_ShowSaveFileDialog(SDL_DialogFileCallback callback,
  #   void *userdata, SDL_Window *window, const SDL_DialogFileFilter *filters,
  #   const char *default_location);

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_error.h>                                                        #
  # ------------------------------------------------------------------------- #

  proc SDL_ClearError()

  # int SDL_Error(SDL_errorcode code)

  proc SDL_GetError(): cstring

  # int SDL_SetError(const char *fmt, ...)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_events.h>                                                       #
  # ------------------------------------------------------------------------- #

  # int SDL_AddEventWatch(SDL_EventFilter filter, void *userdata)
  # void *SDL_AllocateEventMemory(size_t size)
  # void SDL_DelEventWatch(SDL_EventFilter filter, void *userdata)
  # SDL_bool SDL_EventEnabled(Uint32 type)

  proc SDL_FilterEvents(filter    : EventFilter,
                        userdata  : pointer)

  proc SDL_FlushEvent(typ: EventType)

  proc SDL_FlushEvents(min_type : EventType,
                       max_type : EventType)

  # SDL_bool SDL_GetEventFilter(SDL_EventFilter *filter, void **userdata)
  # SDL_Window * SDL_GetWindowFromEvent(const SDL_Event *event)
  # SDL_bool SDL_HasEvent(Uint32 type)
  # SDL_bool SDL_HasEvents(Uint32 minType, Uint32 maxType)

  proc SDL_PeepEvents(event     : ptr Event,
                      numevents : cint,
                      action    : EventAction,
                      min_type  : EventType,
                      max_type  : EventType): cint

  proc SDL_PollEvent(event: ptr Event): SdlBool

  proc SDL_PumpEvents()

  proc SDL_PushEvent(event: ptr Event): cint

  # Uint32 SDL_RegisterEvents(int numevents)

  proc SDL_SetEventEnabled(typ: uint32, enabled: SdlBool)

  # void SDL_SetEventFilter(SDL_EventFilter filter, void *userdata)

  proc SDL_WaitEvent(event: ptr Event): SdlBool

  proc SDL_WaitEventTimeout(event: ptr Event, timeout_ms: int32): SdlBool

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_gamepad.h>                                                      #
  # ------------------------------------------------------------------------- #

  # TODO.

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_haptic.h>                                                       #
  # ------------------------------------------------------------------------- #

  # TODO.

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_hidapi.h>                                                       #
  # ------------------------------------------------------------------------- #

  # TODO.

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_hints.h>                                                        #
  # ------------------------------------------------------------------------- #

  when use_hints:

    # int SDL_AddHintCallback(const char *name, SDL_HintCallback callback,
    #     void *userdata)
    # void SDL_ClearHints(void)
    # void SDL_DelHintCallback(const char *name, SDL_HintCallback callback,
    #     void *userdata)

    proc SDL_GetHint(name: HintName): cstring

    # SDL_bool SDL_GetHintBoolean(const char *name, SDL_bool default_value)
    # int SDL_ResetHint(const char *name)
    # void SDL_ResetHints(void)

    proc SDL_SetHint(name: cstring, value: cstring): cint

    # int SDL_SetHintWithPriority(const char *name, const char *value,
    #     proc SDL_HintPriority priority)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_init.h>                                                         #
  # ------------------------------------------------------------------------- #

  proc SDL_GetAppMetadataProperty(name: AppMetadataProperty): cstring

  proc SDL_Init(flags: InitFlags): cint

  proc SDL_InitSubSystem(flags: InitFlags): cint

  proc SDL_Quit()

  proc SDL_QuitSubSystem(flags: InitFlags)
  
  proc SDL_SetAppMetadata(appname, appversion, appidentifier: cstring): cint

  proc SDL_SetAppMetadataProperty(name: AppMetadataProperty, value: cstring): cint

  proc SDL_WasInit(flags: InitFlags): InitFlags

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_joystick.h>                                                     #
  # ------------------------------------------------------------------------- #

  when use_joystick:

    proc SDL_CloseJoystick(joystick: Joystick)

    # int SDL_GetJoystickBall(SDL_Joystick *joystick, int ball, int *dx, int *dy);

    proc SDL_GetJoystickGUID(joystick: Joystick): JoystickGUID

    proc SDL_GetJoystickName(joystick: Joystick): cstring

    # int SDL_GetNumJoystickBalls(SDL_Joystick *joystick);

    proc SDL_GetJoystickPath(joystick: Joystick): cstring

    proc SDL_GetJoystickProduct(joystick: Joystick): uint16

    proc SDL_GetJoystickProperties(joystick: Joystick): PropertiesID

    proc SDL_GetJoysticks(count: ptr cint): ptr UncheckedArray[JoystickID]

    proc SDL_GetJoystickSerial(joystick: Joystick): cstring

    proc SDL_GetJoystickType(joystick: Joystick): JoystickType

    proc SDL_GetJoystickVendor(joystick: Joystick): uint16

    proc SDL_GetNumJoystickAxes(joystick: Joystick): cint

    proc SDL_GetNumJoystickButtons(joystick: Joystick): cint

    proc SDL_GetNumJoystickHats(joystick: Joystick): cint

    # proc SDL_HasJoystick(): SdlBool

    proc SDL_OpenJoystick(instance_id: JoystickID): Joystick

    proc SDL_UpdateJoysticks()

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
    # int SDL_GetJoystickPlayerIndex(joystick: Joystick)
    # int SDL_SetJoystickPlayerIndex(joystick: Joystick, int player_index)
    # Uint16 SDL_GetJoystickProductVersion(joystick: Joystick)
    # Uint16 SDL_GetJoystickFirmwareVersion(joystick: Joystick)
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
    # SDL_JoystickConnectionState SDL_GetJoystickConnectionState(SDL_Joystick *joystick);
    # SDL_PowerState SDL_GetJoystickPowerInfo(SDL_Joystick *joystick, int *percent);

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_keyboard.h>                                                     #
  # ------------------------------------------------------------------------- #

  when use_keyboard:

    # XXX.

    proc SDL_GetKeyName(key: Keycode): cstring

    # XXX.

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_log.h>                                                          #
  # ------------------------------------------------------------------------- #

  # SDL_Log, SDL_LogCritical, SDL_LogDebug, SDL_LogError, SDL_LogInfo,
  # SDL_LogVerbose and SDL_LogWarn are emulated by calling SDL_LogMessage.

  # void SDL_LogGetOutputFunction(SDL_LogOutputFunction *callback,
  #                               void **userdata)
  # SDL_LogPriority SDL_GetLogPriority(int category)

  proc SDL_LogMessage(category: LogCategory, priority: LogPriority,
                      fmt: cstring) {.varargs.}

  # void SDL_LogMessageV(int category, SDL_LogPriority priority,
  #                      const char *fmt, va_list ap)
  # void SDL_ResetLogPriorities(void)

  proc SDL_SetLogOutputFunction(callback: LogOutputFunction, userdata: pointer)

  # void SDL_SetLogPriorities(SDL_LogPriority priority)

  proc SDL_SetLogPriority(category: LogCategory, priority: LogPriority)

  # int SDL_SetLogPriorityPrefix(SDL_LogPriority priority, const char *prefix)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_main.h>                                                         #
  # ------------------------------------------------------------------------- #

  # TODO.

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_messagebox.h>                                                   #
  # ------------------------------------------------------------------------- #

  when use_messagebox:

    proc SDL_ShowMessageBox(messageboxdata: ptr MessageBoxData,
                            buttonid: ptr cint): cint

    proc SDL_ShowSimpleMessageBox(flags: MessageBoxFlags, title: cstring,
                                  message: cstring, window: Window): cint

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_mouse.h>                                                        #
  # ------------------------------------------------------------------------- #

  when use_mouse:

    proc SDL_CaptureMouse(enabled: SdlBool): cint

    proc SDL_CreateColorCursor(surface: SurfacePtr,
                               hot_x, hot_y: cint): Cursor

    proc SDL_CreateCursor(data: ptr byte, mask: ptr byte, w, h: cint,
                          hot_x, hot_y: cint): Cursor

    proc SDL_CreateSystemCursor(id: SystemCursor): Cursor

    proc SDL_CursorVisible(): SdlBool

    proc SDL_DestroyCursor(cursor: Cursor)

    proc SDL_GetCursor(): Cursor

    # SDL_Cursor *SDL_GetDefaultCursor(void)

    proc SDL_GetGlobalMouseState(x, y: ptr cfloat): MouseButtonFlags

    # SDL_MouseID * SDL_GetMice(int *count);

    proc SDL_GetMouseFocus(): Window

    # const char * SDL_GetMouseNameForID(SDL_MouseID instance_id);

    proc SDL_GetMouseState(x, y: ptr cfloat): MouseButtonFlags

    proc SDL_GetWindowRelativeMouseMode(window: Window): SdlBool

    # MouseButtonFlags SDL_GetRelativeMouseState(float *x, float *y)

    proc SDL_HasMouse(): SdlBool

    proc SDL_HideCursor(): cint

    proc SDL_SetCursor(cursor: Cursor): cint

    proc SDL_SetWindowRelativeMouseMode(window: Window, enabled: SdlBool): cint

    proc SDL_ShowCursor(): cint

    # int SDL_WarpMouseGlobal(float x, float y)
    # void SDL_WarpMouseInWindow(SDL_Window *window, float x, float y)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_iostream.h>                                                     #
  # ------------------------------------------------------------------------- #

  # XXX: TODO.

  proc SDL_IOFromFile(file: cstring, mode: cstring): IOStream

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

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_pixels.h>                                                       #
  # ------------------------------------------------------------------------- #

  proc SDL_CreatePalette(ncolors: cint): ptr Palette

  # SDL_PixelFormat *SDL_CreatePixelFormat(SDL_PixelFormatEnum pixel_format)

  proc SDL_DestroyPalette(palette: ptr Palette)

  # SDL_bool SDL_GetMasksForPixelFormatEnum(SDL_PixelFormatEnum format, int *bpp,
  #     Uint32 *Rmask, Uint32 *Gmask, Uint32 *Bmask, Uint32 *Amask)

  proc SDL_GetPixelFormatDetails(
    format: PixelFormatEnum
  ): PixelFormatDetailsPtr

  proc SDL_GetPixelFormatForMasks(
    bpp     : cint,
    rmask   : uint32,
    gmask   : uint32,
    bmask   : uint32,
    amask   : uint32
  ): PixelFormatEnum

  # const char* SDL_GetPixelFormatName(SDL_PixelFormatEnum format)
  # void SDL_GetRGB(Uint32 pixel, const SDL_PixelFormatDetails *format,
  #     const SDL_Palette *palette, Uint8 *r, Uint8 *g, Uint8 *b)
  # void SDL_GetRGBA(Uint32 pixel, const SDL_PixelFormatDetails *format,
  #     const SDL_Palette *palette, Uint8 *r, Uint8 *g, Uint8 *b, Uint8 *a)

  proc SDL_MapRGB(
    format  : ptr PixelFormatDetails,
    palette : ptr Palette,
    r       : byte,
    g       : byte,
    b       : byte
  ): uint32

  proc SDL_MapRGBA(
    format  : ptr PixelFormatDetails,
    palette : ptr Palette,
    r       : byte,
    g       : byte,
    b       : byte,
    a       : byte
  ): uint32

  proc SDL_SetPaletteColors(
    palette     : ptr Palette,
    colors      : ptr Color,
    firstcolor  : cint,
    ncolors     : cint
  ): cint

  # int SDL_SetPixelFormatPalette(SDL_PixelFormat *format,
  #     proc SDL_Palette *palette)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_properties.h>                                                   #
  # ------------------------------------------------------------------------- #

  when use_properties:

    # int SDL_CopyProperties(SDL_PropertiesID src, SDL_PropertiesID dst)

    proc SDL_CreateProperties(): PropertiesID

    proc SDL_DestroyProperties(props: PropertiesID)

    proc SDL_EnumerateProperties(
      props     : PropertiesID,
      callback  : EnumeratePropertiesCallback,
      userdata  : pointer
    ): cint

    proc SDL_SetBooleanProperty(
      props     : PropertiesID,
      name      : cstring,
      value     : SdlBool
    ): cint

    proc SDL_SetFloatProperty(
      props     : PropertiesID,
      name      : cstring,
      value     : cfloat
    ): cint

    proc SDL_SetNumberProperty(
      props     : PropertiesID,
      name      : cstring,
      value     : int64
    ): cint

    # int SDL_ClearProperty(SDL_PropertiesID props, const char *name)
    # SDL_bool SDL_GetBooleanProperty(SDL_PropertiesID props, const char *name, SDL_bool default_value)
    # float SDL_GetFloatProperty(SDL_PropertiesID props, const char *name, float default_value)
    # SDL_PropertiesID SDL_GetGlobalProperties(void)
    # Sint64 SDL_GetNumberProperty(SDL_PropertiesID props, const char *name, Sint64 default_value)
    # void * SDL_GetPointerProperty(SDL_PropertiesID props, const char *name, void *default_value)
    # SDL_PropertyType SDL_GetPropertyType(SDL_PropertiesID props, const char *name)
    # const char * SDL_GetStringProperty(SDL_PropertiesID props, const char *name, const char *default_value)
    # SDL_bool SDL_HasProperty(SDL_PropertiesID props, const char *name);
    # int SDL_LockProperties(SDL_PropertiesID props)
    # int SDL_SetBooleanProperty(SDL_PropertiesID props, const char *name, SDL_bool value)
    # int SDL_SetPointerProperty(SDL_PropertiesID props, const char *name, void *value)
    # int SDL_SetProperty(SDL_PropertiesID props, const char *name, void *value)
    # int SDL_SetPropertyWithCleanup(SDL_PropertiesID props, const char *name,
    #     void *value, SDL_CleanupPropertyCallback cleanup,
    #     void *userdata)

    proc SDL_SetStringProperty(props: PropertiesID, name: cstring,
                               value: cstring): cint

    # void SDL_UnlockProperties(SDL_PropertiesID props)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_rect.h>                                                         #
  # ------------------------------------------------------------------------- #

  # SDL_bool SDL_GetRectAndLineIntersection(const SDL_Rect *rect,
  #     int *X1, int *Y1, int *X2, int *Y2)
  # SDL_bool SDL_GetRectAndLineIntersectionFloat(const SDL_FRect *rect,
  #     float *X1, float *Y1, float *X2, float *Y2)
  # SDL_bool SDL_GetRectEnclosingPoints(const SDL_Point *points, int count,
  #     const SDL_Rect *clip, SDL_Rect *result)
  # SDL_bool SDL_GetRectEnclosingPointsFloat(const SDL_FPoint *points,
  #     int count, const SDL_FRect *clip, SDL_FRect *result)
  # SDL_bool SDL_GetRectIntersection(const SDL_Rect *A, const SDL_Rect *B,
  #     proc SDL_Rect *result)
  # SDL_bool SDL_GetRectIntersectionFloat(const SDL_FRect *A,
  #     const SDL_FRect *B, SDL_FRect *result)
  # int SDL_GetRectUnion(const SDL_Rect *A, const SDL_Rect *B,
  #     proc SDL_Rect *result)
  # int SDL_GetRectUnionFloat(const SDL_FRect *A, const SDL_FRect *B,
  #     proc SDL_FRect *result)
  # SDL_bool SDL_HasRectIntersection(const SDL_Rect *A, const SDL_Rect *B)
  # SDL_bool SDL_HasRectIntersectionFloat(const SDL_FRect *A,
  #     const SDL_FRect *B)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_render.h>                                                       #
  # ------------------------------------------------------------------------- #

  # int SDL_AddVulkanRenderSemaphores(SDL_Renderer *renderer,
  #     Uint32 wait_stage_mask, Sint64 wait_semaphore, Sint64 signal_semaphore);

  # int SDL_ConvertEventToRenderCoordinates(SDL_Renderer *renderer,
  #     proc SDL_Event *event)

  proc SDL_CreateRenderer(
    window    : Window,
    name      : cstring
  ): Renderer

  when use_properties:
    proc SDL_CreateRendererWithProperties(props: PropertiesID): Renderer

  # SDL_Renderer *SDL_CreateSoftwareRenderer(SDL_Surface *surface)

  proc SDL_CreateTexture(
    renderer  : Renderer,
    format    : PixelFormatEnum,
    access    : TextureAccess,
    w         : cint,
    h         : cint
  ): Texture

  proc SDL_CreateTextureFromSurface(
    renderer  : Renderer,
    surface   : SurfacePtr
  ): Texture

  when use_properties:
    proc SDL_CreateTextureWithProperties(
      renderer  : Renderer,
      props     : PropertiesID
    ): Texture

  proc SDL_CreateWindowAndRenderer(
    title         : cstring,
    width         : cint,
    height        : cint,
    window_flags  : WindowFlags,
    window        : ptr Window,
    renderer      : ptr Renderer
  ): cint

  proc SDL_DestroyRenderer(renderer: Renderer)

  proc SDL_DestroyTexture(text: Texture)

  # int SDL_GL_BindTexture(SDL_Texture *texture, float *texw, float *texh)
  # int SDL_GL_UnbindTexture(SDL_Texture *texture)
  # int SDL_GetCurrentRenderOutputSize(SDL_Renderer *renderer,
  #     int *w, int *h)
  # int SDL_GetNumRenderDrivers(void)
  # int SDL_GetRenderClipRect(SDL_Renderer *renderer, SDL_Rect *rect)
  # int SDL_GetRenderColorScale(SDL_Renderer *renderer, float *scale);
  # int SDL_GetRenderDrawBlendMode(SDL_Renderer *renderer,
  #     proc SDL_BlendMode *blendMode)
  # int SDL_GetRenderDrawColor(SDL_Renderer *renderer,
  #     Uint8 *r, Uint8 *g, Uint8 *b, Uint8 *a)
  # int SDL_GetRenderDrawColorFloat(SDL_Renderer *renderer, float *r, float *g, float *b, float *a);
  # const char *SDL_GetRenderDriver(int index)
  # SDL_Renderer * SDL_GetRendererFromTexture(SDL_Texture *texture);
  # int SDL_GetRenderLogicalPresentation(SDL_Renderer *renderer,
  #     int *w, int *h, SDL_RendererLogicalPresentation *mode,
  #     proc SDL_ScaleMode *scale_mode)
  # int SDL_GetRenderLogicalPresentationRect(SDL_Renderer *renderer, SDL_FRect *rect)
  # void *SDL_GetRenderMetalCommandEncoder(SDL_Renderer *renderer)
  # void *SDL_GetRenderMetalLayer(SDL_Renderer *renderer)
  # int SDL_GetRenderOutputSize(SDL_Renderer *renderer, int *w, int *h)
  # SDL_PropertiesID SDL_GetRendererProperties(SDL_Renderer *renderer)
  # int SDL_GetRenderSafeArea(SDL_Renderer *renderer, SDL_Rect *rect)
  # int SDL_GetRenderScale(SDL_Renderer *renderer,
  #     float *scaleX, float *scaleY)
  # SDL_Texture *SDL_GetRenderTarget(SDL_Renderer *renderer)
  # int SDL_GetRenderVSync(SDL_Renderer *renderer, int *vsync)
  # int SDL_GetRenderViewport(SDL_Renderer *renderer, SDL_Rect *rect)
  # SDL_Window *SDL_GetRenderWindow(SDL_Renderer *renderer)

  proc SDL_GetRenderer(window: Window): Renderer

  # const char * SDL_GetRendererName(SDL_Renderer *renderer)
  # int SDL_GetTextureAlphaMod(SDL_Texture *texture, Uint8 *alpha)
  # int SDL_GetTextureBlendMode(SDL_Texture *texture,
  #     proc SDL_BlendMode *blendMode)
  # int SDL_GetTextureColorMod(SDL_Texture *texture,
  #     Uint8 *r, Uint8 *g, Uint8 *b)
  # int SDL_GetTextureAlphaModFloat(SDL_Texture *texture, float *alpha);
  # int SDL_GetTextureColorModFloat(SDL_Texture *texture, float *r, float *g, float *b);

  proc SDL_GetTextureProperties(texture: Texture): PropertiesID

  # int SDL_GetTextureScaleMode(SDL_Texture *texture,
  #     proc SDL_ScaleMode *scaleMode)

  proc SDL_LockTexture(texture: Texture, rect: ptr Rect, pixels: ptr pointer,
                       pitch: ptr cint): cint

  proc SDL_LockTextureToSurface(texture: Texture, rect: ptr Rect,
                                surface: ptr SurfacePtr): cint

  proc SDL_GetTextureSize(texture: Texture, w, h: ptr cfloat): cint

  proc SDL_RenderClear(renderer: Renderer): cint

  # SDL_bool SDL_RenderClipEnabled(SDL_Renderer *renderer)

  proc SDL_RenderCoordinatesFromWindow(renderer: Renderer,
                                       window_x, window_y: cfloat,
                                       x, y: ptr cfloat): cint

  # int SDL_RenderCoordinatesToWindow(SDL_Renderer *renderer,
  #     float x, float y, float *window_x, float *window_y)

  proc SDL_RenderFillRect(renderer: Renderer, rect: ptr FRect): cint

  # int SDL_RenderFillRects(SDL_Renderer *renderer, const SDL_FRect *rects,
  #     int count)

  proc SDL_RenderGeometry(
    renderer      : Renderer,
    texture       : Texture,
    vertices      : ptr Vertex,
    num_vertices  : cint,
    indices       : ptr cint,
    num_indices   : cint
  ): cint

  # int SDL_RenderGeometryRaw(SDL_Renderer *renderer,
  #                            SDL_Texture *texture,
  #                            const float *xy, int xy_stride,
  #                            const SDL_Color *color, int color_stride,
  #                            const float *uv, int uv_stride,
  #                            int num_vertices,
  #                            const void *indices, int num_indices, int size_indices)

  proc SDL_RenderLine(
    renderer  : Renderer,
    x1        : cfloat,
    y1        : cfloat,
    x2        : cfloat,
    y2        : cfloat
  ): cint

  # int SDL_RenderLines(SDL_Renderer *renderer, const SDL_FPoint *points,
  #     int count)

  proc SDL_RenderPoint(renderer: Renderer, x, y: cfloat): cint

  # int SDL_RenderPoints(SDL_Renderer *renderer, const SDL_FPoint *points,
  #     int count)

  proc SDL_RenderPresent(renderer: Renderer)

  # int SDL_RenderReadPixels(SDL_Renderer *renderer, const SDL_Rect *rect)

  proc SDL_RenderRect(renderer: Renderer, rect: ptr FRect): cint

  # int SDL_RenderRects(SDL_Renderer *renderer, const SDL_FRect *rects,
  #     int count)

  proc SDL_RenderTexture(renderer: Renderer, texture: Texture,
                         srcrect, dstrect: ptr FRect): cint

  # int SDL_RenderTexture9Grid(SDL_Renderer *renderer, SDL_Texture *texture, const SDL_FRect *srcrect, float left_width, float right_width, float top_height, float bottom_height, float scale, const SDL_FRect *dstrect);

  proc SDL_RenderTextureRotated(
    renderer  : Renderer,
    texture   : Texture,
    srcrect   : ptr FRect,
    dstrect   : ptr FRect,
    angle     : cdouble,
    center    : ptr FPoint,
    flip      : FlipMode
  ): cint

  # int SDL_RenderTextureTiled(SDL_Renderer *renderer, SDL_Texture *texture, const SDL_FRect *srcrect, float scale, const SDL_FRect *dstrect)

  # SDL_bool SDL_RenderViewportSet(SDL_Renderer *renderer);

  proc SDL_SetRenderClipRect(renderer: Renderer, rect: ptr Rect): cint

  # int SDL_SetRenderColorScale(SDL_Renderer *renderer, float scale);

  proc SDL_SetRenderDrawBlendMode(
    renderer    : Renderer,
    blend_mode  : BlendMode
  ): cint

  proc SDL_SetRenderDrawColor(renderer: Renderer, r, g, b, a: byte): cint

  # int SDL_SetRenderDrawColorFloat(SDL_Renderer *renderer, float r, float g, float b, float a);

  # int SDL_SetRenderLogicalPresentation(SDL_Renderer *renderer,
  #     int w, int h, SDL_RendererLogicalPresentation mode,
  #     proc SDL_ScaleMode scale_mode)

  proc SDL_SetRenderScale(renderer: Renderer,
                          scale_x, scale_y: cfloat): cint

  proc SDL_SetRenderTarget(renderer: Renderer, texture: Texture): cint

  proc SDL_SetRenderVSync(renderer: Renderer, vsync: cint): cint

  proc SDL_SetRenderViewport(renderer: Renderer, rect: ptr Rect): cint

  proc SDL_SetTextureAlphaMod(texture: Texture, alpha: byte): cint

  # int SDL_SetTextureAlphaModFloat(SDL_Texture *texture, float alpha);

  proc SDL_SetTextureBlendMode(
    texture     : Texture,
    blend_mode  : BlendMode
  ): cint

  proc SDL_SetTextureColorMod(texture: Texture, r, g, b: byte): cint

  # int SDL_SetTextureColorModFloat(SDL_Texture *texture, float r, float g, float b);

  proc SDL_SetTextureScaleMode(texture: Texture,
                               scale_mode: ScaleMode): cint

  proc SDL_UnlockTexture(texture: Texture)

  # int SDL_UpdateNVTexture(SDL_Texture *texture, const SDL_Rect *rect,
  #                         const Uint8 *Yplane, int Ypitch,
  #                         const Uint8 *UVplane, int UVpitch)

  proc SDL_UpdateTexture(texture: Texture, rect: ptr Rect, pixels: pointer,
                         pitch: cint): cint

  # int SDL_UpdateYUVTexture(SDL_Texture *texture, const SDL_Rect *rect,
  #                          const Uint8 *Yplane, int Ypitch,
  #                          const Uint8 *Uplane, int Upitch,
  #                          const Uint8 *Vplane, int Vpitch)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_sensor.h>                                                       #
  # ------------------------------------------------------------------------- #

  # void SDL_CloseSensor(SDL_Sensor *sensor)
  # int SDL_GetSensorData(SDL_Sensor *sensor, float *data, int num_values)
  # SDL_Sensor *SDL_GetSensorFromInstanceID(SDL_SensorID instance_id)
  # SDL_SensorID SDL_GetSensorInstanceID(SDL_Sensor *sensor)

  # const char *SDL_GetSensorNameForID(SDL_SensorID instance_id)
  # SDL_SensorType SDL_GetSensorTypeForID(SDL_SensorID instance_id)
  # int SDL_GetSensorNonPortableTypeForID(SDL_SensorID instance_id)

  # const char *SDL_GetSensorName(SDL_Sensor *sensor)
  # int SDL_GetSensorNonPortableType(SDL_Sensor *sensor)
  # SDL_SensorType SDL_GetSensorType(SDL_Sensor *sensor)
  # SDL_SensorID *SDL_GetSensors(int *count)
  # SDL_Sensor *SDL_OpenSensor(SDL_SensorID instance_id)
  # void SDL_UpdateSensors(void)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_surface.h>                                                      #
  # ------------------------------------------------------------------------- #

  # int SDL_AddSurfaceAlternateImage(SDL_Surface *surface, SDL_Surface *image)
  # int SDL_BlitSurface (SDL_Surface *src, const SDL_Rect *srcrect,
  #     proc SDL_Surface *dst, const SDL_Rect *dstrect)
  # int SDL_BlitSurface9Grid(SDL_Surface *src, const SDL_Rect *srcrect, int left_width, int right_width, int top_height, int bottom_height, float scale, SDL_ScaleMode scaleMode, SDL_Surface *dst, const SDL_Rect *dstrect);
  # int SDL_BlitSurfaceScaled (SDL_Surface *src, const SDL_Rect *srcrect,
  #     proc SDL_Surface *dst, SDL_Rect *dstrect, SDL_ScaleMode scaleMode)
  # int SDL_BlitSurfaceTiled(SDL_Surface *src, const SDL_Rect *srcrect, SDL_Surface *dst, const SDL_Rect *dstrect)
  # int SDL_BlitSurfaceTiledWithScale(SDL_Surface *src, const SDL_Rect *srcrect, float scale, SDL_ScaleMode scaleMode, SDL_Surface *dst, const SDL_Rect *dstrect)
  # int SDL_BlitSurfaceUnchecked (SDL_Surface *src, const SDL_Rect *srcrect,
  #     proc SDL_Surface *dst, const SDL_Rect *dstrect)
  # int SDL_BlitSurfaceUncheckedScaled (SDL_Surface *src,
  #     const SDL_Rect *srcrect, SDL_Surface *dst, const SDL_Rect *dstrect, SDL_ScaleMode scaleMode)
  # int SDL_ConvertPixels(int width, int height, SDL_PixelFormatEnum src_format,
  #     const void *src, int src_pitch, SDL_PixelFormatEnum dst_format, void *dst,
  #     int dst_pitch)
  # int SDL_ConvertPixelsAndColorspace(int width, int height, SDL_PixelFormatEnum src_format, SDL_Colorspace src_colorspace, const void *src, int src_pitch, SDL_PixelFormatEnum dst_format, SDL_Colorspace dst_colorspace, void *dst, int dst_pitch);
  # SDL_Surface *SDL_ConvertSurface(SDL_Surface *surface,
  #     const SDL_PixelFormat *format)
  # SDL_Surface *SDL_ConvertSurfaceFormat(SDL_Surface *surface,
  #     SDL_PixelFormatEnum pixel_format)
  # SDL_Surface *SDL_ConvertSurfaceFormatAndColorspace(SDL_Surface *surface, SDL_PixelFormatEnum pixel_format, SDL_Colorspace colorspace);

  # SDL_Surface *SDL_CreateSurface (int width, int height, SDL_PixelFormatEnum format)

  proc SDL_CreateSurfaceFrom(width, height: cint, format: PixelFormatEnum,
                             pixels: pointer, pitch: cint): SurfacePtr

  # SDL_Palette * SDL_CreateSurfacePalette(SDL_Surface *surface)

  proc SDL_DestroySurface(surface: SurfacePtr)

  # SDL_Surface *SDL_DuplicateSurface(SDL_Surface *surface)
  # int SDL_FillSurfaceRect (SDL_Surface *dst, const SDL_Rect *rect,
  #     Uint32 color)
  # int SDL_FillSurfaceRects (SDL_Surface *dst, const SDL_Rect *rects,
  #     int count, Uint32 color)
  # int SDL_FlipSurface(SDL_Surface *surface, SDL_FlipMode flip);
  # int SDL_GetSurfaceAlphaMod(SDL_Surface *surface, Uint8 *alpha)
  # int SDL_GetSurfaceBlendMode(SDL_Surface *surface,
  #     proc SDL_BlendMode *blendMode)
  # int SDL_GetSurfaceClipRect(SDL_Surface *surface, SDL_Rect *rect)
  # int SDL_GetSurfaceColorKey(SDL_Surface *surface, Uint32 *key)
  # int SDL_GetSurfaceColorMod(SDL_Surface *surface,
  #     Uint8 *r, Uint8 *g, Uint8 *b)
  # SDL_Colorspace SDL_GetSurfaceColorspace(SDL_Surface *surface)
  # SDL_Surface ** SDL_GetSurfaceImages(SDL_Surface *surface, int *count)
  # SDL_Palette * SDL_GetSurfacePalette(SDL_Surface *surface)
  # SDL_PropertiesID SDL_GetSurfaceProperties(SDL_Surface *surface)

  proc SDL_LoadBMP(file: cstring): SurfacePtr

  proc SDL_LoadBMP_IO(src: IOStream, closeio: cint): SurfacePtr

  proc SDL_LockSurface(surface: SurfacePtr): cint

  # Uint32 SDL_MapSurfaceRGB(SDL_Surface *surface, Uint8 r, Uint8 g, Uint8 b)
  # Uint32 SDL_MapSurfaceRGBA(SDL_Surface *surface, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
  # int SDL_PremultiplyAlpha(int width, int height, SDL_PixelFormat src_format, const void *src, int src_pitch, SDL_PixelFormat dst_format, void *dst, int dst_pitch, SDL_bool linear)
  # int SDL_PremultiplySurfaceAlpha(SDL_Surface *surface, SDL_bool linear)

  # int SDL_ReadSurfacePixel(SDL_Surface *surface, int x, int y, Uint8 *r, Uint8 *g, Uint8 *b, Uint8 *a)
  # int SDL_ReadSurfacePixelFloat(SDL_Surface *surface, int x, int y, float *r, float *g, float *b, float *a)
  # void SDL_RemoveSurfaceAlternateImages(SDL_Surface *surface)

  proc SDL_SaveBMP(surface: SurfacePtr, file: cstring): cint

  proc SDL_SaveBMP_IO(surface: SurfacePtr, dst: IOStream, closeio: cint): cint

  # SDL_Surface * SDL_ScaleSurface(SDL_Surface *surface, int width, int height, SDL_ScaleMode scaleMode);
  # int SDL_SetSurfaceAlphaMod(SDL_Surface *surface, Uint8 alpha)
  # int SDL_SetSurfaceBlendMode(SDL_Surface *surface,
  #     proc SDL_BlendMode blendMode)
  # SDL_bool SDL_SetSurfaceClipRect(SDL_Surface *surface,
  #     const SDL_Rect *rect)

  proc SDL_SetSurfaceColorKey(surface: SurfacePtr, enabled: SdlBool,
                              key: uint32): cint

  # int SDL_SetSurfaceColorMod(SDL_Surface *surface,
  #     Uint8 r, Uint8 g, Uint8 b)
  # int SDL_SetSurfaceColorspace(SDL_Surface *surface, SDL_Colorspace colorspace)
  # int SDL_SetSurfacePalette(SDL_Surface *surface, SDL_Palette *palette)
  
  proc SDL_SetSurfaceRLE(surface: SurfacePtr, enabled: SdlBool): cint
  
  # int SDL_SoftStretch(SDL_Surface *src, const SDL_Rect *srcrect,
  #     proc SDL_Surface *dst, const SDL_Rect *dstrect, SDL_ScaleMode scaleMode)
  # SDL_bool SDL_SurfaceHasAlternateImages(SDL_Surface *surface)
  # SDL_bool SDL_SurfaceHasColorKey(SDL_Surface *surface)
  # SDL_bool SDL_SurfaceHasRLE(SDL_Surface *surface)

  proc SDL_UnlockSurface(surface: SurfacePtr)

  proc SDL_WriteSurfacePixel(surface: SurfacePtr, x: cint, y: cint,
                             r: byte, g: byte, b: byte, a: byte): cint

  # int SDL_WriteSurfacePixelFloat(SDL_Surface *surface, int x, int y, float r, float g, float b, float a)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_syswm.h>                                                        #
  # ------------------------------------------------------------------------- #

  # int SDL_GetWindowWMInfo(SDL_Window *window, SDL_SysWMinfo *info,
  #     Uint32 version)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_timer.h>                                                        #
  # ------------------------------------------------------------------------- #

  proc SDL_AddTimer(interval: uint32, callback: TimerCallback,
                    param: pointer): TimerID

  # SDL_TimerID SDL_AddTimerNS(Uint64 interval, SDL_NSTimerCallback callback, void *userdata)

  proc SDL_Delay(ms: uint32)

  proc SDL_DelayNS(ns: uint64)

  proc SDL_GetPerformanceCounter(): uint64

  proc SDL_GetPerformanceFrequency(): uint64

  proc SDL_GetTicks(): uint64

  proc SDL_GetTicksNS(): uint64

  proc SDL_RemoveTimer(id: TimerID): SdlBool

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_touch.h>                                                        #
  # ------------------------------------------------------------------------- #

  # TODO.

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_version.h>                                                      #
  # ------------------------------------------------------------------------- #

  proc SDL_GetRevision(): cstring

  proc SDL_GetVersion(): cint

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_video.h>                                                        #
  # ------------------------------------------------------------------------- #

  proc SDL_CreatePopupWindow(
    window    : Window,
    offset_x  : cint,
    offset_y  : cint,
    w         : cint,
    h         : cint,
    flags     : WindowFlags
  ): Window

  proc SDL_CreateWindow(
    title     : cstring,
    w         : cint,
    h         : cint,
    flags     : WindowFlags
  ): Window

  when use_properties:
    proc SDL_CreateWindowWithProperties(props: PropertiesID): Window

  proc SDL_DestroyWindow(window: Window)

  # int SDL_DestroyWindowSurface(SDL_Window *window)

  proc SDL_DisableScreenSaver(): cint

  # SDL_EGLConfig SDL_EGL_GetCurrentEGLConfig(void)
  # SDL_EGLDisplay SDL_EGL_GetCurrentEGLDisplay(void)
  # SDL_FunctionPointer SDL_EGL_GetProcAddress(const char *proc)
  # SDL_EGLSurface SDL_EGL_GetWindowEGLSurface(SDL_Window *window)
  # void SDL_EGL_SetEGLAttributeCallbacks(
  #     proc SDL_EGLAttribArrayCallback platformAttribCallback,
  #     proc SDL_EGLIntArrayCallback surfaceAttribCallback,
  #     proc SDL_EGLIntArrayCallback contextAttribCallback)

  proc SDL_EnableScreenSaver(): cint

  proc SDL_FlashWindow(
    window    : Window,
    operation : FlashOperation
  ): cint

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

  proc SDL_GetClosestFullscreenDisplayMode(display_id: DisplayID, w, h: cint,
                                           refresh_rate: cfloat,
                                           include_high_density_modes: SdlBool): ptr DisplayMode

  proc SDL_GetCurrentDisplayMode(display_id: DisplayID): ptr DisplayMode

  # SDL_DisplayOrientation SDL_GetCurrentDisplayOrientation(
  #     proc SDL_DisplayID displayID)

  proc SDL_GetCurrentVideoDriver(): cstring

  # const SDL_DisplayMode *SDL_GetDesktopDisplayMode(SDL_DisplayID displayID)

  proc SDL_GetDisplayBounds(display_id: DisplayID, rect: ptr Rect): cint

  proc SDL_GetDisplayContentScale(display_id: DisplayID): cfloat

  # SDL_DisplayID SDL_GetDisplayForPoint(const SDL_Point *point)
  # SDL_DisplayID SDL_GetDisplayForRect(const SDL_Rect *rect)

  proc SDL_GetDisplayForWindow(window: Window): DisplayID

  proc SDL_GetDisplayName(display_id: DisplayID): cstring

  # SDL_PropertiesID SDL_GetDisplayProperties(SDL_DisplayID displayID)

  proc SDL_GetDisplays(count: ptr cint): ptr UncheckedArray[DisplayID]

  proc SDL_GetDisplayUsableBounds(display_id: DisplayID, rect: ptr Rect): cint

  proc SDL_GetFullscreenDisplayModes(display_id: DisplayID,
                                     count: ptr cint): ptr UncheckedArray[ptr DisplayMode]

  proc SDL_GetGrabbedWindow(): Window

  # SDL_DisplayOrientation SDL_GetNaturalDisplayOrientation(
  #     proc SDL_DisplayID displayID)

  proc SDL_GetNumVideoDrivers(): cint

  proc SDL_GetPrimaryDisplay(): DisplayID

  # SDL_SystemTheme SDL_GetSystemTheme(void)
  # const char *SDL_GetVideoDriver(int index)

  # int SDL_GetWindowAspectRatio(SDL_Window *window, float *min_aspect, float *max_aspect)

  # int SDL_GetWindowBordersSize(SDL_Window *window, int *top, int *left,
  #     int *bottom, int *right)

  # float SDL_GetWindowDisplayScale(SDL_Window *window)

  proc SDL_GetWindowFlags(window: Window): WindowFlags

  # int SDL_SetWindowFocusable(SDL_Window *window, SDL_bool focusable)

  proc SDL_GetWindowFromID(id: WindowID): Window

  proc SDL_GetWindowFullscreenMode(window: Window): ptr DisplayMode

  # void *SDL_GetWindowICCProfile(SDL_Window *window, size_t *size)

  proc SDL_GetWindowID(window: Window): WindowID

  proc SDL_GetWindowKeyboardGrab(window: Window): SdlBool

  proc SDL_GetWindowMaximumSize(window: Window, w, h: ptr cint): cint

  proc SDL_GetWindowMinimumSize(window: Window, w, h: ptr cint): cint

  proc SDL_GetWindowMouseGrab(window: Window): SdlBool

  # SDL_GetWindowMouseRect(
  #   window: Window
  #): ptr Rect

  # int SDL_GetWindowOpacity(SDL_Window *window, float *out_opacity)
  # SDL_Window *SDL_GetWindowParent(SDL_Window *window)
  # float SDL_GetWindowPixelDensity(SDL_Window *window)

  proc SDL_GetWindowPixelFormat(window: Window): PixelFormatEnum

  proc SDL_GetWindowPosition(window: Window, x, y: ptr cint): cint

  # SDL_PropertiesID SDL_GetWindowProperties(SDL_Window *window)

  # SDL_Window ** SDLCALL SDL_GetWindows(int *count)

  # int SDL_GetWindowSafeArea(SDL_Window *window, SDL_Rect *rect);

  proc SDL_GetWindowSize(window: Window, width, height: ptr cint): cint

  # int SDL_GetWindowSizeInPixels(SDL_Window *window, int *w, int *h)
  # SDL_Surface *SDL_GetWindowSurface(SDL_Window *window)
  # int SDL_GetWindowSurfaceVSync(SDL_Window *window, int *vsync)
  # const char *SDL_GetWindowTitle(SDL_Window *window)

  proc SDL_HideWindow(window: Window): cint

  # int SDL_MaximizeWindow(SDL_Window *window)
  # int SDL_MinimizeWindow(SDL_Window *window)

  proc SDL_RaiseWindow(window: Window): cint

  # int SDL_RestoreWindow(SDL_Window *window)

  proc SDL_ScreenSaverEnabled(): SdlBool

  # int SDL_SetWindowAlwaysOnTop(SDL_Window *window, SDL_bool on_top)

  # int SDL_SetWindowAspectRatio(SDL_Window *window, float min_aspect, float max_aspect)

  proc SDL_SetWindowBordered(window: Window, bordered: SdlBool): cint

  # int SDL_SetWindowFocusable(SDL_Window *window, SDL_bool focusable)

  proc SDL_SetWindowFullscreen(window: Window, fullscreen: SdlBool): cint

  proc SDL_SetWindowFullscreenMode(window: Window,
                                   mode: ptr DisplayMode): cint

  # int SDL_SetWindowHitTest(SDL_Window *window, SDL_HitTest callback,
  #     void *callback_data)

  proc SDL_SetWindowIcon(window: Window, surface: SurfacePtr): cint

  proc SDL_SetWindowKeyboardGrab(window: Window, grabbed: SdlBool): cint

  proc SDL_SetWindowMaximumSize(window: Window, max_w, max_h: cint): cint

  proc SDL_SetWindowMinimumSize(window: Window, min_w, min_h: cint): cint

  # int SDL_SetWindowModalFor(SDL_Window *modal_window,
  #     proc SDL_Window *parent_window)

  proc SDL_SetWindowMouseGrab(window: Window, grabbed: SdlBool): cint

  # int SDL_SetWindowMouseRect(SDL_Window *window, const SDL_Rect *rect)
  # int SDL_SetWindowOpacity(SDL_Window *window, float opacity)

  proc SDL_SetWindowPosition(window: Window, x, y: cint): cint

  proc SDL_SetWindowResizable(window: Window, ontop: SdlBool): cint

  # int SDL_SetWindowShape(SDL_Window *window, SDL_Surface *shape);

  proc SDL_SetWindowSize(window: Window, x, y: cint): cint

  # int SDL_SetWindowSurfaceVSync(SDL_Window *window, int vsync)

  proc SDL_SetWindowTitle(window: Window, title: cstring): cint

  proc SDL_ShowWindow(window: Window): cint

  # int SDL_ShowWindowSystemMenu(SDL_Window *window, int x, int y)
  # int SDL_SyncWindow(SDL_Window *window)

  proc SDL_UpdateWindowSurface(window: Window): cint

  # int SDL_UpdateWindowSurfaceRects(SDL_Window *window,
  #     const SDL_Rect *rects, int numrects)

  # SDL_bool SDL_WindowHasSurface(SDL_Window *window)

  # ------------------------------------------------------------------------- #
  # <SDL3/SDL_vulkan.h>                                                       #
  # ------------------------------------------------------------------------- #

  # SDL_bool SDL_Vulkan_CreateSurface(SDL_Window *window,
  #     VkInstance instance, VkSurfaceKHR* surface)
  # SDL_bool SDL_Vulkan_GetInstanceExtensions(unsigned int *pCount,
  #     const char **pNames)
  # SDL_FunctionPointer SDL_Vulkan_GetVkGetInstanceProcAddr(void)
  # int SDL_Vulkan_LoadLibrary(const char *path)
  # void SDL_Vulkan_UnloadLibrary(void)

# =========================================================================== #
# ==  Loading/unloading functions                                          == #
# =========================================================================== #

# vim: set sts=2 et sw=2:
