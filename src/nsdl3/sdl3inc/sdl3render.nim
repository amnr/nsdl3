##  Renderer definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from sdl3pixels import FColor, PixelFormatEnum
from sdl3rect import FPoint

const
  SOFTWARE_RENDERER*  = cstring"software"
    ##  Software renderer name.

type
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
    PROP_RENDERER_CREATE_NAME_STRING                                = cstring"SDL.renderer.create.name"
    PROP_RENDERER_CREATE_WINDOW_POINTER                             = cstring"SDL.renderer.create.window"
    PROP_RENDERER_CREATE_SURFACE_POINTER                            = cstring"SDL.renderer.create.surface"
    PROP_RENDERER_CREATE_OUTPUT_COLORSPACE_NUMBER                   = cstring"SDL.renderer.create.output_colorspace"
    PROP_RENDERER_CREATE_PRESENT_VSYNC_NUMBER                       = cstring"SDL.renderer.create.present_vsync"
    PROP_RENDERER_CREATE_VULKAN_INSTANCE_POINTER                    = cstring"SDL.renderer.create.vulkan.instance"
    PROP_RENDERER_CREATE_VULKAN_SURFACE_NUMBER                      = cstring"SDL.renderer.create.vulkan.surface"
    PROP_RENDERER_CREATE_VULKAN_PHYSICAL_DEVICE_POINTER             = cstring"SDL.renderer.create.vulkan.physical_device"
    PROP_RENDERER_CREATE_VULKAN_DEVICE_POINTER                      = cstring"SDL.renderer.create.vulkan.device"
    PROP_RENDERER_CREATE_VULKAN_GRAPHICS_QUEUE_FAMILY_INDEX_NUMBER  = cstring"SDL.renderer.create.vulkan.graphics_queue_family_index"
    PROP_RENDERER_CREATE_VULKAN_PRESENT_QUEUE_FAMILY_INDEX_NUMBER   = cstring"SDL.renderer.create.vulkan.present_queue_family_index"

  RenderDeviceProperty* = enum
    PROP_RENDERER_NAME_STRING                               = cstring"SDL.renderer.name"
    PROP_RENDERER_WINDOW_POINTER                            = cstring"SDL.renderer.window"
    PROP_RENDERER_SURFACE_POINTER                           = cstring"SDL.renderer.surface"
    PROP_RENDERER_VSYNC_NUMBER                              = cstring"SDL.renderer.vsync"
    PROP_RENDERER_MAX_TEXTURE_SIZE_NUMBER                   = cstring"SDL.renderer.max_texture_size"
    PROP_RENDERER_TEXTURE_FORMATS_POINTER                   = cstring"SDL.renderer.texture_formats"
    PROP_RENDERER_OUTPUT_COLORSPACE_NUMBER                  = cstring"SDL.renderer.output_colorspace"
    PROP_RENDERER_HDR_ENABLED_BOOLEAN                       = cstring"SDL.renderer.HDR_enabled"
    PROP_RENDERER_SDR_WHITE_POINT_FLOAT                     = cstring"SDL.renderer.SDR_white_point"
    PROP_RENDERER_HDR_HEADROOM_FLOAT                        = cstring"SDL.renderer.HDR_headroom"
    PROP_RENDERER_D3D9_DEVICE_POINTER                       = cstring"SDL.renderer.d3d9.device"
    PROP_RENDERER_D3D11_DEVICE_POINTER                      = cstring"SDL.renderer.d3d11.device"
    PROP_RENDERER_D3D11_SWAPCHAIN_POINTER                   = cstring"SDL.renderer.d3d11.swap_chain"
    PROP_RENDERER_D3D12_DEVICE_POINTER                      = cstring"SDL.renderer.d3d12.device"
    PROP_RENDERER_D3D12_SWAPCHAIN_POINTER                   = cstring"SDL.renderer.d3d12.swap_chain"
    PROP_RENDERER_D3D12_COMMAND_QUEUE_POINTER               = cstring"SDL.renderer.d3d12.command_queue"
    PROP_RENDERER_VULKAN_INSTANCE_POINTER                   = cstring"SDL.renderer.vulkan.instance"
    PROP_RENDERER_VULKAN_SURFACE_NUMBER                     = cstring"SDL.renderer.vulkan.surface"
    PROP_RENDERER_VULKAN_PHYSICAL_DEVICE_POINTER            = cstring"SDL.renderer.vulkan.physical_device"
    PROP_RENDERER_VULKAN_DEVICE_POINTER                     = cstring"SDL.renderer.vulkan.device"
    PROP_RENDERER_VULKAN_GRAPHICS_QUEUE_FAMILY_INDEX_NUMBER = cstring"SDL.renderer.vulkan.graphics_queue_family_index"
    PROP_RENDERER_VULKAN_PRESENT_QUEUE_FAMILY_INDEX_NUMBER  = cstring"SDL.renderer.vulkan.present_queue_family_index"
    PROP_RENDERER_VULKAN_SWAPCHAIN_IMAGE_COUNT_NUMBER       = cstring"SDL.renderer.vulkan.swapchain_image_count"
    PROP_RENDERER_GPU_DEVICE_POINTER                        = cstring"SDL.renderer.gpu.device"

  TextureCreateProperty* = enum
    PROP_TEXTURE_CREATE_COLORSPACE_NUMBER           = cstring"SDL.texture.colorspace"
    PROP_TEXTURE_CREATE_FORMAT_NUMBER               = cstring"SDL.texture.format"
    PROP_TEXTURE_CREATE_ACCESS_NUMBER               = cstring"SDL.texture.access"
    PROP_TEXTURE_CREATE_WIDTH_NUMBER                = cstring"SDL.texture.width"
    PROP_TEXTURE_CREATE_HEIGHT_NUMBER               = cstring"SDL.texture.height"
    PROP_TEXTURE_SDR_WHITE_POINT_FLOAT              = cstring"SDL.texture.SDR_white_point"
    PROP_TEXTURE_HDR_HEADROOM_FLOAT                 = cstring"SDL.texture.HDR_headroom"
    PROP_TEXTURE_CREATE_D3D11_TEXTURE_POINTER       = cstring"SDL.texture.d3d11.texture"
    PROP_TEXTURE_CREATE_D3D11_TEXTURE_U_POINTER     = cstring"SDL.texture.d3d11.texture_u"
    PROP_TEXTURE_CREATE_D3D11_TEXTURE_V_POINTER     = cstring"SDL.texture.d3d11.texture_v"
    PROP_TEXTURE_CREATE_D3D12_TEXTURE_POINTER       = cstring"SDL.texture.d3d12.texture"
    PROP_TEXTURE_CREATE_D3D12_TEXTURE_U_POINTER     = cstring"SDL.texture.d3d12.texture_u"
    PROP_TEXTURE_CREATE_D3D12_TEXTURE_V_POINTER     = cstring"SDL.texture.d3d12.texture_v"
    PROP_TEXTURE_CREATE_OPENGL_TEXTURE_NUMBER       = cstring"SDL.texture.opengl.texture"
    PROP_TEXTURE_CREATE_OPENGL_TEXTURE_UV_NUMBER    = cstring"SDL.texture.opengl.texture_uv"
    PROP_TEXTURE_CREATE_OPENGL_TEXTURE_U_NUMBER     = cstring"SDL.texture.opengl.texture_u"
    PROP_TEXTURE_CREATE_OPENGL_TEXTURE_V_NUMBER     = cstring"SDL.texture.opengl.texture_v"
    PROP_TEXTURE_OPENGL_TEXTURE_TARGET_NUMBER       = cstring"SDL.texture.opengl.target"
    PROP_TEXTURE_OPENGL_TEX_W_FLOAT                 = cstring"SDL.texture.opengl.tex_w"
    PROP_TEXTURE_OPENGL_TEX_H_FLOAT                 = cstring"SDL.texture.opengl.tex_h"
    PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_NUMBER    = cstring"SDL.texture.opengles2.texture"
    PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_UV_NUMBER = cstring"SDL.texture.opengles2.texture_uv"
    PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_U_NUMBER  = cstring"SDL.texture.opengles2.texture_u"
    PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_V_NUMBER  = cstring"SDL.texture.opengles2.texture_v"
    PROP_TEXTURE_CREATE_VULKAN_TEXTURE_NUMBER       = cstring"SDL.texture.vulkan.texture"

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

# XXX:
# define SDL_RENDERER_VSYNC_DISABLED 0
#define SDL_RENDERER_VSYNC_ADAPTIVE (-1)

const
  DEBUG_TEXT_FONT_CHARACTER_SIZE* = 8
    ##  The size, in pixels, of a single `RenderDebugText` character.

# --------------------------------------------------------------------------- #
#   Sanity checks                                                             #
# --------------------------------------------------------------------------- #

# when defined(gcc) and hostCPU == "amd64":
#   when RendererInfo.sizeof != 88:
#     {.fatal: "invalid RendererInfo size: " & $RendererInfo.sizeof.}

# vim: set sts=2 et sw=2:
