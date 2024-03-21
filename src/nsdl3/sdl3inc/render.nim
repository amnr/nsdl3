##  Renderer definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from pixels import FColor, PixelFormatEnum
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
    num_texture_formats*  : cint                ##  The number of available
                                                ##  texture formats.
    texture_formats*      : array[16, PixelFormatEnum]  ##  Available texture formats.
    max_texture_width*    : cint                ##  Maximum texture width.
    max_texture_height*   : cint                ##  Maximum texture height.

  Vertex* {.final, pure.} = object
    ##  Vertex.
    position*   : FPoint    ##  Vertex position (`Renderer` coordinates).
    color*      : FColor    ##  Vertex color.
    tex_coord*  : FPoint    ##  Normalized texture coordinates (if needed).

func init*(T: typedesc[Vertex], pos: FPoint, color: FColor): T {.inline.} =
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
    PROP_RENDERER_CREATE_NAME_STRING                                = cstring"name"
    PROP_RENDERER_CREATE_WINDOW_POINTER                             = cstring"window"
    PROP_RENDERER_CREATE_SURFACE_POINTER                            = cstring"surface"
    PROP_RENDERER_CREATE_OUTPUT_COLORSPACE_NUMBER                   = cstring"output_colorspace"
    PROP_RENDERER_CREATE_PRESENT_VSYNC_BOOLEAN                      = cstring"present_vsync"
    PROP_RENDERER_CREATE_VULKAN_INSTANCE_POINTER                    = cstring"vulkan.instance"
    PROP_RENDERER_CREATE_VULKAN_SURFACE_NUMBER                      = cstring"vulkan.surface"
    PROP_RENDERER_CREATE_VULKAN_PHYSICAL_DEVICE_POINTER             = cstring"vulkan.physical_device"
    PROP_RENDERER_CREATE_VULKAN_DEVICE_POINTER                      = cstring"vulkan.device"
    PROP_RENDERER_CREATE_VULKAN_GRAPHICS_QUEUE_FAMILY_INDEX_NUMBER  = cstring"vulkan.graphics_queue_family_index"
    PROP_RENDERER_CREATE_VULKAN_PRESENT_QUEUE_FAMILY_INDEX_NUMBER   = cstring"vulkan.present_queue_family_index"

  RenderDeviceProperty* = enum
    PROP_RENDERER_NAME_STRING                               = cstring"SDL.renderer.name"
    PROP_RENDERER_WINDOW_POINTER                            = cstring"SDL.renderer.window"
    PROP_RENDERER_SURFACE_POINTER                           = cstring"SDL.renderer.surface"
    PROP_RENDERER_OUTPUT_COLORSPACE_NUMBER                  = cstring"SDL.renderer.output_colorspace"
    PROP_RENDERER_D3D9_DEVICE_POINTER                       = cstring"SDL.renderer.d3d9.device"
    PROP_RENDERER_D3D11_DEVICE_POINTER                      = cstring"SDL.renderer.d3d11.device"
    PROP_RENDERER_D3D12_DEVICE_POINTER                      = cstring"SDL.renderer.d3d12.device"
    PROP_RENDERER_D3D12_COMMAND_QUEUE_POINTER               = cstring"SDL.renderer.d3d12.command_queue"
    PROP_RENDERER_VULKAN_INSTANCE_POINTER                   = cstring"SDL.renderer.vulkan.instance"
    PROP_RENDERER_VULKAN_SURFACE_NUMBER                     = cstring"SDL.renderer.vulkan.surface"
    PROP_RENDERER_VULKAN_PHYSICAL_DEVICE_POINTER            = cstring"SDL.renderer.vulkan.physical_device"
    PROP_RENDERER_VULKAN_DEVICE_POINTER                     = cstring"SDL.renderer.vulkan.device"
    PROP_RENDERER_VULKAN_GRAPHICS_QUEUE_FAMILY_INDEX_NUMBER = cstring"SDL.renderer.vulkan.graphics_queue_family_index"
    PROP_RENDERER_VULKAN_PRESENT_QUEUE_FAMILY_INDEX_NUMBER  = cstring"SDL.renderer.vulkan.present_queue_family_index"
    PROP_RENDERER_VULKAN_SWAPCHAIN_IMAGE_COUNT_NUMBER       = cstring"SDL.renderer.vulkan.swapchain_image_count"

  TextureCreateProperty* = enum
    PROP_TEXTURE_CREATE_COLORSPACE_NUMBER           = cstring"colorspace"
    PROP_TEXTURE_CREATE_FORMAT_NUMBER               = cstring"format"
    PROP_TEXTURE_CREATE_ACCESS_NUMBER               = cstring"access"
    PROP_TEXTURE_CREATE_WIDTH_NUMBER                = cstring"width"
    PROP_TEXTURE_CREATE_HEIGHT_NUMBER               = cstring"height"
    PROP_TEXTURE_CREATE_D3D11_TEXTURE_POINTER       = cstring"d3d11.texture"
    PROP_TEXTURE_CREATE_D3D11_TEXTURE_U_POINTER     = cstring"d3d11.texture_u"
    PROP_TEXTURE_CREATE_D3D11_TEXTURE_V_POINTER     = cstring"d3d11.texture_v"
    PROP_TEXTURE_CREATE_D3D12_TEXTURE_POINTER       = cstring"d3d12.texture"
    PROP_TEXTURE_CREATE_D3D12_TEXTURE_U_POINTER     = cstring"d3d12.texture_u"
    PROP_TEXTURE_CREATE_D3D12_TEXTURE_V_POINTER     = cstring"d3d12.texture_v"
    PROP_TEXTURE_CREATE_METAL_PIXELBUFFER_POINTER   = cstring"metal.pixelbuffer"
    PROP_TEXTURE_CREATE_OPENGL_TEXTURE_NUMBER       = cstring"opengl.texture"
    PROP_TEXTURE_CREATE_OPENGL_TEXTURE_UV_NUMBER    = cstring"opengl.texture_uv"
    PROP_TEXTURE_CREATE_OPENGL_TEXTURE_U_NUMBER     = cstring"opengl.texture_u"
    PROP_TEXTURE_CREATE_OPENGL_TEXTURE_V_NUMBER     = cstring"opengl.texture_v"
    PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_NUMBER    = cstring"opengles2.texture"
    PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_UV_NUMBER = cstring"opengles2.texture_uv"
    PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_U_NUMBER  = cstring"opengles2.texture_u"
    PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_V_NUMBER  = cstring"opengles2.texture_v"
    PROP_TEXTURE_CREATE_VULKAN_TEXTURE_NUMBER       = cstring"vulkan.texture"

  TextureProperty* = enum
    PROP_TEXTURE_COLORSPACE_NUMBER            = cstring"SDL.texture.colorspace"
    PROP_TEXTURE_D3D11_TEXTURE_POINTER        = cstring"SDL.texture.d3d11.texture"
    PROP_TEXTURE_D3D11_TEXTURE_U_POINTER      = cstring"SDL.texture.d3d11.texture_u"
    PROP_TEXTURE_D3D11_TEXTURE_V_POINTER      = cstring"SDL.texture.d3d11.texture_v"
    PROP_TEXTURE_D3D12_TEXTURE_POINTER        = cstring"SDL.texture.d3d12.texture"
    PROP_TEXTURE_D3D12_TEXTURE_U_POINTER      = cstring"SDL.texture.d3d12.texture_u"
    PROP_TEXTURE_D3D12_TEXTURE_V_POINTER      = cstring"SDL.texture.d3d12.texture_v"
    PROP_TEXTURE_OPENGL_TEXTURE_NUMBER        = cstring"SDL.texture.opengl.texture"
    PROP_TEXTURE_OPENGL_TEXTURE_UV_NUMBER     = cstring"SDL.texture.opengl.texture_uv"
    PROP_TEXTURE_OPENGL_TEXTURE_U_NUMBER      = cstring"SDL.texture.opengl.texture_u"
    PROP_TEXTURE_OPENGL_TEXTURE_V_NUMBER      = cstring"SDL.texture.opengl.texture_v"
    PROP_TEXTURE_OPENGL_TEXTURE_TARGET        = cstring"SDL.texture.opengl.target"
    PROP_TEXTURE_OPENGL_TEX_W_FLOAT           = cstring"SDL.texture.opengl.tex_w"
    PROP_TEXTURE_OPENGL_TEX_H_FLOAT           = cstring"SDL.texture.opengl.tex_h"
    PROP_TEXTURE_OPENGLES2_TEXTURE_NUMBER     = cstring"SDL.texture.opengles2.texture"
    PROP_TEXTURE_OPENGLES2_TEXTURE_UV_NUMBER  = cstring"SDL.texture.opengles2.texture_uv"
    PROP_TEXTURE_OPENGLES2_TEXTURE_U_NUMBER   = cstring"SDL.texture.opengles2.texture_u"
    PROP_TEXTURE_OPENGLES2_TEXTURE_V_NUMBER   = cstring"SDL.texture.opengles2.texture_v"
    PROP_TEXTURE_OPENGLES2_TEXTURE_TARGET     = cstring"SDL.texture.opengles2.target"
    PROP_TEXTURE_VULKAN_TEXTURE_NUMBER        = cstring"SDL.texture.vulkan.texture"

# --------------------------------------------------------------------------- #
#   Sanity checks                                                             #
# --------------------------------------------------------------------------- #

when defined(gcc) and hostCPU == "amd64":
  when RendererInfo.sizeof != 88:
    {.fatal: "invalid RendererInfo size: " & $RendererInfo.sizeof.}

# vim: set sts=2 et sw=2:
