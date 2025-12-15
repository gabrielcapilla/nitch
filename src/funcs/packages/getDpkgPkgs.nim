import std/[os, strutils]

proc getDpkgPkgs*(): string =
  const statusFile = "/var/lib/dpkg/status"
  if not fileExists(statusFile):
    return "0"

  var count = 0
  try:
    let f = open(statusFile)
    defer:
      f.close()

    var line = ""
    while f.readLine(line):
      if line.startsWith("Status: install ok installed"):
        inc count
  except CatchableError:
    return "0"

  return $count
