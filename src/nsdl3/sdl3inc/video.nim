##  Video definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from pixels import PixelFormatEnum
from rect import Point

type
  DisplayID* = distinct uint32
    ##  Display ID.

func `==`*(a, b: DisplayID): bool {.borrow.}

type
  WindowID* = distinct uint32
    ##  Window ID.

func `==`*(a, b: WindowID): bool {.borrow.}

type
  PropGlobalVideo* = enum
    PROP_GLOBAL_VIDEO_WAYLAND_WL_DISPLAY_POINTER  = cstring"video.wayland.wl_display"

type
  SystemTheme* {.size: cint.sizeof.} = enum   # XXX size
    ##  System theme.
    SYSTEM_THEME_UNKNOWN
    SYSTEM_THEME_LIGHT
    SYSTEM_THEME_DARK

  DisplayMode* {.bycopy, final, pure.} = object
    ##  Display mode.
    display_id*     : DisplayID   ##  Display mode.
    format*         : PixelFormatEnum   ##  Pixel format.
    w*              : cint        ##  Screen width.
    h*              : cint        ##  Screen height.
    pixel_density*  : cfloat      ##  Size to pixels scale.
    refresh_rate*   : cfloat      ##  Refresh rate (0 - unspecified).
    driverdata      : pointer     ##  Driver-specific data, init. to `nil`.

  DisplayOrientation* {.size: cint.sizeof.} = enum    # XXX size
    ##  Display orientation.
    ORIENTATION_UNKNOWN
    ORIENTATION_LANDSCAPE
    ORIENTATION_LANDSCAPE_FLIPPED
    ORIENTATION_PORTRAIT
    ORIENTATION_PORTRAIT_FLIPPED 

  Window* = ptr object
    ##  Window.

type
  WindowFlags* = distinct uint32
    ##  Window flags.

func `and`*(a, b: WindowFlags): WindowFlags {.borrow.}
func `or`*(a, b: WindowFlags): WindowFlags {.borrow.}

func `==`*(a, b: WindowFlags): bool {.borrow.}
func `==`*(a: WindowFlags, b: uint32): bool {.borrow.}

const
  WINDOW_FULLSCREEN*          = WindowFlags 0x00000001
  WINDOW_OPENGL*              = WindowFlags 0x00000002
  WINDOW_OCCLUDED*            = WindowFlags 0x00000004
  WINDOW_HIDDEN*              = WindowFlags 0x00000008
  WINDOW_BORDERLESS*          = WindowFlags 0x00000010
  WINDOW_RESIZABLE*           = WindowFlags 0x00000020
  WINDOW_MINIMIZED*           = WindowFlags 0x00000040
  WINDOW_MAXIMIZED*           = WindowFlags 0x00000080
  WINDOW_MOUSE_GRABBED*       = WindowFlags 0x00000100
  WINDOW_INPUT_FOCUS*         = WindowFlags 0x00000200
  WINDOW_MOUSE_FOCUS*         = WindowFlags 0x00000400
  WINDOW_EXTERNAL*            = WindowFlags 0x00000800
  WINDOW_HIGH_PIXEL_DENSITY*  = WindowFlags 0x00002000
  WINDOW_MOUSE_CAPTURE*       = WindowFlags 0x00004000
  WINDOW_ALWAYS_ON_TOP*       = WindowFlags 0x00008000
  WINDOW_SKIP_TASKBAR*        = WindowFlags 0x00010000
  WINDOW_UTILITY*             = WindowFlags 0x00020000
  WINDOW_TOOLTIP*             = WindowFlags 0x00040000
  WINDOW_POPUP_MENU*          = WindowFlags 0x00080000
  WINDOW_KEYBOARD_GRABBED*    = WindowFlags 0x00100000
  WINDOW_VULKAN*              = WindowFlags 0x10000000
  WINDOW_METAL*               = WindowFlags 0x20000000
  WINDOW_TRANSPARENT*         = WindowFlags 0x40000000
  WINDOW_NOT_FOCUSABLE*       = WindowFlags 0x80000000

# XXX
#  WINDOW_FULLSCREEN_DESKTOP*  = WINDOW_FULLSCREEN or WindowFlags 0x00001000
#  WINDOW_INPUT_GRABBED*       = WINDOW_MOUSE_GRABBED

# Window positions.

