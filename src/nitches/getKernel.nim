import std/[os, strutils]

proc getKernel*(): string =
  try:
    if fileExists("/proc/version"):
      let
        version: string = readAll(open("/proc/version"))
        kernelVersion: seq[string] = version.split(" ")
      if kernelVersion.len > 2:
        result = kernelVersion[2]
      else:
        result = "unknown"
    else:
      result = "unknown"
  except IOError, OSError:
    result = "unknown"
