##  Timer definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

# Time constants.
const
  MS_PER_SECOND*    = 1000
  US_PER_SECOND*    = 1000_000
  NS_PER_SECOND*    = 1000_000_000
  NS_PER_MS*        = 1000_000
  NS_PER_US*        = 1000

func ms_to_ns*[T: SomeInteger](ms: T): uint64 {.inline.} =
  ms.uint64 * NS_PER_MS

func ns_to_ms*[T: SomeInteger](ns: T): T {.inline.} =
  ns div NS_PER_MS

func us_to_ns*[T: SomeInteger](us: T): uint64 {.inline.} =
  us.uint64 * NS_PER_US

func ns_to_us*[T: SomeInteger](ns: T): T {.inline.} =
  ns div NS_PER_US

type
  TimerCallback* = proc (interval: uint32,
                         param: pointer): uint32 {.cdecl, gcsafe, raises: [].}

  TimerID* = distinct uint32
    ##  Timer ID.

# vim: set sts=2 et sw=2:
