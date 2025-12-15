import std/os
import funcs/perform

proc main() =
  let count = paramCount()

  if count == 0:
    showFetch()
    return

  for i in 1 .. count:
    let arg = paramStr(i)
    case arg
    of "-n", "--nologo":
      showFetchNoLogo()
      return
    of "-h", "--help":
      showHelp()
      return
    of "-v", "--version":
      showVersion()
      return
    of "-f", "--fetch":
      showFetch()
      return
    else:
      discard

  showFetch()

when isMainModule:
  main()