const WINDOWPOS_UNDEFINED_MASK = 0x1fff_0000'u32

func WINDOWPOS_UNDEFINED_DISPLAY(x: uint32): uint32 {.inline.} =
  WINDOWPOS_UNDEFINED_MASK or x

const WINDOWPOS_UNDEFINED* = int WINDOWPOS_UNDEFINED_DISPLAY 0

template windowpos_isundefined*(x: uint32): bool =
  (x and 0xffff_0000'u32) == WINDOWPOS_UNDEFINED_MASK

const WINDOWPOS_CENTERED_MASK = 0x2fff_0000'u32

func windowpos_centered_display*(x: DisplayID): uint32 {.inline.} =
  WINDOWPOS_CENTERED_MASK or x.uint32

func windowpos_centered_display*(x: uint32): uint32 {.inline.} =
  WINDOWPOS_CENTERED_MASK or x

const WINDOWPOS_CENTERED* = int windowpos_centered_display 0

template windowpos_iscentered*(x: uint32): bool =
  (x and 0xffff_0000'u32) == WINDOWPOS_CENTERED_MASK

type
  FlashOperation* {.size: cint.sizeof.} = enum    # XXX: size
    ##  Window flash operation.
    FLASH_CANCEL
    FLASH_BRIEFLY
    FLASH_UNTIL_FOCUSED

type
  GLContext*    = ptr object
    ##  OpenGL context.

  EGLDisplay*   = ptr object
  EGLConfig*    = ptr object
  EGLSurface*   = ptr object
  EGLAttrib*    = ptr cint     # XXX: distinct
  EGLint*       = distinct cint

type
  EGLAttribArrayCallback* = proc (): ptr EGLAttrib  {.cdecl.}
  EGLIntArrayCallback*    = proc (): ptr EGLint     {.cdecl.}

type
  GLattr* {.pure, size: cint.sizeof} = enum   # XXX: size
    ##  OpenGL configuration attributes.
    GL_RED_SIZE
    GL_GREEN_SIZE
    GL_BLUE_SIZE
    GL_ALPHA_SIZE
    GL_BUFFER_SIZE
    GL_DOUBLEBUFFER
    GL_DEPTH_SIZE
    GL_STENCIL_SIZE
    GL_ACCUM_RED_SIZE
    GL_ACCUM_GREEN_SIZE
    GL_ACCUM_BLUE_SIZE
    GL_ACCUM_ALPHA_SIZE
    GL_STEREO
    GL_MULTISAMPLEBUFFERS
    GL_MULTISAMPLESAMPLES
    GL_ACCELERATED_VISUAL
    GL_RETAINED_BACKING
    GL_CONTEXT_MAJOR_VERSION
    GL_CONTEXT_MINOR_VERSION
    GL_CONTEXT_FLAGS
    GL_CONTEXT_PROFILE_MASK
    GL_SHARE_WITH_CURRENT_CONTEXT
    GL_FRAMEBUFFER_SRGB_CAPABLE
    GL_CONTEXT_RELEASE_BEHAVIOR
    GL_CONTEXT_RESET_NOTIFICATION
    GL_CONTEXT_NO_ERROR
    GL_FLOATBUFFERS
    GL_EGL_PLATFORM

  GLprofile* {.size: cint.sizeof} = enum      # XXX: size
    GL_CONTEXT_PROFILE_CORE           = 0x0001
    GL_CONTEXT_PROFILE_COMPATIBILITY  = 0x0002
    GL_CONTEXT_PROFILE_ES             = 0x0004

  GLcontextFlag* {.size: cint.sizeof} = enum  # XXX: size
    GL_CONTEXT_DEBUG_FLAG              = 0x0001
    GL_CONTEXT_FORWARD_COMPATIBLE_FLAG = 0x0002
    GL_CONTEXT_ROBUST_ACCESS_FLAG      = 0x0004
    GL_CONTEXT_RESET_ISOLATION_FLAG    = 0x0008

  GLcontextReleaseFlag* {.size: cint.sizeof} = enum         # XXX: size
    GL_CONTEXT_RELEASE_BEHAVIOR_NONE   = 0x0000
    GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH  = 0x0001

  GLContextResetNotification* {.size: cint.sizeof} = enum   # XXX: size
    GL_CONTEXT_RESET_NO_NOTIFICATION = 0x0000
    GL_CONTEXT_RESET_LOSE_CONTEXT    = 0x0001

#define SDL_PROP_DISPLAY_HDR_ENABLED_BOOLEAN            "SDL.display.HDR_enabled"
#define SDL_PROP_DISPLAY_SDR_WHITE_LEVEL_FLOAT          "SDL.display.SDR_white_level"

type
  WindowBooleanProperty* = enum
    PROP_WINDOW_CREATE_ALWAYS_ON_TOP_BOOLEAN                = cstring"always-on-top"
    PROP_WINDOW_CREATE_BORDERLESS_BOOLEAN                   = cstring"borderless"
    PROP_WINDOW_CREATE_FOCUSABLE_BOOLEAN                    = cstring"focusable"
    PROP_WINDOW_CREATE_FULLSCREEN_BOOLEAN                   = cstring"fullscreen"
    PROP_WINDOW_CREATE_HEIGHT_NUMBER                        = cstring"height"
    PROP_WINDOW_CREATE_HIDDEN_BOOLEAN                       = cstring"hidden"
    PROP_WINDOW_CREATE_HIGH_PIXEL_DENSITY_BOOLEAN           = cstring"high-pixel-density"
    PROP_WINDOW_CREATE_MAXIMIZED_BOOLEAN                    = cstring"maximized"
    PROP_WINDOW_CREATE_MENU_BOOLEAN                         = cstring"menu"
    PROP_WINDOW_CREATE_METAL_BOOLEAN                        = cstring"metal"
    PROP_WINDOW_CREATE_MINIMIZED_BOOLEAN                    = cstring"minimized"
    PROP_WINDOW_CREATE_MOUSE_GRABBED_BOOLEAN                = cstring"mouse-grabbed"
    PROP_WINDOW_CREATE_OPENGL_BOOLEAN                       = cstring"opengl"
    PROP_WINDOW_CREATE_PARENT_POINTER                       = cstring"parent"
    PROP_WINDOW_CREATE_RESIZABLE_BOOLEAN                    = cstring"resizable"
    PROP_WINDOW_CREATE_TITLE_STRING                         = cstring"title"
    PROP_WINDOW_CREATE_TRANSPARENT_BOOLEAN                  = cstring"transparent"
    PROP_WINDOW_CREATE_TOOLTIP_BOOLEAN                      = cstring"tooltip"
    PROP_WINDOW_CREATE_UTILITY_BOOLEAN                      = cstring"utility"
    PROP_WINDOW_CREATE_VULKAN_BOOLEAN                       = cstring"vulkan"
    PROP_WINDOW_CREATE_WIDTH_NUMBER                         = cstring"width"
    PROP_WINDOW_CREATE_X_NUMBER                             = cstring"x"
    PROP_WINDOW_CREATE_Y_NUMBER                             = cstring"y"
    PROP_WINDOW_CREATE_COCOA_WINDOW_POINTER                 = cstring"cocoa.window"
    PROP_WINDOW_CREATE_COCOA_VIEW_POINTER                   = cstring"cocoa.view"
    PROP_WINDOW_CREATE_WAYLAND_SCALE_TO_DISPLAY             = cstring"wayland.scale_to_display"
    PROP_WINDOW_CREATE_WAYLAND_SURFACE_ROLE_CUSTOM_BOOLEAN  = cstring"wayland.surface_role_custom"
    PROP_WINDOW_CREATE_WAYLAND_CREATE_EGL_WINDOW_BOOLEAN    = cstring"wayland.create_egl_window"
    PROP_WINDOW_CREATE_WAYLAND_WL_SURFACE_POINTER           = cstring"wayland.wl_surface"
    PROP_WINDOW_CREATE_WIN32_HWND_POINTER                   = cstring"win32.hwnd"
    PROP_WINDOW_CREATE_WIN32_PIXEL_FORMAT_HWND_POINTER      = cstring"win32.pixel_format_hwnd"
    PROP_WINDOW_CREATE_X11_WINDOW_NUMBER                    = cstring"x11.window"

type
  WindowPointerProperty* = enum
    PROP_WINDOW_SHAPE_POINTER                   = cstring"SDL.window.shape"
    PROP_WINDOW_ANDROID_WINDOW_POINTER          = cstring"SDL.window.android.window"
    PROP_WINDOW_ANDROID_SURFACE_POINTER         = cstring"SDL.window.android.surface"
    PROP_WINDOW_UIKIT_WINDOW_POINTER            = cstring"SDL.window.uikit.window"
    PROP_WINDOW_UIKIT_METAL_VIEW_TAG_NUMBER     = cstring"SDL.window.uikit.metal_view_tag"
    PROP_WINDOW_KMSDRM_DEVICE_INDEX_NUMBER      = cstring"SDL.window.kmsdrm.dev_index"
    PROP_WINDOW_KMSDRM_DRM_FD_NUMBER            = cstring"SDL.window.kmsdrm.drm_fd"
    PROP_WINDOW_KMSDRM_GBM_DEVICE_POINTER       = cstring"SDL.window.kmsdrm.gbm_dev"
    PROP_WINDOW_COCOA_WINDOW_POINTER            = cstring"SDL.window.cocoa.window"
    PROP_WINDOW_COCOA_METAL_VIEW_TAG_NUMBER     = cstring"SDL.window.cocoa.metal_view_tag"
    PROP_WINDOW_VIVANTE_DISPLAY_POINTER         = cstring"SDL.window.vivante.display"
    PROP_WINDOW_VIVANTE_WINDOW_POINTER          = cstring"SDL.window.vivante.window"
    PROP_WINDOW_VIVANTE_SURFACE_POINTER         = cstring"SDL.window.vivante.surface"
    PROP_WINDOW_WINRT_WINDOW_POINTER            = cstring"SDL.window.winrt.window"
    PROP_WINDOW_WIN32_HWND_POINTER              = cstring"SDL.window.win32.hwnd"
    PROP_WINDOW_WIN32_HDC_POINTER               = cstring"SDL.window.win32.hdc"
    PROP_WINDOW_WIN32_INSTANCE_POINTER          = cstring"SDL.window.win32.instance"
    PROP_WINDOW_WAYLAND_DISPLAY_POINTER         = cstring"SDL.window.wayland.display"
    PROP_WINDOW_WAYLAND_SURFACE_POINTER         = cstring"SDL.window.wayland.surface"
    PROP_WINDOW_WAYLAND_EGL_WINDOW_POINTER      = cstring"SDL.window.wayland.egl_window"
    PROP_WINDOW_WAYLAND_XDG_SURFACE_POINTER     = cstring"SDL.window.wayland.xdg_surface"
    PROP_WINDOW_WAYLAND_XDG_TOPLEVEL_POINTER    = cstring"SDL.window.wayland.xdg_toplevel"
    PROP_WINDOW_WAYLAND_XDG_TOPLEVEL_EXPORT_HANDLE_POINTER  = cstring"SDL.window.wayland.xdg_toplevel_export_handle"
    PROP_WINDOW_WAYLAND_XDG_POPUP_POINTER       = cstring"SDL.window.wayland.xdg_popup"
    PROP_WINDOW_WAYLAND_XDG_POSITIONER_POINTER  = cstring"SDL.window.wayland.xdg_positioner"
    PROP_WINDOW_X11_DISPLAY_POINTER             = cstring"SDL.window.x11.display"
    PROP_WINDOW_X11_SCREEN_NUMBER               = cstring"SDL.window.x11.screen"
    PROP_WINDOW_X11_WINDOW_NUMBER               = cstring"SDL.window.x11.window"

type
  HitTestResult* {.size: cint.sizeof.} = enum   # XXX: size
    HITTEST_NORMAL
    HITTEST_DRAGGABLE
    HITTEST_RESIZE_TOPLEFT
    HITTEST_RESIZE_TOP
    HITTEST_RESIZE_TOPRIGHT
    HITTEST_RESIZE_RIGHT
    HITTEST_RESIZE_BOTTOMRIGHT
    HITTEST_RESIZE_BOTTOM
    HITTEST_RESIZE_BOTTOMLEFT
    HITTEST_RESIZE_LEFT

  HitTest* = proc (win: ptr Window, area: ptr Point,
                   data: pointer): HitTestResult {.cdecl.}
    ##  Callback for hit testing.

# --------------------------------------------------------------------------- #
#   Sanity checks                                                             #
# --------------------------------------------------------------------------- #

when defined(gcc) and hostCPU == "amd64":
  when DisplayMode.sizeof != 32:
    {.error: "invalid DisplayMode size: " & $DisplayMode.sizeof.}

# vim: set sts=2 et sw=2:
