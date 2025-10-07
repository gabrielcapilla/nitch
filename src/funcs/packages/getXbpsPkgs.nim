import std/[osproc, strutils]

proc getXbpsPkgs*(): string =
  try:
    let count: string = osproc.execCmdEx("xbps-query -l")[0]
    let lineCount: int = count.split("\n").len - 1
    result = $lineCount
  except OSError, IOError:
    result = "0"
