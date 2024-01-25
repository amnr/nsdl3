##  SDL ABI utils.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

when defined uselogging:
  import std/logging
import std/macros

const
  uselogging {.booldefine.} = false

when uselogging:
  template log_error*(args: varargs[typed, `$`]) =
    try:
      unpackVarargs echo, "ERROR: SDL3: ", args
    except Exception:
      discard
else:
  template log_error*(args: varargs[typed, `$`]) =
    unpackVarargs echo, "ERROR: SDL3: ", args

macro available_since*(procvar: typed, minver: string) =
  ##  Check whether unchecked function is available.
  ##
  ##  If the function is not available, the default value of return type
  ##  is returned.
  let procname = $procvar
  return quote do:
    if `procvar` == nil:
      log_error `procname`, " is available since SDL ", `minver`
      return result.type.default

template ensure_not_nil*(procname: string, body: untyped) =
  when result.typeof isnot ptr:
    {.fatal: "ensure_not_nil requires function that returns pointer".}
  result = body
  if unlikely result == nil:
    log_error procname, " failed: ", $SDL_GetError()
    return nil

template ensure_natural*(procname: string, body: untyped) =
  result = body
  if unlikely result < 0:
    log_error procname, " failed: ", $SDL_GetError()

template ensure_positive*(procname: string, body: untyped) =
  result = body
  if unlikely result <= 0:
    log_error procname, " failed: ", $SDL_GetError()

# XXX:
#[
template ensure_true(procname: string, body: untyped) =
  when result.typeof isnot bool:
    {.fatal: "ensure_true requires function that returns bool".}
  result = body
  if unlikely result.not:
    log_error procname, " failed: ", $SDL_GetError()
]#

template ensure_zero*(procname: string, body: untyped) =
  let res {.inject.} = body
  if unlikely res != 0:
    log_error procname, " failed: ", $SDL_GetError()
    result = false
  else:
    result = true

# vim: set sts=2 et sw=2:
