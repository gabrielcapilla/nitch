import std/[os, strutils]

proc getDistroId*(): string =
  const path = "/etc/os-release"
  if not fileExists(path):
    return "unknown"

  try:
    let f = open(path)
    defer:
      f.close()

    var line = ""
    while f.readLine(line):
      if line.startsWith("ID="):
        var idVal = line[3 ..^ 1]
        idVal.removePrefix('"')
        idVal.removeSuffix('"')
        return
          if idVal.len > 0:
            idVal.toLowerAscii()
          else:
            "unknown"
  except CatchableError:
    return "unknown"

  return "unknown"
