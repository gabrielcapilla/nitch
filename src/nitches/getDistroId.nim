import std/[os, parsecfg]

proc getDistroId*(): string =
  try:
    if fileExists("/etc/os-release"):
      let osRelease: Config = loadConfig("/etc/os-release")
      result = osRelease.getSectionValue("", "ID")
    else:
      result = "unknown"
  except IOError, OSError, ValueError, Exception:
    result = "unknown"
