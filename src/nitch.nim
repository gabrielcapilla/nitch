import std/parseopt
import funcs/perform

type ArgType = enum
  ArgNormal
  ArgNoLogo
  ArgHelp
  ArgVersion

proc parseCommandLineArgs(): ArgType =
  var parser: OptParser = initOptParser()
  result = ArgNormal

  const optionMap: array[8, tuple[key: string, value: ArgType]] = [
    ("f", ArgNormal),
    ("fetch", ArgNormal),
    ("n", ArgNoLogo),
    ("nologo", ArgNoLogo),
    ("h", ArgHelp),
    ("help", ArgHelp),
    ("v", ArgVersion),
    ("version", ArgVersion),
  ]

  try:
    while true:
      parser.next()
      case parser.kind
      of cmdEnd:
        break
      of cmdShortOption, cmdLongOption:
        for opt in optionMap:
          if parser.key == opt.key:
            return opt.value
        return ArgNormal
      of cmdArgument:
        return ArgNormal
  except CatchableError:
    return ArgNormal

proc main() =
  let argType: ArgType = parseCommandLineArgs()

  case argType
  of ArgNormal:
    arg0()
  of ArgNoLogo:
    arg3()
  of ArgHelp:
    arg1()
  of ArgVersion:
    arg2()

when isMainModule:
  main()
