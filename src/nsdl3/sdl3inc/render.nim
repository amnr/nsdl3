##  Renderer definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from pixels import Color
from rect import FPoint

type
  RendererFlags* = distinct uint32
    ##  Renderer flags.

func `or`*(a, b: RendererFlags): RendererFlags {.borrow.}

const
  RENDERER_SOFTWARE*      = RendererFlags 0x00000001
  RENDERER_ACCELERATED*   = RendererFlags 0x00000002
  RENDERER_PRESENTVSYNC*  = RendererFlags 0x00000004

type
  RendererInfo* {.final, pure.} = object
    ##  Information on the capabilities of a render driver or context.
    name*                 : cstring             ##  Renderer name.
    flags*                : RendererFlags       ##  Supported flags.
    num_texture_formats*  : uint32              ##  The number of available
                                                ##  texture formats.
    texture_formats*      : array[16, uint32]   ##  Available texture formats.
    max_texture_width*    : cint                ##  Maximum texture width.
    max_texture_height*   : cint                ##  Maximum texture height.

  Vertex* {.final, pure.} = object
    ##  Vertex.
    position*   : FPoint    ##  Vertex position (`Renderer` coordinates).
    color*      : Color     ##  Vertex color.
    tex_coord*  : FPoint    ##  Normalized texture coordinates (if needed).

func init*(T: typedesc[Vertex], pos: FPoint, color: Color): T {.inline.} =
  T(position: pos, color: color, tex_coord: FPoint(x: 0, y: 0))

