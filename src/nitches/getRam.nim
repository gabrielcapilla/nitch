import std/[os, strutils]

proc getMemoryInfo(): (int, int) =
  if fileExists("/proc/meminfo"):
    try:
      let fileSeq: seq[string] = readLines("/proc/meminfo", 3)
      if fileSeq.len >= 3:
        let
          memTotalSeq: seq[string] = fileSeq[0].split(" ")
          memAvailableSeq: seq[string] = fileSeq[2].split(" ")

        if memTotalSeq.len > 0 and memAvailableSeq.len > 0:
          let
            memTotalInt: int = parseInt(memTotalSeq[^2]) div 1024
            memAvailableInt: int = parseInt(memAvailableSeq[^2]) div 1024

          return (memTotalInt, memAvailableInt)
    except IOError, OSError, ValueError:
      discard
  return (0, 0)

proc getRam*(): string =
  let
    (memTotalInt, memAvailableInt) = getMemoryInfo()
    memUsedInt: int = memTotalInt - memAvailableInt

  if memTotalInt > 0:
    result = $memUsedInt & " | " & $memTotalInt & " MiB"
  else:
    result = "0 | 0 MiB"
