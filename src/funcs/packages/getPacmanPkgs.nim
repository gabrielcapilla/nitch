import std/[os, sequtils]

proc getPacmanPkgs*(): string =
  let packagesDir: string = "/var/lib/pacman/local"
  try:
    if dirExists(packagesDir):
      let filesInPath: seq[tuple] = toSeq(walkDir(packagesDir, relative = true))
      result = $(filesInPath.len - 1)
    else:
      result = "0"
  except OSError, IOError:
    result = "0"
