import std/os
import flags/argParser
import funcs/perform

proc main() =
  let args: seq[string] = commandLineParams()
  let argCount: int = paramCount()
  let arg: int = argParser(args, argCount)

  case arg:
  of 0:
    arg0()
  of 1:
    arg1()
  of 2:
    arg2()
  else:
    arg0()

main()
