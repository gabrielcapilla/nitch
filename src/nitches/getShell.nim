import std/[strutils, os]

func getShell*(): string =
  let
    shellPath = getEnv("SHELL")
    shellSeq = shellPath.split("/")

  shellSeq[^1]