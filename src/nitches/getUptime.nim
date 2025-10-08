import std/[os, strutils]

proc getUptime*(): string =
  if fileExists("/proc/uptime"):
    try:
      let uptimeSeq: seq[string] = readFile("/proc/uptime").split(".")
      if uptimeSeq.len > 0:
        let
          uptimeSeconds: int = parseInt(uptimeSeq[0])
          uptimeHours: int = uptimeSeconds div 3600
          uptimeMinutes: int = uptimeSeconds mod 3600 div 60

        if uptimeHours != 0:
          result = $(uptimeHours) & "h " & $(uptimeMinutes) & "m"
        else:
          result = $(uptimeMinutes) & "m"
      else:
        result = "0m"
    except ValueError, IOError, OSError:
      result = "0m"
  else:
    result = "0m"
