# Package info.
version       = "0.9.11"
author        = "Amun"
description   = "High level SDL 3.0 shared library wrapper"
license       = "NCSA OR MIT OR Zlib"
srcDir        = "src"

# Dependencies.
# requires "https://github.com/amnr/dlutils"
requires "dlutils >= 2.0.0"

import std/os
import std/strformat
from std/algorithm import sorted
from std/sequtils import toSeq

task examples, "build examples":
  const optflags = when defined release: " -d=release --opt=speed" else: ""
  for entry in (thisDir() / "examples").walkDir.toSeq.sorted:
    if entry.kind == pcFile and entry.path.endswith ".nim":
      # exec "nimble" & optflags & " --silent c " & entry.path
      exec "nimble" & optflags & " c " & entry.path

task gendoc, "build documentation":
  const
    project = projectName()
    docdir  = "/tmp/nimdoc/" & project
    docopts = "--hint=Conf=off --hint=SuccessX=off --github.commit=master"
  var ghopts = ""
  if "GITHUB_BASEURL".getEnv != "":
    ghopts = &" --github.url=" & "GITHUB_BASEURL".getEnv & "/{project}"
  let mainfile = thisDir() / srcDir / &"{project}.nim"
  if not docdir.dirExists:
    mkDir docdir
  exec &"nim doc {docopts} {ghopts} --index=on --project -o={docdir} {mainfile}"
  if "rrep".findExe != "":
    exec &"mv -f '{docdir}/{project}.html' '{docdir}/index.html'"
    # Remove src prefix.
    exec &"rrep -rq src/ '' {docdir}"
    # Fix searchbox link in main module.
    exec &"rrep -rq '{project}.html#' '#' {docdir}"
    # Fix main module link in theindex.html.
    exec &"rrep -rq '\"{project}.html\"' index.html {docdir}"
  else:
    echo "Warning: rrep not installed; patching not peformed"

# vim: set sts=2 et sw=2:
