##  Power management definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  PowerState* {.size: cint.sizeof.} = enum    # XXX: TODO: check size.
    ##  Power state.
    POWERSTATE_UNKNOWN
    POWERSTATE_ON_BATTERY
    POWERSTATE_NO_BATTERY
    POWERSTATE_CHARGING
    POWERSTATE_CHARGED

# vim: set sts=2 et sw=2:
