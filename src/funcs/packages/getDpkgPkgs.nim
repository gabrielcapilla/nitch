import std/[osproc, strutils]

proc getDpkgPkgs*(): string =
  try:
    let
      count: string = osproc.execCmdEx("dpkg -l")[0]
      lineCount: int = count.split("\n").len - 1
    result = $lineCount
  except OSError, IOError:
    result = "0"
