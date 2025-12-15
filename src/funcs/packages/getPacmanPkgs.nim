import std/os

proc getPacmanPkgs*(): string =
  const packagesDir = "/var/lib/pacman/local"
  if not dirExists(packagesDir):
    return "0"

  var count = 0
  try:
    for kind, _ in walkDir(packagesDir, relative = true):
      if kind == pcDir:
        inc count

    if count > 0:
      dec count
  except CatchableError:
    return "0"

  return $count