type
  TextureAccess* {.size: cint.sizeof.} = enum
    ##  Texture access pattern allowed.
    TEXTUREACCESS_STATIC      ##  Changes rarely, not lockable.
    TEXTUREACCESS_STREAMING   ##  Changes frequently, lockable.
    TEXTUREACCESS_TARGET      ##  Texture can be used as a render target.

  RendererFlip* {.size: cint.sizeof.} = enum
    ##  Flip constants for `copy_ex()`.
    FLIP_NONE         = 0x00000000    ##  Do not flip.
    FLIP_HORIZONTAL   = 0x00000001    ##  Flip horizontally.
    FLIP_VERTICAL     = 0x00000002    ##  Flip vertically.

  RendererLogicalPresentation* {.size: cint.sizeof.} = enum   # XXX: size
    ##  Logical size mapped to the output.
    LOGICAL_PRESENTATION_DISABLED
    LOGICAL_PRESENTATION_STRETCH
    LOGICAL_PRESENTATION_LETTERBOX
    LOGICAL_PRESENTATION_OVERSCAN
    LOGICAL_PRESENTATION_INTEGER_SCALE

  Renderer* = ptr object
    ##  Rendering state.

  Texture* = ptr object
    ##  Texture.

  RenderCreateProperty* = enum
    ##  Render property.
    PROPERTY_RENDERER_CREATE_WINDOW_POINTER         = cstring"window"
    PROPERTY_RENDERER_CREATE_SURFACE_POINTER        = cstring"surface"
    PROPERTY_RENDERER_CREATE_NAME_STRING            = cstring"name"
    PROPERTY_RENDERER_CREATE_PRESENT_VSYNC_BOOLEAN  = cstring"present_vsync"

  RenderDeviceProperty* = enum
    PROPERTY_RENDERER_D3D9_DEVICE_POINTER           = cstring"SDL.renderer.d3d9.device"
    PROPERTY_RENDERER_D3D11_DEVICE_POINTER          = cstring"SDL.renderer.d3d11.device"
    PROPERTY_RENDERER_D3D12_DEVICE_POINTER          = cstring"SDL.renderer.d3d12.device"
    PROPERTY_RENDERER_D3D12_COMMAND_QUEUE_POINTER   = cstring"SDL.renderer.d3d12.command_queue"

  TextureCreateProperty* = enum
    PROPERTY_TEXTURE_CREATE_FORMAT_NUMBER               = cstring"format"
    PROPERTY_TEXTURE_CREATE_ACCESS_NUMBER               = cstring"access"
    PROPERTY_TEXTURE_CREATE_WIDTH_NUMBER                = cstring"width"
    PROPERTY_TEXTURE_CREATE_HEIGHT_NUMBER               = cstring"height"
    PROPERTY_TEXTURE_CREATE_D3D11_TEXTURE_POINTER       = cstring"d3d11.texture"
    PROPERTY_TEXTURE_CREATE_D3D11_TEXTURE_U_POINTER     = cstring"d3d11.texture_u"
    PROPERTY_TEXTURE_CREATE_D3D11_TEXTURE_V_POINTER     = cstring"d3d11.texture_v"
    PROPERTY_TEXTURE_CREATE_D3D12_TEXTURE_POINTER       = cstring"d3d12.texture"
    PROPERTY_TEXTURE_CREATE_D3D12_TEXTURE_U_POINTER     = cstring"d3d12.texture_u"
    PROPERTY_TEXTURE_CREATE_D3D12_TEXTURE_V_POINTER     = cstring"d3d12.texture_v"
    PROPERTY_TEXTURE_CREATE_OPENGL_TEXTURE_NUMBER       = cstring"opengl.texture"
    PROPERTY_TEXTURE_CREATE_OPENGL_TEXTURE_UV_NUMBER    = cstring"opengl.texture_uv"
    PROPERTY_TEXTURE_CREATE_OPENGL_TEXTURE_U_NUMBER     = cstring"opengl.texture_u"
    PROPERTY_TEXTURE_CREATE_OPENGL_TEXTURE_V_NUMBER     = cstring"opengl.texture_v"
    PROPERTY_TEXTURE_CREATE_OPENGLES2_TEXTURE_NUMBER    = cstring"opengles2.texture"
    PROPERTY_TEXTURE_CREATE_OPENGLES2_TEXTURE_UV_NUMBER = cstring"opengles2.texture_uv"
    PROPERTY_TEXTURE_CREATE_OPENGLES2_TEXTURE_U_NUMBER  = cstring"opengles2.texture_u"
    PROPERTY_TEXTURE_CREATE_OPENGLES2_TEXTURE_V_NUMBER  = cstring"opengles2.texture_v"

  TextureProperty* = enum
    PROPERTY_TEXTURE_D3D11_TEXTURE_POINTER              = cstring"SDL.texture.d3d11.texture"
    PROPERTY_TEXTURE_D3D11_TEXTURE_U_POINTER            = cstring"SDL.texture.d3d11.texture_u"
    PROPERTY_TEXTURE_D3D11_TEXTURE_V_POINTER            = cstring"SDL.texture.d3d11.texture_v"
    PROPERTY_TEXTURE_D3D12_TEXTURE_POINTER              = cstring"SDL.texture.d3d12.texture"
    PROPERTY_TEXTURE_D3D12_TEXTURE_U_POINTER            = cstring"SDL.texture.d3d12.texture_u"
    PROPERTY_TEXTURE_D3D12_TEXTURE_V_POINTER            = cstring"SDL.texture.d3d12.texture_v"
    PROPERTY_TEXTURE_OPENGL_TEXTURE_NUMBER              = cstring"SDL.texture.opengl.texture"
    PROPERTY_TEXTURE_OPENGL_TEXTURE_UV_NUMBER           = cstring"SDL.texture.opengl.texture_uv"
    PROPERTY_TEXTURE_OPENGL_TEXTURE_U_NUMBER            = cstring"SDL.texture.opengl.texture_u"
    PROPERTY_TEXTURE_OPENGL_TEXTURE_V_NUMBER            = cstring"SDL.texture.opengl.texture_v"
    PROPERTY_TEXTURE_OPENGL_TEXTURE_TARGET              = cstring"SDL.texture.opengl.target"
    PROPERTY_TEXTURE_OPENGL_TEX_W_FLOAT                 = cstring"SDL.texture.opengl.tex_w"
    PROPERTY_TEXTURE_OPENGL_TEX_H_FLOAT                 = cstring"SDL.texture.opengl.tex_h"
    PROPERTY_TEXTURE_OPENGLES2_TEXTURE_NUMBER           = cstring"SDL.texture.opengles2.texture"
    PROPERTY_TEXTURE_OPENGLES2_TEXTURE_UV_NUMBER        = cstring"SDL.texture.opengles2.texture_uv"
    PROPERTY_TEXTURE_OPENGLES2_TEXTURE_U_NUMBER         = cstring"SDL.texture.opengles2.texture_u"
    PROPERTY_TEXTURE_OPENGLES2_TEXTURE_V_NUMBER         = cstring"SDL.texture.opengles2.texture_v"
    PROPERTY_TEXTURE_OPENGLES2_TEXTURE_TARGET           = cstring"SDL.texture.opengles2.target"

# --------------------------------------------------------------------------- #
#   Sanity checks                                                             #
# --------------------------------------------------------------------------- #

when defined(gcc) and hostCPU == "amd64":
  when RendererInfo.sizeof != 88:
    {.fatal: "invalid RendererInfo size: " & $RendererInfo.sizeof.}

# vim: set sts=2 et sw=2:
