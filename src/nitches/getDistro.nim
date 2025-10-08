import std/[os, parsecfg]

proc getDistro*(): string =
  if fileExists("/etc/os-release"):
    try:
      let
        osRelease: Config = loadConfig("/etc/os-release")
        distroName: string = osRelease.getSectionValue("", "PRETTY_NAME")
      result = if distroName.len > 0: distroName else: "Unknown Distro"
    except IOError, OSError, ValueError, Exception:
      result = "Unknown Distro"
  else:
    result = "Unknown Distro"
