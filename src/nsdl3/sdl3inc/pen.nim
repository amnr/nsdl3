##  Pen event definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

from mouse import MouseID

type
  PenID* = distinct uint32
    ##  `PenIDs` identify pens uniquely within a session.

const
  PEN_INVALID*  = PenID 0     ##  Reserved invalid `PenID` is valid.

  PEN_MOUSEID*  = cast[MouseID](-2)
    ##  Device ID for mouse events triggered by pen events.

  PEN_INFO_UNKNOWN* = -1
    ##  Marks unknown information when querying the pen.

type
  PenAxis* {.size: cint.sizeof.} = enum
    ##  Pen axis indices.
    PEN_AXIS_PRESSURE = 0     ##  Pen pressure.  Unidirectional: 0..1.0.
    PEN_AXIS_XTILT            ##  Pen horizontal tilt angle.  Bidirectional: -90.0..90.0 (left-to-right).
                              ##  The physical max/min tilt may be smaller than -90.0 / 90.0, cf. `PenCapabilityInfo`.
    PEN_AXIS_YTILT            ##  Pen vertical tilt angle.  Bidirectional: -90.0..90.0 (top-to-down).
                              ##  The physical max/min tilt may be smaller than -90.0 / 90.0, cf. `PenCapabilityInfo`.
    PEN_AXIS_DISTANCE         ##  Pen distance to drawing surface.  Unidirectional: 0.0..1.0.
    PEN_AXIS_ROTATION         ##  Pen barrel rotation.  Bidirectional: -180..179.9 (clockwise, 0 is facing up, -180.0 is facing down).
    PEN_AXIS_SLIDER           ##  Pen finger wheel or slider (e.g., Airbrush Pen).  Unidirectional: 0..1.0.

const
  PEN_NUM_AXES* = PEN_AXIS_SLIDER.int + 1   ##  Last valid axis index.

const
  PEN_AXIS_LAST*  = int PEN_NUM_AXES - 1    ##  Last axis index plus 1.

# Pen flags.  These share a bitmask space with `BUTTON_LEFT` and friends.
#define SDL_PEN_FLAG_DOWN_BIT_INDEX   13 /* Bit for storing that pen is touching the surface */
#define SDL_PEN_FLAG_INK_BIT_INDEX    14 /* Bit for storing has-non-eraser-capability status */
#define SDL_PEN_FLAG_ERASER_BIT_INDEX 15 /* Bit for storing is-eraser or has-eraser-capability property */
#define SDL_PEN_FLAG_AXIS_BIT_OFFSET  16 /* Bit for storing has-axis-0 property */

#define SDL_PEN_CAPABILITY(capbit)    (1ul << (capbit))
#define SDL_PEN_AXIS_CAPABILITY(axis) SDL_PEN_CAPABILITY((axis) + SDL_PEN_FLAG_AXIS_BIT_OFFSET)

# Pen tips.
#define SDL_PEN_TIP_INK    SDL_PEN_FLAG_INK_BIT_INDEX     ##  Regular pen tip (for drawing) touched the surface */
#define SDL_PEN_TIP_ERASER SDL_PEN_FLAG_ERASER_BIT_INDEX  ##  Eraser pen tip touched the surface */

#  * \defgroup SDL_PEN_CAPABILITIES Pen capabilities
#  * Pen capabilities reported by ::SDL_GetPenCapabilities
#define SDL_PEN_DOWN_MASK          SDL_PEN_CAPABILITY(SDL_PEN_FLAG_DOWN_BIT_INDEX)   ##  Pen tip is currently touching the drawing surface. */
#define SDL_PEN_INK_MASK           SDL_PEN_CAPABILITY(SDL_PEN_FLAG_INK_BIT_INDEX)    ##  Pen has a regular drawing tip (::SDL_GetPenCapabilities).  For events (::SDL_PenButtonEvent, ::SDL_PenMotionEvent, ::SDL_GetPenStatus) this flag is mutually exclusive with ::SDL_PEN_ERASER_MASK .  */
#define SDL_PEN_ERASER_MASK        SDL_PEN_CAPABILITY(SDL_PEN_FLAG_ERASER_BIT_INDEX) ##  Pen has an eraser tip (::SDL_GetPenCapabilities) or is being used as eraser (::SDL_PenButtonEvent , ::SDL_PenMotionEvent , ::SDL_GetPenStatus)  */
#define SDL_PEN_AXIS_PRESSURE_MASK SDL_PEN_AXIS_CAPABILITY(SDL_PEN_AXIS_PRESSURE)    ##  Pen provides pressure information in axis ::SDL_PEN_AXIS_PRESSURE */
#define SDL_PEN_AXIS_XTILT_MASK    SDL_PEN_AXIS_CAPABILITY(SDL_PEN_AXIS_XTILT)       ##  Pen provides horizontal tilt information in axis ::SDL_PEN_AXIS_XTILT */
#define SDL_PEN_AXIS_YTILT_MASK    SDL_PEN_AXIS_CAPABILITY(SDL_PEN_AXIS_YTILT)       ##  Pen provides vertical tilt information in axis ::SDL_PEN_AXIS_YTILT */
#define SDL_PEN_AXIS_DISTANCE_MASK SDL_PEN_AXIS_CAPABILITY(SDL_PEN_AXIS_DISTANCE)    ##  Pen provides distance to drawing tablet in ::SDL_PEN_AXIS_DISTANCE */
#define SDL_PEN_AXIS_ROTATION_MASK SDL_PEN_AXIS_CAPABILITY(SDL_PEN_AXIS_ROTATION)    ##  Pen provides barrel rotation information in axis ::SDL_PEN_AXIS_ROTATION */
#define SDL_PEN_AXIS_SLIDER_MASK   SDL_PEN_AXIS_CAPABILITY(SDL_PEN_AXIS_SLIDER)      ##  Pen provides slider / finger wheel or similar in axis ::SDL_PEN_AXIS_SLIDER */

#define SDL_PEN_AXIS_BIDIRECTIONAL_MASKS (SDL_PEN_AXIS_XTILT_MASK | SDL_PEN_AXIS_YTILT_MASK)
##  Masks for all axes that may be bidirectional.

type
  PenSubtype* {.size: cint.sizeof.} = enum
    ##  Pen types.
    ##
    ##  Some pens identify as a particular type of drawing device (e.g., an airbrush or a pencil).
    PEN_TYPE_UNKNOWN = 0
    PEN_TYPE_ERASER = 1     ##  Eraser.
    PEN_TYPE_PEN            ##  Generic pen; this is the default.
    PEN_TYPE_PENCIL         ##  Pencil.
    PEN_TYPE_BRUSH          ##  Brush-like device.
    PEN_TYPE_AIRBRUSH       ##  Airbrush device that "sprays" ink.

const
  PEN_TYPE_LAST* = PEN_TYPE_AIRBRUSH.int + 1    ##  Last valid pen type.

type
  PenCapabilityInfo* {.final, pure.} = object
    ##  Pen capabilities, as reported by `get_pen_capabilities()`.
    max_tilt*     : cfloat    ##  Physical maximum tilt angle, for XTILT and YTILT, or `PEN_INFO_UNKNOWN`. Pens cannot typically tilt all the way to 90 degrees, so this value is usually less than 90.0.
    wacom_id*     : uint32    ##  For Wacom devices: wacom tool type ID, otherwise 0 (useful e.g. with libwacom).
    num_buttons*  : int8      ##  Number of pen buttons (not counting the pen tip), or `PEN_INFO_UNKNOWN`.

# vim: set sts=2 et sw=2:
