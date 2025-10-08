import std/[os, strutils]

func getShell*(): string =
  try:
    let shellPath: string = getEnv("SHELL")
    if shellPath.len > 0:
      let shellSeq: seq[string] = shellPath.split("/")
      if shellSeq.len > 0:
        let
          shellName: string = shellSeq[^1]
        result = if shellName.len > 0: shellName else: "unknown"
      else:
        result = "unknown"
    else:
      result = "unknown"
  except:
    result = "unknown"
