# config.nims.

switch "hint", "name:off"
switch "spellSuggest", "auto"
switch "styleCheck", "hint"

when defined mingw32:
  switch "define", "windows"

  switch "cpu", "i386"
  switch "os", "windows"

  switch "i386.windows.gcc.exe", "i686-w64-mingw32-gcc"
  switch "i386.windows.cpp.exe", "i686-w64-mingw32-g++"
  switch "i386.windows.gcc.linkerexe", "i686-w64-mingw32-gcc"
  switch "i386.windows.cpp.linkerexe", "i686-w64-mingw32-g++"

  # No -ldl.
  switch "gcc.options.linker", "-Wl,-Bstatic -lpthread"
  switch "gcc.cpp.options.linker", ""
elif defined mingw64:
  switch "define", "windows"

  switch "cpu", "amd64"
  switch "os", "windows"

  switch "amd64.windows.gcc.exe", "x86_64-w64-mingw32-gcc"
  switch "amd64.windows.cpp.exe", "x86_64-w64-mingw32-g++"
  switch "amd64.windows.gcc.linkerexe", "x86_64-w64-mingw32-gcc"
  switch "amd64.windows.cpp.linkerexe", "x86_64-w64-mingw32-g++"

  # No -ldl.
  switch "gcc.options.linker", "-Wl,-Bstatic -lpthread"
  switch "gcc.cpp.options.linker", ""

when defined sanitize:
  switch "passc", "-fsanitize=address,undefined"
  switch "passl", "-lasan -lubsan"

# vim: set sts=2 et sw=2:
