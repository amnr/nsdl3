##  Log definitions.
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  LogCategory* {.size: cint.sizeof.} = enum
    ##  Log category.
    LOG_CATEGORY_APPLICATION
    LOG_CATEGORY_ERROR
    LOG_CATEGORY_ASSERT
    LOG_CATEGORY_SYSTEM
    LOG_CATEGORY_AUDIO
    LOG_CATEGORY_VIDEO
    LOG_CATEGORY_RENDER
    LOG_CATEGORY_INPUT
    LOG_CATEGORY_TEST

    LOG_CATEGORY_RESERVED1
    LOG_CATEGORY_RESERVED2
    LOG_CATEGORY_RESERVED3
    LOG_CATEGORY_RESERVED4
    LOG_CATEGORY_RESERVED5
    LOG_CATEGORY_RESERVED6
    LOG_CATEGORY_RESERVED7
    LOG_CATEGORY_RESERVED8
    LOG_CATEGORY_RESERVED9
    LOG_CATEGORY_RESERVED10

    LOG_CATEGORY_CUSTOM

  LogPriority* {.size: cint.sizeof.} = enum
    ##  Log priority.
    LOG_PRIORITY_VERBOSE = 1
    LOG_PRIORITY_DEBUG
    LOG_PRIORITY_INFO
    LOG_PRIORITY_WARN
    LOG_PRIORITY_ERROR
    LOG_PRIORITY_CRITICAL

  LogOutputFunction* = proc (userdata: pointer, category: LogCategory,
                             priority: LogPriority,
                             message: cstring) {.cdecl, gcsafe, raises: [].}

# vim: set sts=2 et sw=2:
