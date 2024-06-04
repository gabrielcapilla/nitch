import
  std/[strutils, osproc]

proc getXbpsPkgs*(): string =
  let
    count: string = osproc.execCmdEx("xbps-query -l")[0]

  result = $(count.split("\n").len - 1)