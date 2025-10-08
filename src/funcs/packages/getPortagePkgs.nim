import std/[osproc, strutils]

proc getPortagePkgs*(): string =
  try:
    let
      count: string = osproc.execCmdEx("ls -d /var/db/pkg/*/*| cut -f5- -d/")[0]
      lineCount: int = count.split("\n").len - 1
    result = $lineCount
  except OSError, IOError:
    result = "0"
