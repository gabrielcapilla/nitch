import std/[os, strutils]

proc getDistro*(): string =
  const path = "/etc/os-release"
  if not fileExists(path):
    return "Unknown Distro"

  try:
    let f = open(path)
    defer:
      f.close()

    var line = ""
    while f.readLine(line):
      if line.startsWith("PRETTY_NAME="):
        var name = line[12 ..^ 1]
        name.removePrefix('"')
        name.removeSuffix('"')
        return if name.len > 0: name else: "Unknown Distro"
  except CatchableError:
    return "Unknown Distro"

  return "Unknown Distro"
