import std/strutils

proc getMemoryInfo(): (int, int) =
  let
    fileSeq = readLines("/proc/meminfo", 3)
    memTotalSeq = fileSeq[0].split(" ")
    memAvailableSeq = fileSeq[2].split(" ")

  let
    memTotalInt = parseInt(memTotalSeq[^2]) div 1024
    memAvailableInt = parseInt(memAvailableSeq[^2]) div 1024

  return (memTotalInt, memAvailableInt)

proc getRam*(): string =
  let
    (memTotalInt, memAvailableInt) = getMemoryInfo()
    memUsedInt = memTotalInt - memAvailableInt

  result = $memUsedInt & " | " & $memTotalInt & " MiB"