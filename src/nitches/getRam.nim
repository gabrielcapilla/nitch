import std/[os, parseutils, strutils]

proc getRam*(): string =
  const path = "/proc/meminfo"
  if not fileExists(path):
    return "0 | 0 MiB"

  try:
    let f = open(path)
    var s = newString(512)
    let len = f.readBuffer(addr s[0], 512)
    f.close()

    s.setLen(len)

    if len > 0:
      var
        total = 0
        avail = 0
        val = 0

      let totalIdx = s.find("MemTotal:")
      if totalIdx != -1:
        var curr = totalIdx + 9
        curr += skipWhitespace(s, curr)
        discard parseInt(s, val, curr)
        total = val

      let availIdx = s.find("MemAvailable:")
      if availIdx != -1:
        var curr = availIdx + 13
        curr += skipWhitespace(s, curr)
        discard parseInt(s, val, curr)
        avail = val

      if total > 0:
        let totalMiB = total div 1024
        let usedMiB = (total - avail) div 1024
        return $usedMiB & " | " & $totalMiB & " MiB"
  except CatchableError:
    discard

  return "0 | 0 MiB"
