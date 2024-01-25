##  SDL3 config.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

const
  ndoc = defined nimdoc

const
  use_audio*      {.booldefine: "sdl3.audio"      .}  = true or ndoc
    ##  Include audio functions.

  use_blendmode*  {.booldefine: "sdl3.blendmode"  .}  = true or ndoc
    ##  Include blend mode functions.

  use_clipboard*  {.booldefine: "sdl3.clipboard"  .}  = true or ndoc
    ##  Include clipboard functions.

  use_gamepad*    {.booldefine: "sdl3.gamepad"    .}  = true or ndoc
    ##  Include gamepad functions.

  use_haptic*     {.booldefine: "sdl3.haptic"     .}  = true or ndoc
    ##  Include haptic functions.

  use_hidapi*     {.booldefine: "sdl3.hidapi"     .}  = true or ndoc
    ##  Include HID API functions.

  use_hints*      {.booldefine: "sdl3.hints"      .}  = true or ndoc
    ##  Include hits functions.

  use_joystick*   {.booldefine: "sdl3.joystick"   .}  = true or ndoc
    ##  Include joystick functions.

  use_keyboard*   {.booldefine: "sdl3.keyboard"   .}  = true or ndoc
    ##  Include keyboard functions.

  use_messagebox* {.booldefine: "sdl3.messagebox" .}  = true or ndoc
    ##  Include message box functions.

  use_mouse*      {.booldefine: "sdl3.mouse"      .}  = true or ndoc
    ##  Include mouse functions.

  use_pen*        {.booldefine: "sdl3.pen"        .}  = true or ndoc
    ##  Include pen functions.

  use_properties* {.booldefine: "sdl3.properties" .}  = true or ndoc
    ##  Include properties functions.

  use_sensor*     {.booldefine: "sdl3.sensor"     .}  = true or ndoc
    ##  Include sensor functions.

  use_touch*      {.booldefine: "sdl3.touch"      .}  = true or ndoc
    ##  Include touch functions.

  use_vulkan*     {.booldefine: "sdl3.vulkan"     .}  = true or ndoc
    ##  Include Vulkan functions.

# vim: set sts=2 et sw=2:
