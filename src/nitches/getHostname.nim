import std/[os, strutils]

proc getHostname*(): string =
  try:
    if fileExists("/etc/hostname"):
      let lines: seq[string] = readLines("/etc/hostname", 1)
      if lines.len > 0:
        result = lines[0].strip()
      else:
        result = "hostname unknown"
    else:
      result = "hostname unknown"
  except IOError, OSError:
    result = "hostname unknown"
