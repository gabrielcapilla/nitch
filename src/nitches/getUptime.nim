import std/[os, parseutils]

proc getUptime*(): string =
  const path = "/proc/uptime"
  if fileExists(path):
    try:
      var buffer = newString(64)
      let f = open(path)
      let len = f.readBuffer(addr buffer[0], 64)
      f.close()

      buffer.setLen(len)

      if len > 0:
        var uptimeFloat: float
        if parseFloat(buffer, uptimeFloat) > 0:
          let
            uptimeSeconds = int(uptimeFloat)
            uptimeHours = uptimeSeconds div 3600
            uptimeMinutes = (uptimeSeconds mod 3600) div 60

          if uptimeHours != 0:
            return $uptimeHours & "h " & $uptimeMinutes & "m"
          else:
            return $uptimeMinutes & "m"
    except CatchableError:
      discard

  return "0m"
