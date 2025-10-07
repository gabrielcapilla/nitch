import std/osproc

proc getRpmPkgs*(): string =
  try:
    let (count, exitCode): (string, int) = osproc.execCmdEx("rpm -qa | wc -l")
    if exitCode == 0:
      if count.len > 0:
        result = count[0 .. ^2]
      else:
        result = "0"
    else:
      result = "0"
  except OSError, IOError:
    result = "0"
