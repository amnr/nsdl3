##  Rect definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

const
  # SDL_stdinc.h.
  FLT_EPSILON = 1.1920928955078125e-07f

type
  Point* {.bycopy, final, pure.} = object
    ##  Point (integer).
    x*  : cint
    y*  : cint

  FPoint* {.bycopy, final, pure.} = object
    ##  Point (floating point).
    x*  : cfloat
    y*  : cfloat

func init*(T: typedesc[FPoint], x: float, y: float): T {.inline.} =
  T(x: x.cfloat, y: y.cfloat)

func init*(T: typedesc[FPoint], x: int, y: int): T {.inline.} =
  T(x: x.cfloat, y: y.cfloat)

type
  Rect* {.bycopy, final, pure.} = object
    ##  Rectangle (integer).
    x*  : cint
    y*  : cint
    w*  : cint
    h*  : cint

func init*(T: typedesc[Rect], x, y: int, w, h: int): T {.inline.} =
  T(x: x.cint, y: y.cint, w: w.cint, h: h.cint)

type
  FRect* {.bycopy, final, pure.} = object
    ##  Rectangle (floating point).
    x*  : cfloat
    y*  : cfloat
    w*  : cfloat
    h*  : cfloat

func init*(T: typedesc[FRect], x, y, w, h: float): T {.inline.} =
  T(x: x.cfloat, y: y.cfloat, w: w.cfloat, h: h.cfloat)

func init*(T: typedesc[FRect], x, y, w, h: int): T {.inline.} =
  T(x: x.cfloat, y: y.cfloat, w: w.cfloat, h: h.cfloat)

func point_in_rect*(p: Point, r: Rect): bool {.inline.} =
  ##  Return `true` if point resides inside a rectangle.
  (p.x >= r.x) and (p.x < (r.x + r.w)) and
  (p.y >= r.y) and (p.y < (r.y + r.h))

func rect_empty*(r: ptr Rect): bool {.inline.} =
  ##  Return `true` if the rectangle has no area.
  (r == nil) or (r.w <= 0) or (r.h <= 0)

func rect_empty*(r: Rect): bool {.inline.} =
  ##  Return `true` if the rectangle has no area.
  (r.w <= 0) or (r.h <= 0)

func rect_equals*(a, b: ptr Rect): bool {.inline.} =
  ##  Return `true` if the two rectangles are equal.
  (a != nil) and (b != nil) and
  (a.x == b.x) and (a.y == b.y) and
  (a.w == b.w) and (a.h == b.h)

func point_in_rect_float*(p: ptr FPoint, r: ptr FRect): bool {.inline.} =
  ##  Return `true` if point resides inside a rectangle.
  (p.x >= r.x) and (p.x <= (r.x + r.w)) and (p.y >= r.y) and (p.y <= (r.y + r.h))

func rect_empty_float*(r: ptr FRect): bool {.inline.} =
  ##  Return `true` if the rectangle has no area.
  (r == nil) or (r.w < 0.0f) or (r.h < 0.0f)

func rects_equal_epsilon*(a, b: ptr FRect, epsilon: cfloat): bool {.inline.} =
  (a != nil) and (b != nil) and ((a == b) or
  ((abs(a.x - b.x) <= epsilon) and
   (abs(a.y - b.y) <= epsilon) and
   (abs(a.w - b.w) <= epsilon) and
   (abs(a.h - b.h) <= epsilon)))

func rects_equal_float*(a, b: ptr FRect): bool {.inline.} =
  rects_equal_epsilon(a, b, FLT_EPSILON)

# vim: set sts=2 et sw=2:
